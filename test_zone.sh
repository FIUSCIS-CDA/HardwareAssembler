#!/bin/bash
# Compiles module and runs testbench to verify component
validate_module() {
  #statements
  echo "Variable passed: $1"
  cd $1
	echo Testing module
	quartus_map --read_settings_files=on --write_settings_files=off $1 -c $1 --convert_bdf_to_verilog=$1.bdf
  wait
  vlog *.v
  wait
	vsim -c -do "force -freeze sim:/testbench/clk 1 0, 0 {2 ps} -r 5; run 360; quit" testbench
  wait
  echo Finished testing module
	cd ..

}

unset repo_array i
while IFS= read -r repos; do
  repo_array[i++]="$repos"
  #echo $repo
done < Repo_Names

echo "Please select the the number of the Repository to clone"
echo "Example: 1.) Adder_32 2.) ALU32...., input 1 to clone Adder_32"
echo ""

select hardware_repo in "${repo_array[@]}" "Exiting the script"; do
  case $hardware_repo in

    "Exiting the script")
      echo "Now Exiting Script.."
      break
      ;;
     *)
      echo "$hardware_repo repository was selected"
			# Cloning Repository
			git clone "https://github.com/FIUSCIS-CDA/$hardware_repo.git"
      validate_module $hardware_repo
      break
      ;;
  esac
done

# Retrieve dependencies from recently cloned repository
cd $hardware_repo
awk -F/ '{print $3}' "$hardware_repo.qsf" > tmp.txt
grep -e ".*\.bdf" tmp.txt > tmp1.txt
sed 's/.bdf//g' tmp1.txt > tmp.txt

# Read tmp.txt using each line as a parameter in git clone
while IFS= read -r dependencies; do
	echo -n "Dependency currently cloning: $dependencies"
	 #FIXME add user confirmation to proceed and warning if no
	 #Clone necessary dependencies

	git clone "https://github.com/FIUSCIS-CDA/$dependencies.git"
  cd $dependencies
  mv * ..
  cd ..
  echo "Deleting $dependencies folder"
  rm -r $dependencies
	validate_module $dependencies
done < tmp.txt


validate_module $dependencies

# Clean temp files
rm tmp1.txt tmp.txt
