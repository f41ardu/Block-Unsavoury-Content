#!/bin/bash

usage() { echo "Usage: $0 [-f <file> ] " 1>&2; exit 1; }

while getopts ":f:" o; do
    case "${o}" in
        f)
            s=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${s}" ] ; then
    usage
fi

echo "s = ${s}"
