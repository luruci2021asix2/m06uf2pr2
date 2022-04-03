#Ex10
#!/bin/bash
#Luis Ruiz

clear

echo "Usuaris a esborrar entre 1 i 100: "
read qt
# salta el missatge d'error
if [[ $qt -lt 1 ]] || [[ $qt -gt 100 ]]
then
	echo "error: s'han de esborrar usuaris entre el numero 1 i 100."
	exit 1
fi

#uid inicial
echo "Valor inicial UID a de ser +5000 : "
read vinic
vinic=$((vinic-1))
#si no es gran salta missatge d'error
if (( $vinic < 4999 ))
then
	echo "Error la UID té que ser +5000."
	exit 2
fi

echo "Password admin ldap: "
read -s ctsAdm

#Borra el fitxer nousUsuaris.ldif
sudo rm esborraUsuaris.ldif

#Crea el fitxer nous.Usuaris.ldif nou
sudo touch esborraUsuaris.ldif

NumUsr=$vinic

for (( i=1; i<=$qt; i++ ))
do
	NumUsr=$((vinic+i))
	idUsr=usr$NumUsr
	echo "dn: uid=$idUsr,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" > esborraUsuaris.ldif
	echo "changetype: delete" >> esborraUsuaris.ldif
	echo "" >> esborraUsuaris.ldif
	NumUsr=$(( $NumUsr + 1 ))

	ldapmodify -h localhost -x -D "cn=admin,dc=fjeclot,dc=net" -w "$ctsAdm" -f esborraUsuaris.ldif
	
	if (( $? != 0 ))
	then
		echo "Error en la Contrasenya, incorrecte o usuari no existeix"
		exit 3
	fi


done

echo "Usuaris esborrats"

exit 0

