docker build -t dockervanilla/multi-client:latest -t dockervanilla/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dockervanilla/multi-server:latest -t dockervanilla/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dockervanilla/multi-worker:latest -t dockervaniilla/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dockervanilla/multi-client:latest
docker push dockervanilla/multi-server:latest
docker push dockervanilla/multi-worker:latest
docker push dockervanilla/multi-client:$SHA
docker push dockervanilla/multi-server:$SHA
docker push dockervanilla/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dockervanilla/multi-server:$SHA
kubectl set image deployments/client-deployment client=dockervanilla/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dockervanilla/multi-worker:$SHA