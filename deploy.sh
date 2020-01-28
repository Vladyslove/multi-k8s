#!/usr/bin/env bash
docker build -t vladstepanov/multi-client -f ./client/Dockerfile ./client
docker build -t vladstepanov/multi-server -f ./server/Dockerfile ./server
docker build -t vladstepanov/multi-worker -f ./worker/Dockerfile ./worker

docker push vladstepanov/multi-client
docker push vladstepanov/multi-server
docker push vladstepanov/multi-worker

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vladstepanov/multi-server