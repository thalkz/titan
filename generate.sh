#!/bin/sh

# Greeter service
protoc --dart_out=grpc:cli/generated -Iprotos protos/greeter.proto
protoc --go_out=server/greeter --go_opt=paths=source_relative --go-grpc_out=server/greeter --go-grpc_opt=paths=source_relative protos/greeter.proto

# Combat service
protoc --dart_out=grpc:cli/generated -Iprotos protos/combat.proto
protoc --go_out=server/combat --go_opt=paths=source_relative --go-grpc_out=server/combat --go-grpc_opt=paths=source_relative protos/combat.proto