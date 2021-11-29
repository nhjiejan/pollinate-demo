# Flask Demo

This repository contains the source code, helm chart and terraform code for a load balanced python flask application that runs on kubernetes. The application exposes an api that once called, sends an entry to a postgres db with an id, hostname and timestamp.

 ![Architecture](/Docs/architecture.png)

## Requirements
- minikube >= v1.24.0
- docker
- helm >= v3.7.1
- dockerhub account
- terraform v1.0.11
- azcli


## Development
The Makefile in the `app` directory provides all the necessary targets to build the image from source, package in a docker image and run the image locally. Update the `REPO` variable in the Makefile to reflect your own dockerhub account

### Build docker image
```make build```

### Run docker container
```make run```

This will allow you to run the docker image on your local machine. The service is made available on `http://127.0.0.1:5000`

### Publish image to docker repository
```make publish```



## Deploy Infrastructure
First create an Azure account and login using the az cli utility
```
terraform init
terraform apply 
```

Gather the outputs of the postgresql database and the kubernets cluster

### Deploy Application to AKS

login using the az cli and download the credentials for the aks cluster:
```
az aks get-credentials --name pollinate_demo --resource-group polinatedemo
```

See docs in [`charts`](./charts/README.md) for helm deployment instructions


