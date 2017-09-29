# sshtunnel
Docker SSH Tunnel

The below example is the same as SSH'ing to `host.example.com` on port `22`, then forwarding port `2525` on the local machine to `localhost (which is host.example.com)` port `25` using the identity file `keyfile`. The `ports` setting is only required if you want to use the tunnel on the host. It is not required for other containers to use the tunnel.

```
version: '2'

services:

  sshtunnel:
    image: nowsci/sshtunnel
    container_name: sshtunnel
    ports:
      - "2525:2525"
    volumes:
      - ./sshtunnel/data/:/data/:ro
    environment:
      - TUNNEL_HOST=host.example.com
      - TUNNEL_PORT=22
      - REMOTE_HOST=localhost
      - LOCAL_PORT=2525
      - REMOTE_PORT=25
      - KEY=/data/keyfile
    restart: always
```
