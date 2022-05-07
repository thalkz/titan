package main

import (
	"flag"
	"fmt"
	"io"
	"log"
	"net"
	"time"

	"google.golang.org/grpc"
	combat "thalkz.com/titan/combat/protos"
)

var (
	port                   = flag.Int("port", 50051, "The server port")
	joinChannel            = make(chan string)
	leftChannel            = make(chan string)
	attackChannel          = make(chan string)
	titanIndex       int   = 1
	titanHp          int32 = 10000
	connectedPlayers       = make(map[string]bool)
)

type combatServer struct {
	combat.UnimplementedCombatServer
}

func combatHandler() error {
	for {
		select {
		case id := <-joinChannel:
			log.Printf("%v joined (total=%v)\n", id, len(connectedPlayers))
			connectedPlayers[id] = true

		case id := <-leftChannel:
			if connectedPlayers[id] {
				log.Printf("%v left (total=%v)\n", id, len(connectedPlayers))
				delete(connectedPlayers, id)
				if len(connectedPlayers) == 0 {
					log.Println("All players left combat")
				}
			}

		case id := <-attackChannel:
			log.Printf("%v attacked\n", id)
			titanHp--
			if titanHp <= 0 {
				log.Printf("Titan %v defeated\n", titanIndex)
				titanHp = 10000
				titanIndex++
				log.Printf("Titan %v spawned with %vhp\n", titanIndex, titanHp)
			}
		}
	}
}

func currentState() *combat.CombatState {
	return &combat.CombatState{
		TitanId:     fmt.Sprintf("titan#%v", titanIndex),
		TitanHp:     titanHp,
		PlayerCount: int32(len(connectedPlayers)),
	}
}

func (s *combatServer) Fight(stream combat.Combat_FightServer) error {
	ctx := stream.Context()
	playerId := ""

	go func() {
		ticker := time.NewTicker(500 * time.Millisecond)
		for {
			select {
			case <-ctx.Done():
				log.Printf("Context done: %v", ctx.Err())
				leftChannel <- playerId
				ticker.Stop()
				return
			case <-ticker.C:
				err := stream.Send(currentState())
				if err != nil {
					log.Printf("⚠️ Send to stream failed: %v", err)
					return
				}
			}
		}
	}()

	for {
		in, err := stream.Recv()
		if err == io.EOF {
			log.Printf("Stream terminated: %v", err)
			return nil
		}
		if err != nil {
			log.Printf("Stream error: %v", err)
			return err
		}
		playerId = in.PlayerId
		switch in.Action {
		case combat.PlayerAction_START:
			joinChannel <- in.PlayerId
		case combat.PlayerAction_LEAVE:
			leftChannel <- in.PlayerId
		case combat.PlayerAction_ATTACK:
			attackChannel <- in.PlayerId
		default:
			log.Printf("Unknown PlayerAction: %v", in.Action)
		}
	}
}

func main() {
	flag.Parse()
	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", *port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	combat.RegisterCombatServer(s, &combatServer{})
	log.Printf("Server listening at %v", lis.Addr())
	go combatHandler()
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to server: %v", err)
	}
}
