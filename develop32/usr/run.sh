#!/bin/bash


echo "root:$PASSWORD" |chpasswd


service ssh start


#not exit from script. Needed on docker
# Send SIGSTOP to itself
kill -STOP "$$"
