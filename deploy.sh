docker build -t muizmir/multi-client:latest -t muizmir/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t muizmir/multi-server:latest -t muizmir/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t muizmir/multi-worker:latest -t muizmir/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push muizmir/multi-client:latest
docker push muizmir/multi-server:latest
docker push muizmir/multi-worker:latest

docker push muizmir/multi-client:$SHA
docker push muizmir/multi-server:$SHA
docker push muizmir/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=muizmir/multi-server:$SHA
kubectl set image deployments/client-deployment client=muizmir/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=muizmir/multi-worker:$SHA
