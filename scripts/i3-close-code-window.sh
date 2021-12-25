#!/usr/bin/env bash
# - get focused window from xdotool
focusedWindowId=`/usr/bin/xdotool getwindowfocus`
focusedWindowClassname=`/usr/bin/xprop -id ${focusedWindowId} | grep -i WM_CLASS | awk '{print $3}' | sed 's/"//g' | sed 's/,//g'`

if [[ $focusedWindowClassname =~ code* ]]; then
  # - find last code* window
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
    /usr/bin/i3-msg exec "urxvt -name code1 $@";
    exit;
  fi
  IFS=$'\n' SORTED_WINDOWS=($(sort <<<"${CODE_WINDOWS[*]}"))
  unset IFS
  lastWindow=${SORTED_WINDOWS[-1]}

  # - switch between them
  lastWindowId=`/usr/bin/xdotool search --classname "$lastWindow"`
  /usr/bin/i3-msg swap container with id $lastWindowId



  # - close current window
  /usr/bin/i3-msg kill
  # - rename last window name to focused window name
  currentDesktop=`xdotool get_desktop`
  /usr/bin/xdotool search --desktop $currentDesktop --classname "$lastWindow" set_window --classname "$focusedWindowClassname"
  /usr/bin/xdotool search --desktop $currentDesktop --classname "$lastWindow" set_window --classname "$focusedWindowClassname"
  # done twice because of https://github.com/jordansissel/xdotool/issues/60
else
  /usr/bin/i3-msg kill
fi
