# C-Wire-MI-5_F

To use our project:

Please note that gnuplot must be installed on your computer to have the histograms.

First step open a terminal and place yourself in the project folder.

Second step you must write: "bash c-wire.sh" in the terminal to know which bash script should be executed.

Third step you must give the absolute path of your file which contains the data to be processed. This file must be a .dat and and must have eight columns of values ​​per line separated by ";"

Fourth step you must put the type of station you want to process so hvb, hva or lv.

Fifth step put as argument the type of targeted consumer so comp (for companies), indiv (for individuals) or all (for both). Be careful you cannot put as argument hvb or hva and indiv or all.

Bonus step if you want to target a particular power plant you can put its number so that the program focuses only on this particular power plant.

Final step press enter and if all the elements have been put in the right way the program should run without problem.

If you want help you can put "-h" as an argument to have the details of the arguments to place.

The values ​​of the file created by the c program are then sorted by increasing capacity as requested in the expectations

EXEMPLE: - "bash c-wire.sh /Users/"USERNAME"/Desktop/c-wire_v25.dat hva comp"
        - "bash c-wire.sh /Users/"USERNAME"/Desktop/c-wire_v25.dat lv all 1"
        - "bash c-wire.sh -h"
        - "bash c-wire.sh /Users/"USERNAME"/Desktop/c-wire_v25.dat -h lv comp"