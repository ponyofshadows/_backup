#!/bin/bash
set -e

# getopt
SHORT_OPTS="br"
LONG_OPTS="backup,restore"
PARSED_OPTS=$(getopt --options $SHORT_OPTS --longoptions $LONG_OPTS --name "$0" -- "$@")
if [[ $? -ne 0 ]]; then
  echo "Wrong Input!" >&2
  exit 2
fi
eval set -- "$PARSED_OPTS" # Strings after `--` will be treated as parameters

unset SHORT_OPTS LONG_OPTS PARSED_OPTS

# reading options
mode=""

while true; do
  case $1 in
    -b|--backup)
      mode="backup"
      shift
      ;;
    -r|--restore)
      mode="restore"
      shift
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Wrong Input!" >&2
      exit 2
      ;;
  esac
done

# parameters: $@
case $mode in 
  backup)
    case $# in
      0)
        rsync_from="$HOME"
        rsync_to="/mnt"
        ;;
      1)
        rsync_from="$HOME"
        rsync_to="$1"
        ;;
      2)
        rsync_from="$1"
        rsync_to="$2"
        ;;
      *)
        echo "Too many parameters!" >&2
        exit 2
        ;;
    esac
    if [[ !( -d "$rsync_from" && -d "$rsync_to" ) ]]; then
      echo "Path doesn't exist!" >&2 
      exit 1
    fi
    rsync -aH --delete --exclude "/.*" --progress "$rsync_from/" "$rsync_to/"
    ;;
  restore)
    case $# in
      0)
        rsync_from="/mnt"
        rsync_to="$HOME"
        ;;
      1)
        rsync_from="$1"
        rsync_to="$HOME"
        ;;
      2)
        rsync_from="$1"
        rsync_to="$2"
        ;;
      *)
        echo "Too many parameters!" >&2
        exit 2
        ;;
    esac
    if [[ !( -d "$rsync_from" && -d "$rsync_to" ) ]]; then
      echo "Path doesn't exist!" >&2 
      exit 1
    fi
    rsync -aH --delete --exclude "/.*" --progress "$rsync_from/" "$rsync_to/"
    ;;
esac
