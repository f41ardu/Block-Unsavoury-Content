#!/bin/bash

usage() 
{ echo "Usage: $0 [-f <file>]" 
  echo "" 
  echo "Content of input file"
  echo "A list of aggregated ad-block list which can be found at:"
  echo "https://v.firebog.net/hosts/lists.php" 
  echo ""
  echo "Example:" 
  echo ""
  echo "https://hostsfile.org/Downloads/hosts.txt"
  echo "https://someonewhocares.org/hosts/zero/hosts"
  echo ""
  echo "Output is block.conf which can be used with unbound"
  1>&2; 
  exit 1; 
}

while getopts ":f:" o; do
    case "${o}" in
        f)
            s=${OPTARG}
            ((s == 45 || s == 90)) || usage
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${s}" ] || [ -z "${p}" ]; then
    usage
fi

echo "s = ${s}"
echo "p = ${p}"
