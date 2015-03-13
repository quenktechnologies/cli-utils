#!/bin/bash

__ScriptVersion="0.1.0"

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage ()
{
    cat <<- EOT

  Usage :  $0 [options] [--]

  Options:
  -s|server     The server to remote to. (Required)
  -p|port       The local port to bind to. (Required)
  -r|remote     The remote address and port to bind to (defaults to localhost:80)
  -h|help       Display this message
  -v|version    Display script version

EOT
}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

while getopts "s:p:r:hv" opt
do
  case $opt in

  s|server     )  SERVER=$OPTARG     ;;
  p|port       )  PORT=$OPTARG       ;;   
  r|remote     )  REMOTE=$OPTARG     ;;
  h|help       )  usage; exit 0      ;;

  v|version    )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

  \? )  echo -e "\n  Option does not exist : $OPTARG\n"
      usage; exit 1   ;;
  :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac    # --- end of case ---
done
shift $(($OPTIND-1))

if [ -z "$SERVER" ]
then
  usage
  exit -1
fi

if [ -z "$PORT " ]
then
  usage
  exit -1
fi

if [ -z "$REMOTE" ]
then
  REMOTE=localhost:80;
fi

echo "ssh $SERVER -N -L $PORT:$REMOTE";
ssh $SERVER -N -L $PORT:$REMOTE

