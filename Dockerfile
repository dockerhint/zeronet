# docker build -t my/zeronet .
# docker run -d --name zeronet -v ~/.zeronetdata:/data -p 43110:43110 my/zeronet

FROM alpine:3.3
MAINTAINER Andrey Arapov <andrey.arapov@nixaid.com>

RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk update \
    && apk add py-gevent@testing py-msgpack@testing wget ca-certificates

ENV USER zeronet
ENV UID 7000
ENV HOME /home/$USER
# ENV PROJECT_VER v0.3.5
# ENV PROJECT ZeroNet-0.3.5
ENV PROJECT_VER master
ENV PROJECT ZeroNet-master
ENV DATA /data

RUN adduser -D -u $UID -h $HOME -s /bin/true $USER

# Optionall you may want to enable Tor in order to anonymize the traffic
RUN apk add tor@testing
RUN echo -e "ControlPort 9051" > /etc/tor/torrc
# RUN echo -e "ControlPort 9051\nCookieAuthentication 1" > /etc/tor/torrc
# RUN adduser $USER tor

USER $USER
VOLUME [ "$DATA" ]
WORKDIR $HOME
RUN wget -q https://github.com/HelloZeroNet/ZeroNet/archive/${PROJECT_VER}.tar.gz \
    && tar xpzf ${PROJECT_VER}.tar.gz \
    && rm -f ${PROJECT_VER}.tar.gz \
    && cd $PROJECT \
    && mkdir log \
    && touch log/error.log \
    && ln -sv $DATA ./data

# the launch script needs to chown the /data in case when $UID does not match
# the UID of the host
USER root
COPY launch ./$PROJECT/
CMD ./$PROJECT/launch
