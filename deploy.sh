#!/usr/bin/env bash
docker build -t vladstepanov/multi-client:latest -t vladstepanov/multi-client:${SHA} -f ./client/Dockerfile ./client
docker build -t vladstepanov/multi-server:latest -t vladstepanov/multi-server:${SHA} -f ./server/Dockerfile ./server
docker build -t vladstepanov/multi-worker:latest -t vladstepanov/multi-worker:${SHA} -f ./worker/Dockerfile ./worker

docker push vladstepanov/multi-client:latest
docker push vladstepanov/multi-server:latest
docker push vladstepanov/multi-worker:latest

docker push vladstepanov/multi-client:${SHA}
docker push vladstepanov/multi-server:${SHA}
docker push vladstepanov/multi-worker:${SHA}

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vladstepanov/multi-server:${SHA}
kubectl set image deployments/client-deployment client=vladstepanov/multi-client:${SHA}
kubectl set image deployments/worker-deployment worker=vladstepanov/multi-worker:${SHA}