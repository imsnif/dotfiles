#!/bin/bash

# start a detached session if there are none
if [[ $(/usr/bin/tmux list-sessions | grep -v attached | wc -l) -eq 0 ]]; then
  tmux new-session -d
fi

# find available detached session
AVAILABLE_WIN=$(/usr/bin/tmux ls | grep -v attached | tail -n 1 | awk 'BEGIN{FS=":"}{print $1}')

# kill all detached sessions in the background (cleanup)
nohup $(tmux list-sessions | grep -v attached | grep -v "$AVAILABLE_WIN:" | awk 'BEGIN{FS=":"}{print $1}' | xargs -n 1 tmux kill-session -t)

# create new detached session in the background
nohup tmux new-session -d

# init window in case we got a 2nd hand one
tmux send-keys -t $AVAILABLE_WIN "cd ~; clear" ENTER

# attach session
tmux attach-session -t $AVAILABLE_WIN
