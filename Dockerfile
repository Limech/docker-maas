FROM ubuntu:18.04

ENV container docker

RUN find /etc/systemd/system \
    /lib/systemd/system \
    -path '*.wants/*' \
    -not -name '*journald*' \
    -not -name '*systemd-tmpfiles*' \
    -not -name '*systemd-user-sessions*' \
    -exec rm \{} \;

RUN apt-get -qq update && \
    apt-get install -y systemd software-properties-common jq sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN systemctl set-default multi-user.target
RUN systemctl mask dev-hugepages.mount sys-fs-fuse-connections.mount

# Systemd defines that it expects SIGRTMIN+3 for graceful shutdown
# https://www.commandlinux.com/man-page/man1/systemd.1.html#lbAH
STOPSIGNAL SIGRTMIN+3

ENV TZ=America/Toronto
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

RUN apt-get -y upgrade && \
    apt-add-repository -yu ppa:maas/2.8

RUN apt-get update
# install MaaS
RUN apt-get install -y maas
# removing sshd
RUN systemctl disable sshd && \
    apt-get remove -y openssh-server

# Exposing ports needed by MAAS
# 53 (DNS)
# 67 (DHCP server)
# 69 (TFTP)
# 123 (NTP)
# 623 (IPMI)
# 4011 (PXE)
# 5240 (MAAS UI)
EXPOSE 53 67 69 123 623 4011 5240

#COPY docker-entrypoint.sh /docker-entrypoint.sh
#RUN chmod +x /docker-entrypoint.sh

# initialize systemd
# Workaround for docker/docker#27202, technique based on comments from docker/docker#9212
CMD ["/bin/bash", "-c", "exec /sbin/init --log-target=journal 3>&1"]
#CMD ["/docker-entrypoint.sh"]
