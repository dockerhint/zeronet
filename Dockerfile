# docker build -t my/zeronet .
# docker run -d -v ~/.zeronetdata:/data -p 43110:43110 my/zeronet

FROM alpine:3.3
MAINTAINER Andrey Arapov <andrey.arapov@nixaid.com>

RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk update \
    && apk add py-gevent@testing py-msgpack@testing wget ca-certificates

ENV USER zeronet
ENV UID 7000
ENV HOME /home/$USER
ENV PROJECT ZeroNet-master
ENV DATA /data
RUN adduser -D -u $UID -h $HOME -s /bin/true $USER

USER $USER
VOLUME [ "$DATA" ]
WORKDIR $HOME
RUN wget -q https://github.com/HelloZeroNet/ZeroNet/archive/master.tar.gz \
    && tar xpzf master.tar.gz \
    && rm -f master.tar.gz \
    && cd $PROJECT \
    && mkdir log \
    && touch log/error.log \
    && ln -sv $DATA ./data

# the launch script needs to chown the /data in case when $UID does not match
# the UID of the host
USER root
COPY launch ./$PROJECT/
CMD ./$PROJECT/launch
