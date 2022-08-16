# homebrew-admb
## Unofficial formula for AD Model builder 13.0 from its github repository

### Installation

Tap (add) the repository to your homebrew

`brew tap yukio-takeuchi/homebrew-admb`

Run the following command to install ADMB 13.0

`brew install admb`

### This formula is keg_only

I.e., admb command will not be installed into /usr/local/bin (for Intel Mac).
You need to call the admb command located in /usr/local/opt/admb/bin/

### arm Mac

This formula has not been tested with any arm Mac.

### Linux

On linux, homebrew(linuxbrew) tyies using its own gcc and g++ to install admb.
CC and CXX refer to gcc-12 and g++-12 respectively. In order to resolve this difficulty
This formula manually calls probably equivalent calls to build ADMB until when official Makefile
allow to use gcc-12 and g++-12 (or gcc/g++-XX) as CC and CXX








