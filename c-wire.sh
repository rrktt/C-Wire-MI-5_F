#!/bin/bash 

oldIFS=$IFS

IFS=$'\n'


testArg(){

    if (( $# <= 2 )) || (( $# >= 5 )) ; then

        return 1
    
    else

        a="$(file -b $1)"
        b='ASCII text'

        if [ ! -f $1 ] || [ "$a" != "$b" ] || [ "$1" != "c-wire.sh" ] ; then

            return 1

        fi

        if [ "$2" != "hva" ] && [ "$2" != "hvb" ] && [ "$2" != "lv" ] ; then

            return 1
    
        fi

        if [ "$3" != "comp" ] && [ "$3" != "indiv" ] && [ "$3" != "all" ] ; then

            return 1

        fi

        if [ $# -eq 4 ] ; then

            if [ $( echo $4 | grep '*[0-9]' ) ] ; then

                return 1

            fi

    

    fi

    return 0

}






echo $a

echo

#cat ${1}

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


IFS=$oldIFS



exit