#/bin/sh

# date "+%m.%d.%y-%H_%M_%S"

echo "" > $2
echo "" > tmp/dirs.txt
for loop in $(cat $1) 
do 
    list_item=$(echo $loop| sed 's/\//;/g' | cut -d ';' -f3)
    echo $list_item >> tmp/dirs.txt 
done

liste=$(cat tmp/dirs.txt | sort -u)
echo $liste
 for item in $liste 
	do 
        echo $item
	file=$(ls lists/$item | grep -v bak)
        for lfile in $file 
            do 
#                echo ./lists/$item/$lfile
                cp  ./lists/$item/$lfile ./lists/$item/bak/$lfile.1 
                egrep -v '^\s*$|^#' ./lists/$item/$lfile | sed -e 's/127.0.0.1//' | sed -e 's/0.0.0.0//'   | sed -e 's/^[ ]*//' >> $2  
	    done
        done
        egrep -v localhost $2 > $2.1
        cat $2.1 | sed 's/  / /g' | sed 's/#[^#]*$//' | sed -e 's/\t//' | sort -u > $2.2
        
