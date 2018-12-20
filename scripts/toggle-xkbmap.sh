#!/usr/bin/bash

(setxkbmap -query | grep -q "layout:\s\+us") && setxkbmap il || setxkbmap us
