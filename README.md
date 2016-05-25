riak-ts
=============

Runs the Riak-ts cluster in a Docker containers

## Starting the cluster with docker-compose

```bash
docker-compose up
```

## Running locally on one machine or on your laptop
This will start a 3 node cluster

### Starting the first node/container

```bash
docker rm riak1
docker run -d --name riak1 --env IS_FIRST_NODE=true garland/riak-ts:1.3.0-1
```

### Starting the second node/container

```bash
docker rm riak2
docker run -d --name riak2 --link riak1:riak1 --env IS_FIRST_NODE=false garland/riak-ts:1.3.0-1
```

### Starting the third node/container

```bash
docker rm riak3
docker run -d --name riak3 --link riak1:riak1 --env IS_FIRST_NODE=false garland/riak-ts:1.3.0-1
```
