FROM alpine:3.3
MAINTAINER Andrey Arapov <andrey.arapov@nixaid.com>

RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk update \
    && apk add py-gevent@testing py-msgpack@testing wget ca-certificates

ENV USER zeronet
ENV UID 7000
ENV HOME /home/$USER
RUN adduser -D -u $UID -h $HOME -s /bin/true $USER

USER $USER
WORKDIR $HOME
RUN wget -q https://github.com/HelloZeroNet/ZeroNet/archive/master.tar.gz \
    && tar xpzf master.tar.gz \
    && rm -f master.tar.gz \
    && cd ZeroNet-master \
    && mkdir log \
    && touch log/error.log

WORKDIR $HOME/ZeroNet-master
CMD python zeronet.py --ui_ip 0.0.0.0
