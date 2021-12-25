#!/usr/bin/env bash
## TODO:
# - list all windows
# - search for windows called "code*"
# - if 0, urxvt -name code1
# - if 1-3, go to highest, focus, splitv/h, exec urxvt -name <highest+1>
# - if 4 do nothing (later stack)
CURRENT_DESKTOP=`/usr/bin/xprop -notype -root _NET_CURRENT_DESKTOP | cut -c 24-`
WINDOWS=`/usr/bin/xdotool search --all --onlyvisible --desktop $CURRENT_DESKTOP "" 2>/dev/null`
CODE_WINDOWS=()
for id in $WINDOWS
do
    instance=`/usr/bin/xprop -id ${id} | grep -i WM_CLASS | awk '{print $3}' | sed 's/"//g' | sed 's/,//g'`
    if [[ $instance =~ code.* ]]; then
      CODE_WINDOWS=( ${CODE_WINDOWS[@]} $instance )
    fi

done

if [ ${#CODE_WINDOWS[@]} -eq 0 ]; then
  echo 1;
  /usr/bin/i3-msg exec "urxvt -name code1 $@";
  exit;
fi
IFS=$'\n' SORTED_WINDOWS=($(sort <<<"${CODE_WINDOWS[*]}"))
unset IFS

LAST_WINDOW=${SORTED_WINDOWS[-1]}
regex=([0-9]+)$
[[ $LAST_WINDOW =~ $regex ]]
LAST_WINDOW_INDEX=${BASH_REMATCH[1]}
NEW_WINDOW_INDEX=$((LAST_WINDOW_INDEX+1))
NEW_WINDOW_NAME="code$NEW_WINDOW_INDEX"


for i in "${!SORTED_WINDOWS[@]}"; do 
  WINDOW_NAME=${SORTED_WINDOWS[$i]}
  WINDOW_INDEX=$((i+1))
  regex=([0-9]+)$
  [[ $WINDOW_NAME =~ $regex ]]
  WINDOW_NAME_INDEX=${BASH_REMATCH[1]}
  if (($WINDOW_INDEX > 1)) ; then
    PREVIOUS_WINDOW=${SORTED_WINDOWS[$((i-1))]}
    [[ $PREVIOUS_WINDOW =~ $regex ]]
    PREVIOUS_WINDOW_NAME_INDEX=${BASH_REMATCH[1]}
    PLUS_ONE=$((PREVIOUS_WINDOW_NAME_INDEX+1))
    if (($PLUS_ONE != $WINDOW_NAME_INDEX)); then
      LAST_WINDOW=$PREVIOUS_WINDOW
      LAST_WINDOW_INDEX=${PREVIOUS_WINDOW_NAME_INDEX}
      NEW_WINDOW_NAME="code$PLUS_ONE"
      echo $LAST_WINDOW
      echo $NEW_WINDOW_NAME
    fi
  fi
done

if [ $LAST_WINDOW_INDEX == 1 ]; then
  /usr/bin/i3-msg \[instance=${LAST_WINDOW} workspace=__focused__\] focus, splith, exec "urxvt -name $NEW_WINDOW_NAME $@"
elif [ $LAST_WINDOW_INDEX == 2 ]; then
  /usr/bin/i3-msg \[instance=${LAST_WINDOW} workspace=__focused__\] focus, splitv, exec "urxvt -name $NEW_WINDOW_NAME $@"
elif [ $LAST_WINDOW_INDEX == 3 ]; then
  /usr/bin/i3-msg \[instance=code1 workspace=__focused__\] focus, splitv, exec "urxvt -name $NEW_WINDOW_NAME $@"
fi


# /usr/bin/i3-msg [instance=${LAST_WINDOW}] focus, splith, exec urxvt -name $NEW_WINDOW_NAME 2> /dev/null
# i3-msg "workspace $1; append_layout /home/aram/workspace-templates/ranger-and-terminals.json";
# i3-msg "exec --no-startup-id /usr/bin/urxvt -e ranger";
# i3-msg "exec --no-startup-id /usr/bin/urxvt -name command";
# /usr/bin/urxvt -e ranger
