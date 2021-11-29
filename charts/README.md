# Deploy to AKS

## Requirements:
 - build and publish the demo docker image
 - install helm client


## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | Int | `3` |  |
| image.repository | String | `nhjiejan/pollinate-demo` |  |
| image.tag  | String | `0.0.3` |  |
| db.name | String | `mydb` |  |
| db.user | String | `psqladmin@polinatedemo-db` | Postgresql user name |
| db.password  | String | `` | Postgresql password |
| db.url  | String | `` | hostname and port for database |


### Run DB migration manually
docker run --rm -d --name flask-migration \
    -e POSTGRES_DB='mydb' \
    -e POSTGRES_USER='psqladmin@asdasdasdas' \
    -e POSTGRES_PASSWORD='asdasdasdasdasd' \
    -e POSTGRES_URL='xxxxxyyyyzzzzzz:5432' \
    nhjiejan/pollinate-demo:0.0.1 bash -c 'flask db init && flask db migrate && flask db upgrade'

### Deploy helm chart
```
cd flask-hello-world/charts
helm install pollinate-demo pollinate-demo
```

get the IP of the loadbalancer by searching `kubectl get sv`

You will then be able to access your loadbalanced application, navigate to your browser and search `http://<IP>:5000`

### Clean up
```
helm delete pollinate-demo --purge
```