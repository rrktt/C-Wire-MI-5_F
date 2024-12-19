#!/bin/bash 




testArg(){ #fonction to test all arguments

    for elm in $@ ; do #test -h option

        if [ "$elm" == "-h" ] ; then
            return 1
        fi

    done

    if (( $# <= 2 )) || (( $# >= 5 )) ; then #to mutch argument

        echo "/ ! \ argument problem / give more arguments or supp arguments"
        return 1
    
    else

        data=$(echo $1 | grep ".dat")
        ans=$?

        if [ ! -f $1 ] || [ $ans -ne 0 ] ; then #verification of the data file

            echo "/ ! \ problem with .dat file"

            return 1

        fi

        if [ "$2" != "hva" ] && [ "$2" != "hvb" ] && [ "$2" != "lv" ] ; then #verification of the second argument

            echo "/ ! \ problem with station's type"

            return 1
    
        fi

        if ( ( [ "$2" == "hva" ] || [ "$2" == "hvb" ] ) && ( [ "$3" == "all" ] || [ "$3" == "indiv" ] ) ) ; then #verification of the consisrency

            echo "/ ! \ problem with the type hvb/hva"

            return 1

        fi

        if [ "$3" != "comp" ] && [ "$3" != "indiv" ] && [ "$3" != "all" ] ; then #verification of the third argument

            echo "/ ! \ problem with the type"

            return 1

        fi

        if [ $# -eq 4 ] ; then #if a power plant is called

            var2=`echo $4 | cut -c 1-`

            for (( i = 1 ; i <= (${#4}) ; i++ )) ; do

                var2=`echo $4 | cut -c$i`
                isnum=$(echo "$var2" | grep "[0-9]")


                if [ "$isnum" != "$var2" ] ; then #if the central argument is not a number

                    echo "/ ! \ entrer a correct number for the central"

                    return 1

                fi


            done

            testc=`cut -d';' -f1 "$1" | grep "$4"`
            testcentral=$?

            if [ $testcentral -eq 2 ] || [ $testcentral -eq 1 ] ; then #is the power plant is in the file

                echo "/ ! \ no central $4 found"

                return 1

            fi

        fi

    

    fi

    return 0

}



hvaComp(){


    if [ $# -ne 4 ] ; then 

        awk -F';' '$3 != "-" && $4 == "-" {print $3" "$7" "$8}' input/data.dat > tmp/tmp.txt #take the important information for hva stations

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt #replace "-" -> "0" 

    
    else 

        central=$4

        awk -F';' -v cent="$central" '$3 != "-" && $4 == "-" && $1 == cent {print $3" "$7" "$8}' input/data.dat > tmp/tmp.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt


    fi




}

hvbComp(){

    if [ $# -ne 4 ] ; then

        awk -F';' '$2 != "-" && $3 == "-" {print $2" "$7" "$8}' input/data.dat > tmp/tmp.txt #take the important information for hvb stations

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt #replace "-" -> "0" 

    
    else

        central=$4

        awk -F';' -v cent="$central" '$2 != "-" && $3 == "-" && $1 == cent {print $2" "$7" "$8}' input/data.dat > tmp/tmp.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt


    fi




}

lvComp(){

    if [ $# -ne 4 ] ; then

        awk -F';' '$6 == "-" && $4 != "-" && $2 == "-" {print $4" "$7" "$8}' input/data.dat > tmp/tmp.txt #take the important information for lv stations

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt #replace "-" -> "0" 


    else

        central=$4

        awk -F';' -v cent="$central" '$6 == "-" && $4 != "-" && $2 == "-" && $1 == cent {print $4" "$7" "$8}' input/data.dat > tmp/tmp.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt


    fi

    




}

lvIndiv(){

    if [ $# -ne 4 ] ; then

        awk -F';' '$5 == "-" && $4 != "-" && $2 == "-" {print $4" "$7" "$8}' input/data.dat > tmp/tmp.txt #take the important information for lv stations

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt #replace "-" -> "0" 

    else

        central=$4

        awk -F';' -v cent="$central" '$5 == "-" && $4 != "-" && $2 == "-" && $1 == cent {print $4" "$7" "$8}' input/data.dat > tmp/tmp.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt

    fi


}

lvAll(){

    if [ $# -ne 4 ] ; then


        awk -F';' '$4 != "-" && $2 == "-" {print $4" "$7" "$8}' input/data.dat > tmp/tmp.txt #take the important information for lv stations

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt #replace "-" -> "0" 

    
    else 

        central=$4

        awk -F';' -v cent="$central" '$4 != "-" && $2 == "-" && $1 == cent {print $4" "$7" "$8}' input/data.dat > tmp/tmp.txt

        sed 's/-/0/g' tmp/tmp.txt > tmp/tmpc.txt


    fi

    return 0
}


chooseCentral(){ #choose the right fonction to summon based on the gived argument

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

createGraph(){ #Creation of the histogram with gnuplot

    if [ $# -eq 5 ] ; then

        title="$2, $3 central : $4"
        xlabel="$2 station"
        ylabel="Energy (kWh)"
        output="graphs/graph($5).png"

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
        output="graphs/graph($4).png"


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




ifLvAll(){ #fonction to create minMax for lv all

    if [ "$3" == "lv" ] && [ "$4" == "all" ] ; then

        nbligne=$(wc -l $1 | sed "s/^\ *//g" | cut -d " " -f 1) #get the number of line

        if [ $nbligne -gt 21 ] ; then #if line are greater than 21

            if [ $# -ne 5 ] ; then 

                head -n 11 $1 > tests/"$3"_"$4"minmax.csv
                tail $1 >> tests/"$3"_"$4"minmax.csv


            else

                head -n 11 $1 > tests/"$3"_"$4"_"$5"minmax.csv
                tail $1 >> tests/"$3"_"$4"_"$5"minmax.csv

            fi

        fi

    fi

}







oldIFS=$IFS

IFS=$'\n'

test=`testArg $@` #start with testing the arguments
rep1=$?



if [ $rep1 -eq 0 ] ; then #if arguments are correct



    if [ -e tmp/ ] ; then #test the presence of tmp directory

        rm -rf tmp/* #erase file in the directory

    else 

        mkdir tmp/ #create tmp directory

    fi

    if [ ! -e graphs/ ] ; then #test the presence of graphs directory

        mkdir graphs/ #create graphs directory
    

    fi

    getTime=$(date +%s) #get the actual time based on the timestamp
    
    cp $1 input/data.dat #copy the data file into the input directory

    deltaT=$(( $(date +%s) - getTime )) #get the time to do the operation

    echo "time to cp the input data file : $deltaT"



    getTime=$(date +%s)

    chooseCentral $@ #create the sorted tmp file

    deltaT=$(( $(date +%s) - getTime ))

    echo "time to create tmp files : $deltaT"



    path=$(pwd) #get the absolute path to this directory

    path1="$path/tmp/tmpc.txt"
    path2="$path/test.csv"


    exex=$(make -C codeC/) #compilation
    ./codeC/exe $path1 $path2 #run the c program



    
    getTime=$(date +%s)

    if [ $# -ne 4 ] ; then
        echo $2 station:Capacity:Consuption $3 > tests/"$2"_"$3".csv #create a new file based on the arguments gived 
        sort -t ':' -k 2 -n test.csv >> tests/"$2"_"$3".csv #add the file generated by the c program in the new file and sort it

        ifLvAll tests/"$2"_"$3".csv $@ #usefull to generate minMax

        rm -f test.csv #remove the original file generated by the c program

        createGraph tests/"$2"_"$3".csv $2 $3 def #create the graph
        
        if [ -e tests/"$2"_"$3"minmax.csv ] ; then #create the minMax graph
            createGraph tests/"$2"_"$3"minmax.csv $2 $3 minmax
        fi


    else

        echo $2 station:Capacity:Consuption $3 > tests/"$2"_"$3"_"$4".csv
        sort -t ':' -k 2 -n test.csv >> tests/"$2"_"$3"_"$4".csv

        ifLvAll tests/"$2"_"$3"_"$4".csv $@

        rm -f test.csv
        createGraph tests/"$2"_"$3"_"$4".csv $2 $3 $4 def

        if [ -e tests/"$2"_"$3"_"$4"minmax.csv ] && [ "$2" == "lv" ] && [ "$3" == "all" ] ; then
            createGraph tests/"$2"_"$3"_"$4"minmax.csv $2 $3 $4 minmax
        fi

    fi

    deltaT=$(( $(date +%s) - getTime ))

    echo "time to create graph : $deltaT"

    

    
    sup=$(make -C codeC/ clean) #clean the .o file and the exe of the codeC directory





else #summon the help option

    echo $test

    echo "/ ! \ how to use c-wire.sh :"

    echo "First argument is the .dat file"

    echo "The second is the station's type"

    echo "The third is the consumers you want to treat"

    echo "In option you can focus on a special power plant if it exist"
       
fi

#rm -rf tmp/*


IFS=$oldIFS



exit