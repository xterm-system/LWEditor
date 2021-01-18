# Lightweight console text editor (supports only bash, not sh or zsh)
edit() {
  while :
  do
    read utext
    case $utext in
      {EDITOR:QUIT})
        clear
        exit 0
        ;;
      {EDITOR:NEWFILE})
        clear
	echo "Open file "
	echo "__________"
        echo -ne "File name: "
        read filename
        if [[ -z $filename ]]; then
          clear
          exit 0
        fi
        unset utext
	echo "__________"
	sleep 1
        if [[ -f $filename ]]; then
    clear
    echo "[ I | Opened file $filename ]"
    cat "$filename"
    edit "$filename"
  else
    clear
    echo "[ I | Created file $filename ]"
    touch "$filename"
    edit "$filename"
  fi
        ;;
      {SHELL:EXECUTE})
        echo -ne "Command to execute: "
        read commandtoexecute
          echo "$($commandtoexecute)" >> "$1"
          echo "$($commandtoexecute)"
        ;;
      *)
        echo "$utext" >> "$1"
        ;;
    esac
  done
}
if [[ $1 != "" ]]; then
  filename=$1
  clear
  if [[ -f $1 ]]; then
    clear
    echo "[ I | Opened file $1 ]"
    cat "$1"
    edit "$1"
  else
    clear
    echo "[ I | Created file $1 ]"
    touch "$1"
    edit "$1"
  fi
else
  clear
  echo "LWEditor           "
  echo "___________________"
  echo "                   "
  echo -n "Enter file name: "
  read filename
  echo "___________________"
  sleep 1
  clear
  if [[ -f $filename ]]; then
    clear
    echo "[ I | Opened file $filename ]"
    cat "$filename"
    edit "$filename"
  else
    clear
    echo "[ I | Created file $filename ]"
    touch "$filename"
    edit "$filename"
  fi
fi
