#Ex4
#!/bin/bash
#Luis Ruiz
clear
if (( $EUID != 0 )) 
then
  echo "Aquest script es té que executar amb sudo o root"
  exit 1 
fi

DATA=$(date +20%y%m%d%H%M)


if [[ ! -d /$1 ]]
then
	echo "Vols crear-lo si o no: "
	read opc
	if [[ $opc == "si" ]]
	then
		mkdir $1
		cp /etc/resolv.conf $1
	else
		echo "No puc sense tenir un directori"
		exit 1
	fi
fi
cd $1

cp resolv.conf resolv.conf.backup.$DATA

for a in resolv.conf.backup.$DATA

do
	
    gzip $a

done

sudo rm resolv.conf

echo "Comprimit"

tar -cfv resolv.conf$DATA resolv.conf.backup.$DATA.gz
 #sudo rm resolv.conf
exit 0
