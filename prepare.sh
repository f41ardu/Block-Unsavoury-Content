#/bin/sh

if [ ! -d "tmp" ]; then
    mkdir tmp
fi


if [ ! -d "lists" ]; then 
     mkdir lists
fi




for loop  in $(cat $1) 
do 
	
list_item=$(echo $loop | sed 's/\//;/g' | cut -d ';' -f3)
echo $list_item


if [ ! -d "lists/"$list_item ]; then 
     mkdir lists/$list_item
fi
wget -o -q -N -P lists/$list_item/ $loop

# egrep -v '^\s*$|^#|localhost' psh.txt | awk {'print $2'} 

done
done
