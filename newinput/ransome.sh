#/bin/bash

usage()
{ echo "Usage: $0 [-f <file> -o <output> ]"
  echo ""
  echo " Content of input file"
  echo ""
  echo "Example: prepbuild.sh -f list.inp -o block.conf"
  1>&2;
  exit 1;
}

while getopts ":f:o:" o; do
    case "${o}" in
        f)
            s=${OPTARG}
            ;;
        o)  OUTPUT=${OPTARG}
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

if [ ! -d "tmp" ]; then
    mkdir tmp
fi


if [ ! -d "lists" ]; then
     mkdir lists
fi

for loop  in $(cat $s)
do

	list_item=$(echo $loop | sed 's/\//;/g' | cut -d ';' -f3)
	echo $list_item

	if [ ! -d "lists/"$list_item ]; then
     		mkdir lists/$list_item
	fi
	if [ ! -d "lists/$list_item/bak" ]; then
     		mkdir lists/$list_item/bak
	fi
# echo "Download: " $list_item"--/--"$loop
# echo "\n"
	wget -T 4 -q -N --show-progress -P  lists/$list_item/ $loop
done

rm tmp/dirs.txt

for loop in $(cat $s)
do
    list_item=$(echo $loop| sed 's/\//;/g' | cut -d ';' -f3)
    echo $list_item >> tmp/dirs.txt
done

liste=$(cat tmp/dirs.txt | sort -u)
 for item in $liste
        do
        echo "Prepare Host: " $item 
        file=$(ls lists/$item | grep -v bak)
        for lfile in $file
            do
                echo ./lists/$item/$lfile
	        grep -v "#" $lfile | awk '{print "local-data: \""$1" A 0.0.0.0\""}' > $OUTPUT 
            done
	done

