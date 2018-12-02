GIT 

https://www.linux.com/learn/beginning-git-and-github-linux-users
sed -e 's/^M//' my3.txt > my4.txt
erzeuge ^M durch drücken von CTRL-^ CTRL-M
To enter ^M, type CTRL-V, then CTRL-M. That is, hold down the CTRL key then press V and M in succession. 

Leerzeichen und # entfernen 
egrep -v '^\s*$|^#'

awk '{print "local-data: \""$1" A 0.0.0.0\""}' my4.txt > block3.txt


Für hostfiles 
egrep -v '^\s*$|^#|localhost' psh.txt | awk {'print $2'}

