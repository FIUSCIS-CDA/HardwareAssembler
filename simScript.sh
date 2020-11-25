#!/bin/bash

# Usage: ./simScript.sh [flags][argument for flags]
# Example: ./simScript.sh -u 300 -p 4


# Not completed. Want to add more felxibility to the user so that they can customize their output a bit more. 

##########################
# Creating a temp file
temp=/tmp/simScript.$$ 
###########################

###########################
# Capturing flags
time_units=0 # flag for this will be -u 
time_period=0 # flag for this will br -p
for arg in "$@"
do
	case $arg in
		-u) time_units=$2
		shift # removing argument name from processing
		shift # removing argument value from processing
		;;
		-p) time_period=$2
		shift # removing argument name from processing
		shift # removing argument value from processing
		;;
	esac
done
###########################


###########################
# 1. Create a work library for ModelSim

vlib work

##########################


##########################
# 2. Compile all Verilog files in the root folder

for i in *.v
do
	vlog $i>>temp
        echo 'Finished module compilation 
	
	
	' >> temp	
done
##########################


##########################
# traps and excecution
trap "rm $temp; echo; echo Interrupt has occured; exit 1" 1 2 15

# 3. Excecute testbench for .v files after compilation
vsim -c -do "force -freeze sim:/testbench/clk 1 0, 0 {2 ps} -r $time_period; run $time_units; quit" testbench.v >& $temp

trap "" 1 2 15

##########################
