#!/bin/bash

if [ "$REMOTE" != "true" ]; then
	IFS=',' read -r -a REMOTE_HOST_ARRAY <<< "$REMOTE_HOST"
	IFS=',' read -r -a LOCAL_PORT_ARRAY <<< "$LOCAL_PORT"
	IFS=',' read -r -a REMOTE_PORT_ARRAY <<< "$REMOTE_PORT"
	FORWARDING=""
	for I in ${!REMOTE_HOST_ARRAY[*]}; do
		FORWARDING+=" -L *:${LOCAL_PORT_ARRAY[$I]}:${REMOTE_HOST_ARRAY[$I]}:${REMOTE_PORT_ARRAY[$I]}"
	done
	ssh \
		-vv \
		-o StrictHostKeyChecking=no \
		-Nn $TUNNEL_HOST \
		-p $TUNNEL_PORT \
		${FORWARDING} \
		-i $KEY
else
	LOCAL_HOST="0.0.0.0"
	if [ -n "$LISTEN_HOST" ]; then
		LOCAL_HOST="$LISTEN_HOST"
	fi
	IFS=',' read -r -a CONTAINER_HOST_ARRAY <<< "$CONTAINER_HOST"
	IFS=',' read -r -a REMOTE_PORT_ARRAY <<< "$REMOTE_PORT"
	IFS=',' read -r -a CONTAINER_PORT_ARRAY <<< "$CONTAINER_PORT"
	FORWARDING=""
	for I in ${!CONTAINER_HOST_ARRAY[*]}; do
		FORWARDING+=" -R ${LOCAL_HOST}:${REMOTE_PORT_ARRAY[$I]}:${CONTAINER_HOST_ARRAY[$I]}:${CONTAINER_PORT_ARRAY[$I]}"
	done
	ssh \
		-vv \
		-o StrictHostKeyChecking=no \
		-Nn $TUNNEL_HOST \
		-p $TUNNEL_PORT \
		${FORWARDING} \
		-i $KEY
fi
