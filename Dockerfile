FROM alpine:3.2
MAINTAINER NOSPAM <nospam@nnn.nnn>

RUN apk add --update openssh-client && rm -rf /var/cache/apk/*

CMD ssh \
-vv \
-o StrictHostKeyChecking=no \
-Nn $TUNNEL_HOST \
-p $TUNNEL_PORT \
-L *:$LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT \
-i $KEY
EXPOSE 1-65535
