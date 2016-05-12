FROM ubuntu:14.04.4

RUN apt-get install -y vim

ADD ./riak-ts_1.3.0-1_amd64.deb /opt/riak-ts_1.3.0-1_amd64.deb
WORKDIR /opt
RUN dpkg -i riak-ts_1.3.0-1_amd64.deb

ADD ./etc/riak/riak.conf /etc/riak/riak.conf
ADD ./opt/start.sh /opt/start.sh

CMD /opt/start.sh
