FROM alpine:3.18
MAINTAINER NOSPAM <nospam@nnn.nnn>

COPY init.sh /init.sh

RUN apk add --update bash openssh-client && rm -rf /var/cache/apk/*; \
    chmod +x /init.sh

CMD /init.sh
EXPOSE 1-65535
