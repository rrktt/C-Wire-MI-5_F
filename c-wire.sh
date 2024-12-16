#!/bin/bash 




testArg(){

    for elm in $@ ; do

        if [ "$elm" == "-h" ] ; then
            return 1
        fi

    done

    if (( $# <= 2 )) || (( $# >= 5 )) ; then

        echo "/ ! \ argument problem / give more arguments or supp arguments"
        return 1
    
    else

        if [ ! -f $1 ] || [ "$1" != "c-wire_v00.dat" ] ; then

            echo "/ ! \ problem with c-wire.dat"

            return 1

        fi

        if [ "$2" != "hva" ] && [ "$2" != "hvb" ] && [ "$2" != "lv" ] ; then

            echo "/ ! \ problem with station's type"

            return 1
    
        fi

        if ( ( [ "$2" == "hva" ] || [ "$2" == "hvb" ] ) && ( [ "$3" == "all" ] || [ "$3" == "indiv" ] ) ) ; then

            echo "/ ! \ problem with the type hvb/hva"

            return 1

        fi

        if [ "$3" != "comp" ] && [ "$3" != "indiv" ] && [ "$3" != "all" ] ; then

            echo "/ ! \ problem with the type"

            return 1

        fi

        if [ $# -eq 4 ] ; then

            var2=`echo $4 | cut -c 1-`

            for (( i = 1 ; i <= (${#4}) ; i++ )) ; do

                var2=`echo $4 | cut -c$i`
                isnum=$(echo "$var2" | grep "[0-9]")


                if [ "$isnum" != "$var2" ] ; then

                    echo "/ ! \ entrer a correct number for the central"

                    return 1

                fi


            done

            testc=`cut -d';' -f1 "$1" | grep "$4"`
            testcentral=$?

            if [ $testcentral -eq 2 ] || [ $testcentral -eq 1 ] ; then

                echo "/ ! \ no central $4 found"

                return 1

            fi

        fi

    

    fi

    return 0

}



hvaComp(){


    if [ $# -ne 4 ] ; then

        awk -F';' '$3 != "-" && $4 == "-" {print $3" "$7" "$8}' $1 > tmp/tmp.txt
        #cut -d';' -f3,7,8 tmp/tmp.txt > tmp/tmpa.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt

        #sed 's/;/ /g' tmp/tmpb.txt > tmp/tmpc.txt
    
    else 

        central=$4

        awk -F';' -v cent="$central" '$3 != "-" && $4 == "-" && $1 == cent {print $3" "$7" "$8}' $1 > tmp/tmp.txt
        #cut -d';' -f3,7,8 tmp/tmp.txt > tmp/tmpa.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt

        #sed 's/;/ /g' tmp/tmpb.txt > tmp/tmpc.txt

    fi




}

hvbComp(){

    if [ $# -ne 4 ] ; then

        #$(awk -F';' '$3 == "-" && $4 == "-" && $2 == "-" {print $0}' $1 > tmp/tmp.txt)
        awk -F';' '$2 != "-" && $3 == "-" {print $2" "$7" "$8}' $1 > tmp/tmp.txt
        #cut -d';' -f2,7,8 tmp/tmp.txt > tmp/tmpa.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt

        #sed 's/;/ /g' tmp/tmpb.txt > tmp/tmpc.txt
    
    else

        central=$4

        awk -F';' -v cent="$central" '$2 != "-" && $3 == "-" && $1 == cent {print $2" "$7" "$8}' $1 > tmp/tmp.txt
        #cut -d';' -f2,7,8 tmp/tmp.txt > tmp/tmpa.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt

        #sed 's/;/ /g' tmp/tmpb.txt > tmp/tmpc.txt

    fi




}

lvComp(){

    if [ $# -ne 4 ] ; then

        #$(awk -F';' '$3 == "-" && $4 == "-" && $2 == "-" {print $0}' $1 > tmp/tmp.txt)
        #awk -F';' '$7 != "-" && $4 != "-" && $2 == "-" {print $0}' $1 > tmp/tmp.txt
        awk -F';' '$6 == "-" && $4 != "-" && $2 == "-" {print $4" "$7" "$8}' $1 > tmp/tmp.txt
        #cut -d';' -f4,7,8 tmp/tmp.txt > tmp/tmpa.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt

        #sed 's/;/ /g' tmp/tmpb.txt > tmp/tmpc.txt

    else

        central=$4

        awk -F';' -v cent="$central" '$6 == "-" && $4 != "-" && $2 == "-" && $1 == cent {print $4" "$7" "$8}' $1 > tmp/tmp.txt
        #cut -d';' -f4,7,8 tmp/tmp.txt > tmp/tmpa.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt

        #sed 's/;/ /g' tmp/tmpb.txt > tmp/tmpc.txt

    fi

    




}

lvIndiv(){

    if [ $# -ne 4 ] ; then

        #$(awk -F';' '$3 == "-" && $4 == "-" && $2 == "-" {print $0}' $1 > tmp/tmp.txt)
        #awk -F';' '$7 != "-" && $4 != "-" && $2 == "-" {print $0}' $1 > tmp/tmp.txt

        awk -F';' '$5 == "-" && $4 != "-" && $2 == "-" {print $4" "$7" "$8}' $1 > tmp/tmp.txt
        #cut -d';' -f4,7,8 tmp/tmp.txt > tmp/tmpa.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt

        #sed 's/;/ /g' tmp/tmpb.txt > tmp/tmpc.txt

    else

        central=$4

        awk -F';' -v cent="$central" '$5 == "-" && $4 != "-" && $2 == "-" && $1 == cent {print $4" "$7" "$8}' $1 > tmp/tmp.txt
        #cut -d';' -f4,7,8 tmp/tmp.txt > tmp/tmpa.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt

        #sed 's/;/ /g' tmp/tmpb.txt > tmp/tmpc.txt

    fi


}

lvAll(){

    if [ $# -ne 4 ] ; then

        #$(awk -F';' '$3 == "-" && $4 == "-" && $2 == "-" {print $0}' $1 > tmp/tmp.txt)
        #$(awk -F';' '$4 != "-" && $2 == "-" {print $0}' $1 >> tmp/tmp.txt)

        awk -F';' '$4 != "-" && $2 == "-" {print $4" "$7" "$8}' $1 > tmp/tmp.txt
        #cut -d';' -f4,7,8 tmp/tmp.txt > tmp/tmpa.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt

        #sed 's/;/ /g' tmp/tmpb.txt > tmp/tmpc.txt
    
    else 

        central=$4

        awk -F';' -v cent="$central" '$4 != "-" && $2 == "-" && $1 == cent {print $3" "$7" "$8}' $1 > tmp/tmp.txt
        #cut -d';' -f4,7,8 tmp/tmp.txt > tmp/tmpa.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt

        #sed 's/;/ /g' tmp/tmpb.txt > tmp/tmpc.txt

    fi

    return 0
}


chooseCentral(){

    if [ "$2" == "hvb" ] ; then

        hvbComp $@
    

    elif [ "$2" == "hva" ] ; then

        hvaComp $@

    elif [ "$2" == "lv" ] && [ "$3" == "comp" ] ; then

        lvComp $@

    elif [ "$2" == "lv" ] && [ "$3" == "indiv" ] ; then

        lvIndiv $@

    else 

        lvAll $@

    fi


    return 0
}

createGraph(){

    if [ $# -eq 4 ] ; then

        title="$2, $3 central : $4"
        xlabel="$2 station"
        ylabel="Energy (kWh)"
        output="graphs/graph.png"

        gnuplot << EOF


         set xlabel "$xlabel"
         set ylabel "$ylabel"
         set title "$title"
         set term png
         set output "$output"
         set datafile separator ":"

         set xrange [0:*]

         set style data histograms
         set style histogram clustered
         set boxwidth 0.7
         set style fill solid 

         plot "$1" using 2 t "Capacity", '' using 3 t "Consumption" 
EOF

    else
    
        title="$2 $3"
        xlabel="Central"
        ylabel="Energy (kWh)"
        output="graphs/graph.png"


        gnuplot << EOF
         set xlabel "$xlabel"
         set ylabel "$ylabel"
         set title "$title"
         set term png
         set output "$output"
         set datafile separator ":"

         set xrange [0:*]

         set style data histograms
         set style histogram clustered
         set boxwidth 0.7
         set style fill solid 

         plot "$1" using 2 t "Capacity", '' using 3 t "Consumption" 
EOF

    fi



}










oldIFS=$IFS

IFS=$'\n'

test=`testArg $@`
rep1=$?



if [ $rep1 -eq 0 ] ; then

    cp $1 input/

    if [ -e tests/ ] && [ -e input/ ] && [ -e graphs/ ] ; then

        rm -rf tmp/*
        rm -rf input/*
        rm -rf graphs/*

    fi


    chooseCentral $@

    path=$(pwd)

    path1="$path/tmp/tmpc.txt"
    path2="$path/test.csv"


    exex=$(make -C codeC/)
    ./codeC/exe $path1 $path2

    

    if [ $# -ne 4 ] ; then
        echo $2 station:Capacity:Consuption > tests/"$2"_"$3".csv
        cat test.csv >> tests/"$2"_"$3".csv
        rm -f test.csv
        createGraph tests/"$2"_"$3".csv $2 $3
    else
        echo $2 station:Capacity:Consuption > tests/"$2"_"$3"_"$4".csv
        cat test.csv >> tests/"$2"_"$3"_"$4".csv
        rm -f test.csv
        createGraph tests/"$2"_"$3"_"$4".csv $2 $3 $4
    fi

    
    sup=$(make -C codeC/ clean)





else 

    echo $test

    echo "/ ! \ how to use c-wire.sh : \n"

    echo "First argument is the .dat file"

    echo "The second is the station's type"

    echo "The third is the consumers you want to treat"

    echo "In option you can focus on a special power plant if it exist"
       
fi

#rm -rf tmp/*


IFS=$oldIFS



exit