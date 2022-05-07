# Titan - Multiplayer fights

This is a test project for learning gRPC and concurrency in Go.

## How to use
- start server: `cd server; go run main.go`
- start app (1 player, interactive): `cd app; flutter run`
- start cli (x players, automatic): `cd cli; dart run main.dart PLAYER_COUNT ACTIONS_COUNT`

## How to re-generate proto files
- `chmod +x generate.sh`
- `./generate.sh`

Note: protoc + go and dart plugins required