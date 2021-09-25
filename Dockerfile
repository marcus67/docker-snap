FROM ubuntu:18.04
MAINTAINER marcus.rickert@web.de

ENV container docker
ENV PATH "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -f -y  \
       snapd fuse snapd snap-confine squashfuse sudo init
RUN apt-get clean && \
    dpkg-divert --local --rename --add /sbin/udevadm &&\
    ln -s /bin/true /sbin/udevadm
RUN systemctl enable snapd
VOLUME [ "/sys/fs/cgroup" ]
#STOPSIGNAL SIGRTMIN+3
COPY assets/check-availability.sh /bin/check-availability.sh
CMD [ "/bin/systemd" ]
