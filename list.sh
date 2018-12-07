#/bin/sh

# date "+%m.%d.%y-%H_%M_%S"

rm  $2
rm tmp/dirs.txt
for loop in $(cat $1) 
do 
    list_item=$(echo $loop| sed 's/\//;/g' | cut -d ';' -f3)
    echo $list_item >> tmp/dirs.txt 
done

liste=$(cat tmp/dirs.txt | sort -u)
echo $liste
# sed 's/127.0.0.1\t //'
 for item in $liste 
	do 
        echo $item
	file=$(ls lists/$item | grep -v bak)
        for lfile in $file 
            do 
#                echo ./lists/$item/$lfile
                cp  ./lists/$item/$lfile ./lists/$item/bak/$lfile.1 
                egrep -v '^\s*$|^#' ./lists/$item/$lfile | sed -e 's/127.0.0.1//' | sed -e 's/0.0.0.0//' | sed 's/0 //'  | sed -e 's///' | sed -e 's/\t//' | sed 's/  / /g' |sed -e 's/^[ ]*//' >> $2  
	    done
        done
        egrep -v localhost $2 > $2.1
        cat $2.1 | sed 's/  / /g' | sed 's/#[^#]*$//' | sed -e 's/\t//' | sort -u > $2.2
awk '{print "local-data: \""$1" A 0.0.0.0\""}' $2.2 > block.conf.1
grep -v 'local-data: " A 0.0.0.0"' block.conf.1 | sed -e 's/;/ /' > block.conf        
