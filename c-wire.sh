#!/bin/bash 

oldIFS=$IFS

IFS=$'\n'


testArg(){

    if (( $# <= 2 )) || (( $# >= 5 )) ; then

        echo "argument problem / give more arguments or supp arguments"

        return 1
    
    else
        a="$(file -b $1)"
        b='ASCII text'

        if [ ! -f $1 ] || [ "$a" != "$b" ] || [ $(echo $1 | grep "c-wire") ] ; then

            echo "problem with c-wire.dat"

            return 1

        fi

        if [ "$2" != "hva" ] && [ "$2" != "hvb" ] && [ "$2" != "lv" ] ; then

            echo "problem with station's type"

            return 1
    
        fi

        if [ "$3" != "comp" ] && [ "$3" != "indiv" ] && [ "$3" != "all" ] ; then

            echo "problem with type"

            return 1

        fi

        if [ $# -eq 4 ] ; then

            if [ $( echo $4 | grep '*[0-9]' ) ] ; then

                echo "problem with cental"

                return 1

            fi

        fi

    

    fi

    return 0

}




echo

#cat ${1}

test=`testArg`
rep1=$?

echo $rep1

if [ ! $rep1 ] ; then




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