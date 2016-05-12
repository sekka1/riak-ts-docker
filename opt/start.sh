#!/bin/bash -x

# Local IP
LOCAL_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

# Have to get this IP of riak1 b/c running the join and putting a hostname does not resolve with riak
RIAK_1_IP=$(ping -c 1 riak1 | head -1 | grep -E -o "[0-9]+.[0-9]+.[0-9]+.[0-9]+")

# Edit config
sed -i "s/127.0.0.1/${LOCAL_IP}/g" /etc/riak/riak.conf

# Startup riak
riak start

# Join the cluster if it is not the first node
if [ x${IS_FIRST_NODE}x == "xfalsex" ]; then

  riak-admin cluster join riak@${RIAK_1_IP}

fi

# start the cluster
if [ x${IS_FIRST_NODE}x == "xtruex" ]; then

  sleep 30

  riak-admin cluster plan

  riak-admin cluster commit

  riak-admin member_status

fi

tail -f /var/log/riak/*
