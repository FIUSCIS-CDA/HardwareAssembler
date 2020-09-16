#!/bin/bash

###############################################################################
# You can run this script in the root directory.  It will traverse
# all subdirectories.
#
# I used this to test a project (IP2, Part 2B for those who remember) in my
# CDA4101 course.
#
# Arguments were hardcoded.  Students had to complete 5 BDF files and 1 V file
# 5 BDF files: FSM.bdf, NS0.bdf, NS1.bdf, NS2.bdf, NS3.bdf
# V file: microprogram.v
# To run: FSM NS0 NS1 NS2 NS3 microprogram
# Since it was one-time use, I hardcoded it to take six inputs, and assumed
# the first five were BDF and the last was V
#
# To be clear how this works:
# 
# Files I provided to the class before the project are in the root folder
# Student submissions are in subfolders
#
# General structure
#
# 1. Create a work library for ModelSim
# 2. Compile all Verilog files in the root folder
# 3. For each subfolder:
#    - For each argument, mv any file that contained that string into 
#      the appropriate filename.  Sometimes Canvas named files NS0Group14.bdf,
#      for example.  That would get moved to NS0.bdf
#    - For each BDF file, generate Verilog (use 'quartus map')
#    - If successful, we have six Verilog files, compile each (command is 'vlog')
#    - Run my testbench.  I used the command:
#      vsim -c -do "force -freeze sim:/testbench/clk 1 0, 0 {2 ps} -r 5; run 360; quit" testbench
#      This runs testbench for 360 time units using a clock that starts on the rising edge (1 0) 
#      with a period of 5 (-r 5).
#      Note: In ModelSim if you do anything in the GUI and you look at the transcript,
#      you will see the commands that run in the terminal.
#
# Purpose of this script is to understand how to use Quartus and ModelSim from the commandline
# These are only a subset of commands available, there are others and you should check them out
# See what will be most useful for the goals of the project.
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
