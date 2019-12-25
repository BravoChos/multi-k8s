docker build -t deeplearner507/multi-client:latest -t deeplearner507/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t deeplearner507/multi-server:latest -t deeplearner507/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t deeplearner507/multi-worker:latest -t deeplearner507/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push deeplearner507/multi-client:latest
docker push deeplearner507/multi-server:latest
docker push deeplearner507/multi-worker:latest

docker push deeplearner507/multi-client:$SHA
docker push deeplearner507/multi-server:$SHA
docker push deeplearner507/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=deeplearner507/multi-server:$SHA
kubectl set image deployments/client-deployment client=deeplearner507/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=deeplearner507/multi-worker:$SHA