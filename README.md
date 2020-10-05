# Executing on docker

Building a docker image
```shell script
docker image build -t klaze-docker .
```

Running container

This assume you already have a mysq/mariadb database runing in a container named 'maria'

```shell script
docker run --name=klaze --link=maria -e MYSQL_HOST=maria -e MYSQL_PORT=3306 -e MYSQL_USER=root -e MYSQL_PASSWD=123 -p 8081:8081 klaze-docker
```

