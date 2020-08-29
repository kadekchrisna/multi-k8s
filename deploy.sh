docker build -t kadekchresna/multi-client:latest -t kadekchresna/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kadekchresna/multi-server:latest -t kadekchresna/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kadekchresna/multi-worker:latest -t kadekchresna/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kadekchresna/multi-client:latest
docker push kadekchresna/multi-server:latest
docker push kadekchresna/multi-worker:latest

docker push kadekchresna/multi-client:$SHA
docker push kadekchresna/multi-server:$SHA
docker push kadekchresna/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=kadekchresna/multi-server:$SHA
kubectl set image deployments/client-deployment client=kadekchresna/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kadekchresna/multi-worker:$SHA
