#!/bin/bash

# Usage: ./simScript.sh [flags][argument for flags][files to process]
# Example: ./simScript.sh -u 300 -p 4


# Variables
time_units=0 # flag for this will be -u
time_period=0 # flag for this will be -p

# Files array
files_array=()
 

# Creating a temp file to hold temporary data
temp=''

#################################### Functions ####################################
# gets the time units for testbench excecution
getTimes(){
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
}

 # gets all files and makes sure that all of them are verilog (.v) files
processFiles(){
   for file in "${files_array[@]}"

   do
      # check if the file is a .bdf
      if [ ${file: -4} == ".bdf" ]
         then quartus_map --read_settings_files=on --write_settings_files=off $file -c $file --convert_bdf_to_verilog=$file.bdf
      fi
   done
}

# gets all files from the command line and inserts them into an array
populateArray(){
   for file in "$@"
   do
     if [[ $file != "testbench.v" ]]
     	then files_array=($files_array[*] "$file")
      fi
   done
}
############################################################################################
# Capturing time related flags
if [[ -d work ]]
then rm -rf work
fi

getTimes
populateArray
processFiles
# 1. Create a work library for ModelSim
vlib work

# 2. Compile all Verilog files in the root folder
for i in *.v
do
	vlog $i >& temp.txt	
done

# traps and excecution
# trap "rm $temp; echo; echo Interrupt has occured; exit 1" 1 2 15
# 3. Excecute testbench for .v files after compilation
vsim -c -do "force -freeze sim:/testbench/clk 1 0, 0 {2 ps} -r $time_period; run $time_units; quit" testbench.v
# trap "" 1 2 15

grep '*\*\ Error' temp.txt > temp1.txt
rm temp.txt
mv temp1.txt temp.txt
grep '*\*\ Error' transcript >> temp.txt
# rm output.txt
mv temp.txt output.txt
rm transcript

