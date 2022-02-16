#!/usr/bin/env bash
# https://github.com/MSFPT/Matrix

chRoot(){ if [[ $USER != 'root' ]];then printf "\e[0;m\n  \e[1m[\e[5m\a*\e[0;m\e[1m] Please run this file with higher access\n\n -> ( permission denied )\n\e[0;m\n";exit; fi }
TryExcept(){ if [[ $? != 0 ]];then $1 ; fi }
ERR(){ printf "\r\n$OT Error & Try again\n\n\e[0;m";exit; }

chCmatrix(){ # Check cmatrix is ​​installed
  cmatrix -h > /dev/null 2>&1
  TryExcept $1 # else run $[1]
}

install(){
  if [[ $(uname -o) == 'Android' ]];then # check Termux
    pkg install cmatrix -y > /dev/null 2>&1 # install cmatrix on Termux
  else
    chRoot # check Root
    apt install cmatrix -y > /dev/null 2>&1 # install cmatrix on GNU/Linux
  fi
}

# printf "\nalias matrix=cmatrix" >> ~/.bashrc
chCmatrix install # if it is not installed, install it
TryExcept ERR # else error and quit
cmatrix; # run matrix