FROM alpine:3.2
MAINTAINER NOSPAM <nospam@nnn.nnn>

COPY init.sh /init.sh

RUN apk add --update openssh-client && rm -rf /var/cache/apk/*; \
    chmod +x /init.sh

CMD /init.sh
