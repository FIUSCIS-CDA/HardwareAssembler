#!/bin/bash

vlib work
for i in *.v
do
   vlog $i
done
#-exec vlog {} \;
#vlog testbench.v

for d in */ ; do
    echo "**************** TESTING GROUP $d ************************"
    cd $d
    mv *$1*.bdf $1.bdf #OneBitAdder.bdf
    mv *$2*.bdf $2.bdf #OneBitAdder.bdf
    mv *$3*.bdf $3.bdf #OneBitAdder.bdf
    mv *$4*.bdf $4.bdf #OneBitAdder.bdf
    mv *$5*.bdf $5.bdf #OneBitAdder.bdf
    mv *$6*.v $6.v
    #quartus_map --read_settings_files=on --write_settings_files=off OneBitAdder -c OneBitAdder --convert_bdf_to_verilog=OneBitAdder.bdf
    quartus_map --read_settings_files=on --write_settings_files=off $1 -c $1 --convert_bdf_to_verilog=$1.bdf
    quartus_map --read_settings_files=on --write_settings_files=off $2 -c $2 --convert_bdf_to_verilog=$2.bdf
    quartus_map --read_settings_files=on --write_settings_files=off $3 -c $3 --convert_bdf_to_verilog=$3.bdf
    quartus_map --read_settings_files=on --write_settings_files=off $4 -c $4 --convert_bdf_to_verilog=$4.bdf
    quartus_map --read_settings_files=on --write_settings_files=off $5 -c $5 --convert_bdf_to_verilog=$5.bdf
    cd ..
    #if [ -f $d/OneBitAdder.v ] 
    if [ -f $d/$1.v ] 
    then
       #vlog $d/OneBitAdder.v
       if [ -f $d/$2.v ]
       then 
       if [ -f $d/$3.v ]
       then 
       if [ -f $d/$4.v ]
       then 
       if [ -f $d/$5.v ]
       then 
          vlog $d/$1.v
          vlog $d/$2.v 
          vlog $d/$3.v
          vlog $d/$4.v
          vlog $d/$5.v
          vlog $d/$6.v
          vsim -c -do "force -freeze sim:/testbench/clk 1 0, 0 {2 ps} -r 5; run 360; quit" testbench
       else
          echo "MISSING FILES.  EXITING..."
       fi
       else
          echo "MISSING FILES.  EXITING..."
       fi
       else
          echo "MISSING FILES.  EXITING..."
       fi
       else
          echo "MISSING FILES.  EXITING..."
       fi
    else
       echo "MISSING FILES.  EXITING..."
    fi
    echo "**************** DONE TESTING GROUP $d ************************"
done
