#!/bin/sh

protoc --dart_out=grpc:cli/bin/protos -Iprotos protos/combat.proto
protoc --dart_out=grpc:app/lib/protos -Iprotos protos/combat.proto
protoc --go_out=server/combat --go_opt=paths=source_relative --go-grpc_out=server/combat --go-grpc_opt=paths=source_relative protos/combat.proto