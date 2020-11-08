FROM    alpine:3.7
LABEL   maintainer="var-dev@github"
LABEL   cisco.descriptor-schema-version="2.6" \
        cisco.info.name="rsyslog" \
        cisco.info.description="Cisco iox rsyslog" \
        cisco.info.version="0.1" \
        cisco.info.author-link=" https://github.com/var-dev/iox-rsyslog-alpine " \
        cisco.info.author-name="var-dev" \
        cisco.type=docker \
        cisco.cpuarch=x86_64 \
        cisco.resources.profile=custom \
        cisco.resources.cpu=800 \
        cisco.resources.memory=1024 \
        cisco.resources.disk=10 \
        cisco.resources.network.0.interface-name=eth0 \
	cisco.resources.network.0.ports.udp=514 \
        cisco.resources.network.1.interface-name=eth1 \
	cisco.resources.network.1.ports.udp=514 \
#	cisco.monitor.script="healthprobe.sh" \
	cisco.startup.rootfs="rootfs.tar" \
	cisco.startup.target="/runapp.sh"
ADD     http://alpine.adiscon.com/rsyslog@lists.adiscon.com-5a55e598.rsa.pub /etc/apk/keys
RUN     echo 'http://alpine.adiscon.com/3.7/stable' >> /etc/apk/repositories \
     && apk update \
     && apk add --no-cache rsyslog rsyslog-elasticsearch rsyslog-omstdout \
     && rm -rf /var/cache/apk/*
 
COPY    rsyslog.conf /etc/rsyslog.conf
COPY    runapp.sh /runapp.sh
