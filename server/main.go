package main

import (
	"context"
	"flag"
	"fmt"
	"io"
	"log"
	"net"
	"time"

	"google.golang.org/grpc"
	combat "thalkz.com/titan/combat/protos"
	greeter "thalkz.com/titan/greeter/protos"
)

var (
	port = flag.Int("port", 50051, "The server port")
)

// greeterServer is used to implement helloworld.GreeterServer.
type greeterServer struct {
	greeter.UnimplementedGreeterServer
}

func (s *greeterServer) SayHello(ctx context.Context, in *greeter.HelloRequest) (*greeter.HelloReply, error) {
	log.Printf("SayHello: %v", in)
	return &greeter.HelloReply{Message: "Hello " + in.GetName()}, nil
}

func (s *greeterServer) ServerMonologue(in *greeter.HelloRequest, stream greeter.Greeter_ServerMonologueServer) error {
	log.Printf("ServerMonologue start for: %v", in.Name)
	values := []int{1, 2, 3, 4, 5}
	for i := range values {
		time.Sleep(200 * time.Millisecond)
		err := stream.Send(&greeter.HelloReply{Message: fmt.Sprintf("Response to %v: %d", in.Name, i)})
		if err != nil {
			log.Printf("ServerMonologue closed prematurely: %v", err)
			return err
		}
	}
	return nil
}

func (s *greeterServer) ClientMonologue(stream greeter.Greeter_ClientMonologueServer) error {
	log.Printf("ClientMonologue start")
	startTime := time.Now()
	if deadline, ok := stream.Context().Deadline(); ok {
		log.Printf("Deadline=%v", deadline)
	}

	for {
		message, err := stream.Recv()
		if err == io.EOF {
			endTime := time.Now()
			stream.SendAndClose(
				&greeter.HelloReply{
					Message: fmt.Sprintf("Finished in %d", int32(endTime.Sub(startTime).Seconds())),
				},
			)
			return nil
		}
		if err != nil {
			log.Printf("Recieved error: %v", err)
			return err
		}
		log.Printf("Recieved: %v", message.Name)
	}
}

func (s *greeterServer) Conversation(stream greeter.Greeter_ConversationServer) error {
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
		log.Printf("Received %v", in)
		reply := &greeter.HelloReply{Message: fmt.Sprintf("Hello %v", in.Name)}
		if err := stream.Send(reply); err != nil {
			log.Printf("Could not end response: %v", err)
			return err
		}
	}
}

type combatServer struct {
	combat.UnimplementedCombatServer
}

var titanIndex = 1
var titanHp int32 = 100
var connectedPlayers = make(map[string]int)

func currentCombatState() *combat.CombatState {
	players := make([]string, len(connectedPlayers))
	i := 0
	for k := range connectedPlayers {
		players[i] = k
		i++
	}
	return &combat.CombatState{
		TitanId:  fmt.Sprintf("titan#%v", titanIndex),
		TitanHp:  titanHp,
		PlayerId: players,
	}
}

func (s *combatServer) Fight(stream combat.Combat_FightServer) error {
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
		switch in.Action {
		case combat.PlayerAction_START:
			connectedPlayers[in.PlayerId] = 0
			fmt.Printf("Player %v joined\n", in.PlayerId)

		case combat.PlayerAction_LEAVE:
			delete(connectedPlayers, in.PlayerId)
			fmt.Printf("Player %v left\n", in.PlayerId)

		case combat.PlayerAction_ATTACK:
			fmt.Printf("Player %v attack\n", in.PlayerId)
			connectedPlayers[in.PlayerId]++
			titanHp--

			if titanHp <= 0 {
				fmt.Printf("Titan %v defeated\n", titanIndex)
				titanHp = 100
				titanIndex++
				fmt.Printf("Titan %v spawned with %vhp\n", titanIndex, titanHp)
			}
		}

		reply := currentCombatState()
		if err := stream.Send(reply); err != nil {
			log.Printf("Could not end response: %v", err)
			return err
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
	greeter.RegisterGreeterServer(s, &greeterServer{})
	combat.RegisterCombatServer(s, &combatServer{})
	log.Printf("Server listening at %v", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to server: %v", err)
	}
}
