#!/bin/bash

V=""
if [ "${VERBOSE}" = "true" ]; then
	V='-vv'
fi

if [ "$REMOTE" != "true" ]; then
	IFS=',' read -r -a REMOTE_HOST_ARRAY <<< "$REMOTE_HOST"
	IFS=',' read -r -a LOCAL_PORT_ARRAY <<< "$LOCAL_PORT"
	IFS=',' read -r -a REMOTE_PORT_ARRAY <<< "$REMOTE_PORT"
	FORWARDING=""
	for I in ${!REMOTE_HOST_ARRAY[*]}; do
		FORWARDING+=" -L *:${LOCAL_PORT_ARRAY[$I]}:${REMOTE_HOST_ARRAY[$I]}:${REMOTE_PORT_ARRAY[$I]}"
	done
	while [ true ]; do
		echo "Connecting to ${TUNNEL_HOST}:${TUNNEL_PORT}"
		ssh \
			${V} \
			-o StrictHostKeyChecking=no \
			-o ServerAliveInterval=15 \
			-o ServerAliveCountMax=4 \
			-Nn ${TUNNEL_HOST} \
			-p ${TUNNEL_PORT} \
			${FORWARDING} \
			-i ${KEY}
		sleep 60;
	done
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
	while [ true ]; do
		echo "Connecting to ${TUNNEL_HOST}:${TUNNEL_PORT}"
		ssh \
			${V} \
			-o StrictHostKeyChecking=no \
			-o ServerAliveInterval=15 \
			-o ServerAliveCountMax=4 \
			-Nn ${TUNNEL_HOST} \
			-p ${TUNNEL_PORT} \
			${FORWARDING} \
			-i ${KEY}
		sleep 60;
	done
fi
