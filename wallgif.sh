#!/bin/bash

function rendergif(){
	RENDER_SRC=$1
	RENDER_SRC_DIR=$2
	RENDER_SRC_SHORT=$3
	FILE_COUNT=$(( $(ls "/tmp/wallgif/${RENDER_SRC_DIR}/" | wc -l) - 1))
	while [[ true ]]; do
		MAP=0
		while [[ $MAP -lt FILE_COUNT ]]; do
			feh --bg-fill "/tmp/wallgif/${RENDER_SRC_DIR}/${RENDER_SRC_DIR}-${MAP}.png"
			((MAP++))
		done
	done
}

function splitgif(){
	GIF_SRC=$1
	GIF_SRC_DIR=$2
	GIF_SRC_SHORT=$3
	mkdir "/tmp/wallgif/${GIF_SRC_DIR}"
	cp $GIF_SRC "/tmp/wallgif/${GIF_SRC_DIR}/"
	echo "preparing..."
	convert -coalesce "/tmp/wallgif/${GIF_SRC_DIR}/${GIF_SRC_SHORT}" "/tmp/wallgif/${GIF_SRC_DIR}/$(echo $GIF_SRC_SHORT | sed 's/gif/png/')"
}

SRC=$1

if [[ ! -d /tmp/wallgif/ ]]; then
	mkdir /tmp/wallgif/
fi

SRC_SHORT=$(echo $SRC | grep -oP "[^\/]*$")
SRC_DIR=$(echo $SRC_SHORT | sed 's/.gif//')

if [[ ! -f "/tmp/wallgif/${SRC_DIR}/${SRC_SHORT}" ]]; then
	splitgif $SRC $SRC_DIR $SRC_SHORT
fi

rendergif $SRC $SRC_DIR $SRC_SHORT