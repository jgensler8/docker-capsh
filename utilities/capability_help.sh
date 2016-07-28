#!/bin/bash

echo "Answer with:
 'help' --> to get a link describing more inforamtion on the prompt
 'no' or 'n' --> to remove the capabiliity"
echo ""


prompt_cap () {
  temp=""
  echo $1
  read temp
  if [ "${temp}" == "help" ]; then
    echo "$3"
  fi
  if [ "${temp}" == "no" ] || [ "${temp}" == "n" ]; then
    export docker_cap_string="${docker_cap_string} --cap-drop=$2"
  fi
  echo ""
}

# Questions should prompted so that "no" --> removes the respective Capability
prompt_cap "Do you need to use chroot?" "SYS_CHROOT" "https://en.wikipedia.org/wiki/Chroot"
prompt_cap "Do you need to bind to low level ports? (<= 1024)" "NET_BIND_SERVICE" "http://man7.org/linux/man-pages/man7/capabilities.7.html"

echo ""
echo ""
echo "Your capablity string: ${docker_cap_string}"
echo "Example Usage: docker run -it ${docker_cap_string} ubuntu capsh --print"
