Encrypt
openssl enc -aes-256-cbc -salt -in list.inp -out list.inp.enc

Decrypt 
openssl enc -aes-256-cbc -d -in list.inp.enc -out list.inp
