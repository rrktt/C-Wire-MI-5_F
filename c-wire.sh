#!/bin/bash 

oldIFS=$IFS

IFS=$'\n'


testArg(){

    if (( $# <= 2 )) || (( $# >= 5 )) ; then

        echo "argument problem / give more arguments or supp arguments"
        return 1
    
    else
        comp1="$(file -b $1)"
        comp2='ASCII text'

        fichier=$(echo $1 | grep "c-wire_v00.dat")
        ret=$?




        if [ ! -f $1 ] || [ "$comp1" != "$comp2" ] || [ ! $ret ] ; then

            echo "problem with c-wire.dat"

            return 1

        fi

        if [ "$2" != "hva" ] && [ "$2" != "hvb" ] && [ "$2" != "lv" ] ; then

            echo "problem with station's type"

            return 1
    
        fi

        if ( ( [ "$2" == "hva" ] || [ "$2" == "hvb" ] ) && ( [ "$3" == "all" ] || [ "$3" == "all" ] ) ) ; then

            echo "problem with the type hvb/hva"

            return 1

        fi

        if [ "$3" != "comp" ] && [ "$3" != "indiv" ] && [ "$3" != "all" ] ; then

            echo "problem with the type"

            return 1

        fi

        if [ $# -eq 4 ] ; then

            var2=`echo $4 | cut -c1-`

            for ch in $var2
            do

                if [ "$(echo $ch | grep '*[0-9]')" != "ch" ] ; then

                    echo "problem with cental"

                    return 1

                fi

            done

        fi

    

    fi

    return 0

}





test=`testArg $@`
rep1=$?

var="12345678AZERTYU"
var2=`echo $var | cut -c1-`
for v in $var2
do

    echo $v
    echo
done

echo $var2


if [ $rep1 -eq 0 ] ; then




    for ligne in $(<$1)
    do 

        #echo $ligne
        hva=$(echo $ligne | cut -d';' -f3)
        cons=$(echo $ligne | cut -d';' -f7)
        nolv=$(echo $ligne | cut -d';' -f4)
        #echo $aa
        if [ "$hva" != "-" ] && [ "$cons" != "-" ] && [ "$nolv" == "-" ] ; then

            echo $ligne
            echo
            #echo

        fi
    done

    c=`cut -d';' -f 1- $1`

    #echo $c

    #`cut -d';' -f 1 $1  > "tem.csv"`


else 
    echo $test
    echo "exiting"    
fi


IFS=$oldIFS



exit