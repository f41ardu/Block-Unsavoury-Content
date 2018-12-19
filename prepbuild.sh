#/bin/bash


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

if [ ! -d "tmp" ]; then
    mkdir tmp
fi


if [ ! -d "lists" ]; then 
     mkdir lists
fi



for loop  in $(cat $s) 
do 
	
list_item=$(echo $loop | sed 's/\//;/g' | cut -d ';' -f3)
#echo $list_item


if [ ! -d "lists/"$list_item ]; then 
     mkdir lists/$list_item
fi
if [ ! -d "lists/$list_item/bak" ]; then
     mkdir lists/$list_item/bak
fi
 echo "Download: " $list_item"--/--"$loop
 wget -T 4 -q -N -P lists/$list_item/ $loop

done

rm tmp/dirs.txt
rm tmp/*.1

for loop in $(cat $s)
do
    list_item=$(echo $loop| sed 's/\//;/g' | cut -d ';' -f3)
    echo $list_item >> tmp/dirs.txt
done

liste=$(cat tmp/dirs.txt | sort -u)
# sed 's/127.0.0.1\t //'
 for item in $liste
        do
        echo "Prepare Host: " $item
        file=$(ls lists/$item | grep -v bak)
        for lfile in $file
            do
#                echo ./lists/$item/$lfile
                cp  ./lists/$item/$lfile ./lists/$item/bak/$lfile.1
                egrep -v '^\s*$|^#' ./lists/$item/$lfile | sed -e 's/127.0.0.1//' | sed -e 's/0.0.0.0//' | sed 's/0 //'  | sed -e 's///' | sed -e 's/\t//' | sed 's/  / /g' |sed -e 's/^[ ]*//' >> tmp/host.1
            done
        done
        egrep -v localhost tmp/host.1 > tmp/host.2
        cat tmp/host.2 | sed 's/  / /g' | sed 's/#[^#]*$//' | sed -e 's/\t//' | sort -u > tmp/host.3
awk '{print "local-data: \""$1" A 0.0.0.0\""}' tmp/host.3 > tmp/block.conf.1
grep -v 'local-data: " A 0.0.0.0"' tmp/block.conf.1 | sed -e 's/;/ /' > block.conf

