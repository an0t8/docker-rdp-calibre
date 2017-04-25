#!/bin/bash

mkdir -p /config
ln -s /config /nobody/.config/calibre
chown -R nobody:users /config
chmod -R g+rw /config
[[ -f /tmp/.X1-lock ]] && rm /tmp/.X1-lock && echo "X1-lock found, deleting"

if [ ! "$EDGE" = "1" ]; then
  echo "EDGE not requested, keeping stable version"
else
  echo "EDGE requested, updating to latest version"
  wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"
fi

if [ -z "$LIBRARYINTERNALPATH" ]; then
  LIBRARYINTERNALPATH=/config
fi

chown -R nobody:users $LIBRARYINTERNALPATH
chmod -R g+rw $LIBRARYINTERNALPATH

/sbin/setuser nobody calibre-server --with-library=$LIBRARYINTERNALPATH --port 8080 --url-prefix=$URLPREFIX &
