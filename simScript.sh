#!/bin/bash

# Usage: ./simScript.sh

# Not completed. Want to add more felxibility to the user so that they can customize their output a bit more. 


# 1. Create a work library for ModelSim
vlib work
# 2. Compile all Verilog files in the root folder
for i in *.v
do
   vlog $i
done

temp=/tmp/simScript.$$

trap "rm $temp; echo; echo Interrupt has occured; exit 1" 1 2 15

# 3. Excecute testbench for .v files after compilation
vsim -c -do "force -freeze sim:/testbench/clk 1 0, 0 {2 ps} -r 5; run 360; quit" testbench >& $temp

trap "" 1 2 15






