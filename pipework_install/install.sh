#!/bin/bash

apt-get -y install arping
curl -o /usr/local/bin/pipework https://raw.github.com/jpetazzo/pipework/master/pipework
chmod a+x /usr/local/bin/pipework
