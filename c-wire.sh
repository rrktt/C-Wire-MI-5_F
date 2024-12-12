#!/bin/bash 




testArg(){

    if (( $# <= 2 )) || (( $# >= 5 )) ; then

        echo "argument problem / give more arguments or supp arguments"
        return 1
    
    else

        if [ ! -f $1 ] || [ "$1" != "c-wire_v00.dat" ] ; then

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

    #if [ -f tmp/tmp.txt ] ; then

        #$(rm tmp/tmp.txt)
    
    #fi
    
    #$(awk -F';' '$3 == "-" && $4 == "-" && $2 == "-" {print $0}' $1 > tmp/tmp.txt)
    awk -F';' '$3 != "-" && $4 == "-" {print $0}' $1 > tmp/tmp.txt
    cut -d';' -f3,7,8 tmp/tmp.txt > tmp/tmpa.txt

    sed 's/-/0/g' tmp/tmpa.txt > tmp/tmpb.txt

    sed 's/;/ /g' tmp/tmpb.txt > tmp/tmpc.txt


}

hvbComp(){

    #if [ -f tmp/tmp.txt ] ; then

        #$(rm tmp/tmp.txt)
    
    #fi

    #$(awk -F';' '$3 == "-" && $4 == "-" && $2 == "-" {print $0}' $1 > tmp/tmp.txt)
    awk -F';' '$2 != "-" && $3 == "-" {print $0}' $1 > tmp/tmp.txt
    cut -d';' -f2,7,8 tmp/tmp.txt > tmp/tmpa.txt

    sed 's/-/0/g' tmp/tmpa.txt > tmp/tmpb.txt

    sed 's/;/ /g' tmp/tmpb.txt > tmp/tmpc.txt


}

lvComp(){

    #if [ -f tmp/tmp.txt ] ; then

        #$(rm tmp/tmp.txt)
    
    #fi

    #$(awk -F';' '$3 == "-" && $4 == "-" && $2 == "-" {print $0}' $1 > tmp/tmp.txt)
    awk -F';' '$7 != "-" && $4 != "-" && $2 == "-" {print $0}' $1 > tmp/tmp.txt
    awk -F';' '$5 != "-" && $4 != "-" && $2 == "-" {print $0}' $1 >> tmp/tmp.txt
    cut -d';' -f4,7,8 tmp/tmp.txt > tmp/tmpa.txt

    sed 's/-/0/g' tmp/tmpa.txt > tmp/tmpb.txt

    sed 's/;/ /g' tmp/tmpb.txt > tmp/tmpc.txt

    #sed -ri 's/^[[:blank:]]*'"-"'=[^#]*(#?.*)/'"-=0"' \1/' tmp/tmpa.txt




}

lvIndiv(){

    #if [ -f tmp/tmp.txt ] ; then

        #$(rm tmp/tmp.txt)
    
    #fi

    #$(awk -F';' '$3 == "-" && $4 == "-" && $2 == "-" {print $0}' $1 > tmp/tmp.txt)
    awk -F';' '$7 != "-" && $4 != "-" && $2 == "-" {print $0}' $1 > tmp/tmp.txt
    awk -F';' '$6 != "-" && $4 != "-" && $2 == "-" {print $0}' $1 >> tmp/tmp.txt
    cut -d';' -f4,6,8 tmp/tmp.txt > tmp/tmpa.txt

    sed 's/-/0/g' tmp/tmpa.txt > tmp/tmpb.txt

    sed 's/;/ /g' tmp/tmpb.txt > tmp/tmpc.txt


}

lvAll(){

    #if [ -f tmp/tmp.txt ] ; then

        #$(rm tmp/tmp.txt)
    
    #fi



    #$(awk -F';' '$3 == "-" && $4 == "-" && $2 == "-" {print $0}' $1 > tmp/tmp.txt)
    #$(awk -F';' '$4 != "-" && $2 == "-" {print $0}' $1 >> tmp/tmp.txt)
    #$(cut -d';' -f4,6,8 tmp/tmp.txt > tmp/tmpc.txt)

    return 0
}


chooseCentral(){

    if [ "$2" == "hvb" ] ; then

        hvbComp $1
    

    elif [ "$2" == "hva" ] ; then

        hvaComp $1

    elif [ "$2" == "lv" ] && [ "$3" == "comp" ] ; then

        lvComp $1

    elif [ "$2" == "lv" ] && [ "$3" == "indiv" ] ; then

        lvIndiv $1

    else 

        lvAll $1

    fi


    return 0
}



oldIFS=$IFS

IFS=$'\n'

test=`testArg $@`
rep1=$?


if [ $rep1 -eq 0 ] ; then

    echo $test


    chooseCentral $@

    gcc -o ex codeC/main.c
    #./ex





else 
    echo $test
    echo "exiting..."    
fi

#rm -rf tmp/*


IFS=$oldIFS



exit