#Ex9
#!/bin/bash
#Luis Ruiz
clear

echo -n "Escriu la quantitat d'usuaris que vols fer: "
read qt
if [[ $qt -lt 1 ]] || [[ $qt -gt 100 ]]
then
	echo "Error. Ha d'estar entre 1 i 100"
	exit 1
fi
echo -n "Posa el valor inicial de l'uidNumber, més de 5000: "
read vinic

echo -n "Introdueix la contrasenya admin del ldap: "  
read -s ctsAdm
echo

if [[ -e ctsUsuaris.txt ]]
then
    rm ctsUsuaris.txt
fi

NumUsr=$vinic
for (( i=1; i<=$qt; i++))

do
    idUsr=usr$NumUsr
    ctsnya_usr=$(pwgen 10 1)
    uo="UsuarisGrups"
    grp="UsuarisDomini"

    echo "$idUsr ------ $ctsnya_usr" >> ctsUsuaris.txt
    echo "objectClass: top"  >> ctsUsuaris.txt
	echo "objectClass: person" >> ctsUsuaris.txt
	echo "objectClass: organizationalPerson" >> ctsUsuaris.txt
	echo "objectClass: inetOrgPerson" >> ctsUsuaris.txt
	echo "objectClass: posixAccount" >> ctsUsuaris.txt
	echo "objectClass: shadowAccount" >> ctsUsuaris.txt
    echo "objectClass: userPassword" >> ctsUsuaris.txt
    ldappasswd -h localhost -x -D "cn=admin,dc=fjeclot,dc=net" -w $ctsAdm -s "$ctsnya_usr" "uid=$idUsr,cn=$grp,ou=$uo,dc=fjeclot,dc=net"
    ((NumUsr++))
    #-w "$ctsAdm" -s "$ctsnya"
	if (( $? != 0 ))
	then
		echo "Contrasenya incorrecte o usuari no existeix"
		exit 3
	fi

done

echo "Esta fet!"
exit 0
