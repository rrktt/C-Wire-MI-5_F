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




        if [ ! -f $1 ] || [ "$fichier" != "c-wire_v00.dat" ] ; then

            echo "problem with c-wire.dat"

            return 1

        fi

        if [ "$2" != "hva" ] && [ "$2" != "hvb" ] && [ "$2" != "lv" ] ; then

            echo "problem with station's type"

            return 1
    
        fi

        if ( ( [ "$2" == "hva" ] || [ "$2" == "hvb" ] ) && ( [ "$3" == "all" ] || [ "$3" == "indiv" ] ) ) ; then

            echo "problem with the type hvb/hva"

            return 1

        fi

        if [ "$3" != "comp" ] && [ "$3" != "indiv" ] && [ "$3" != "all" ] ; then

            echo "problem with the type"

            return 1

        fi

        if [ $# -eq 4 ] ; then

            var2=`echo $4 | cut -c 1-`

            for (( i = 1 ; i <= (${#4}) ; i++ )) ; do

                var2=`echo $4 | cut -c$i`
                isnum=$(echo "$var2" | grep "[0-9]")


                if [ "$isnum" != "$var2" ] ; then

                    echo "problem with cental"

                    return 1

                fi


            done

        fi

    

    fi

    return 0

}

hvaComp(){

    if [ -f /tmp/tmp.txt ] ; then

        $(rm /tmp/tmp.txt)
    
    fi

    for ligne in $(<$1)
    do 

        hva=$(echo $ligne | cut -d';' -f3)
        cons=$(echo $ligne | cut -d';' -f7)
        nolv=$(echo $ligne | cut -d';' -f4)
        conso=$(echo $ligne | cut -d';' -f5)
        comp=$(echo $ligne | cut -d';' -f8)

        if [ "$hva" != "-" ] && [ "$cons" != "-" ] && [ "$nolv" == "-" ] ; then

            $(echo $ligne >> tmp/tmp.txt)

        fi

        if [ "$hva" != "-" ] && [ "$conso" != "-" ] && [ "$nolv" == "-" ] && [ "$comp" != "-" ] ; then

            $(echo $ligne >> tmp/tmp.txt)

        fi


    done

    return 0

}

hvbComp(){
    return 0
}

lvComp(){
    return 0
}

lvIndiv(){
    return 0
}

lvAll(){
    return 0
}



test=`testArg $@`
rep1=$?





if [ $rep1 -eq 0 ] ; then

    echo $test

    if [ "$2" == "hva" ] ; then

        $(hvaComp $1)

    fi

    c=`cut -d';' -f 1- $1`

    #echo $c

    #`cut -d';' -f 1 $1  > "tem.csv"`


else 
    echo $test
    echo "exiting"    
fi


IFS=$oldIFS



exit