#!/bin/sh

#if BRIDGED wait for interface up
[ $BRIDGED ] && pipework --wait
