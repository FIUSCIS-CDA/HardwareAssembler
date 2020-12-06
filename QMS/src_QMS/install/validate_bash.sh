#!/bin/bash


# Check if git command exists else install
if ! command -v git &>/dev/null; then
  echo "COMMAND could not be found"
  sudo apt install git -y
elif command -v git &>/dev/null; then
  echo "COMMAND found!"
fi

# Check if wget command exists else install
if ! command -v wget &>/dev/null; then
  echo "wget command could not be found"
  sudo apt install wget -y
elif command -v wget &>/dev/null; then
  echo "wget command found!"
fi

sudo apt update -y
sudo apt upgrade -y

if command -v wget &>/dev/null && command -v git &>/dev/null; then
  echo ""
  echo "----------------------------"
  echo "Bash shell ready for QMS!"
  echo "----------------------------"
  echo ""
elif ! command -v wget &>/dev/null && ! command -v git &>/dev/null; then
  echo ""
  echo "----------------------------"
  echo "A problem occured with the installation of wget or git"
  echo "Please manually install or check if wget and git are available"
  echo "Use [sudo apt install 'name_of_command'] to install what is missing"
  echo "----------------------------"
  echo ""
fi

cd ../man/man1
sudo cp * /usr/share/man/man1
echo ""
echo "----------------------------"
echo "End man1 copy"
echo "----------------------------"
echo ""
