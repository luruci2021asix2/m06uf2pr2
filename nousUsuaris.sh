#Ex8
#!/bin/bash
#Luis Enrique Ruiz

clear

while [[ true ]]

do
    echo "Numero d'usuaris totals entre 1 a 100 "
    read users
    if ((users >=1 && users <= 100))
    then
        while [[ true ]]
        do
            echo "Valor uid per usuaris (minim 5000) "
            read idNumb
            if ((idNumb >= 5000))
            then

               for (( contador=0; contador<users; contador++ ))
                do
                    
                    echo "dn: uid=usr$idNumb,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" >> user.ldif
                    echo "objectClass: top" >> user.ldif
                    echo "objectClass: posixAccount" >> user.ldif
                    echo "objectClass: shadowAccount" >> user.ldif
                    echo "objectClass: person" >> user.ldif
                    echo "uid:usr$idNumb" >> user.ldif
                    echo "gidNumber: 100" >> user.ldif
                    echo "loginShell: /bin/bash" >> user.ldif
                    echo "cn: usr$idNumb usr$idNumb" >> user.ldif
                    echo "sn: usr$idNumb" >> user.ldif
                    echo "homeDirectory: /home/usr$idNumb" >> user.ldif
                    echo "" >> user.ldif
                    echo "" >> user.ldif
                    ((idNumb++))
                done
                
                ldapadd -x -W -D "cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" -f user.ldif
        
            break;
            fi
            
        done
    break;        
    fi
    
done


exit 0
