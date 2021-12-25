#!/usr/bin/env bash
name=$1
target=/home/aram/code/$name

mkdir -p $target

i3-msg "workspace $name; append_layout /home/aram/workspace-templates/mosaic.json";
i3-msg "exec --no-startup-id /usr/bin/urxvt -cd $target -name command";
i3-msg "exec --no-startup-id /usr/bin/urxvt -name sidebar -e ranger --confdir /home/aram/.config/mosaic-workspace --cmd=\"cd $target\"";
# i3-msg "exec --no-startup-id /usr/bin/urxvt -cd $target -name mosaic -e /usr/local/bin/mosaic --max-panes 4";
i3-msg "exec --no-startup-id /usr/bin/urxvt -cd $target -name mosaic";
# i3-msg [id=$(/usr/bin/xdotool search --desktop $(/usr/bin/xdotool get_desktop) --classname "sidebar")] focus

