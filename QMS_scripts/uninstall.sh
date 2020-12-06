#!/bin/bash

cd /usr/share/man/man1
while IFS= read -r man_page1; do
  echo "Deleting manpage: $man_page1"
  sudo rm $man_page1
done < man_page_list_1

cd /usr/share/man/man7
while IFS= read -r man_page7; do
  echo "Deleting manpage: $man_page7"
  sudo rm $man_page7
done < man_page_list_7

cd /usr/bin
sudo rm QMS

cd ~
sudo rm -r HardwareAssembler
