
if [ "$REMOTE" != "true" ]; then
	ssh \
		-vv \
		-o StrictHostKeyChecking=no \
		-Nn $TUNNEL_HOST \
		-p $TUNNEL_PORT \
		-L *:$LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT \
		-i $KEY
else
	LOCAL_HOST="0.0.0.0"
	if [ -n "$LISTEN_HOST" ]; then
		LOCAL_HOST="$LISTEN_HOST"
	fi
	ssh \
		-vv \
		-o StrictHostKeyChecking=no \
		-Nn $TUNNEL_HOST \
		-p $TUNNEL_PORT \
		-R $LOCAL_HOST:$REMOTE_PORT:$CONTAINER_HOST:$CONTAINER_PORT \
		-i $KEY
fi

