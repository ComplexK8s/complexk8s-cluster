#!/bin/bash
#
# handle-secret.sh - Utility for Encryption/Decryption of secret files
#
# Author: Rodrigo Alvares de Souza <rsouza01@gmail.com>
#
# History:
# Version 0.1: 2021/01/28 (rsouza) - First version

#FUNCTIONS DEFINITIONS

print2stringslncolor () {
        echo -e "\e[0m$1\e[1;34m$2\e[0m\n"
}


print2stringslncolorERROR () {
        echo -e "\e[0m$1\e[1;91m$2\e[0m\n"
}

printlncolor () {
        echo -e "\e[1;34m$1\e[0m\n"
}

printlncolorERROR () {
        echo -e "\e[1;91m$1\e[0m\n"
}
#END FUNCTIONS DEFINITIONS

#MAIN PROGRAM
_SECRET_FILE=""
_OPERATION=""
_KEY=""

_VERSION=$(grep '^# Version ' "$0" | tail -1 | cut -d : -f 1 | tr -d \#)

USE_MESSAGE="
$(basename "$0") - Encryption/Decryption of secret files (${_VERSION})
=============================================================================


This utility encrypts/decrypts a secret file using gpg. 
It allows the developer to commit secrets to Github without compromising credentials. 

Usage: $(basename "$0") [OPTIONS]

OPTIONS:    
  -f, --file        Sets the file to encrypt/decrypt
  -e, --encrypt     Sets the operation to encrypt
  -d, --decrypt     Sets the operation to decrypt
  -k, --key         Sets the encryption/decryption key

  -h, --help        Show this help screen and exits
  -V, --version     Show program version and exits
"


# Key from env 
if [[ "$_KEY" = "" ]]
then    
    _KEY=$ENCRYPTION_KEY
fi

#Command line arguments
while test -n "$1"
do
        case "$1" in
		-f | --file) 
                        shift
                        _SECRET_FILE=$1 
                ;;

		-k | --key) 
                        shift
                        _KEY=$1
                ;;

		-e | --encrypt) 
                if [[ "$_OPERATION" = "decrypt" ]]; then
                    printlncolorERROR "You can not choose two operations. Exiting..."
                    exit -1
                fi
                _OPERATION='encrypt' 
                ;;

		-d | --decrypt)
                if [[ "$_OPERATION" = "encrypt" ]]; then
                    printlncolorERROR "You can not choose two operations. Exiting..."
                    exit -1
                fi
                _OPERATION='decrypt' 
                ;;

		-h | --help)
			echo "$USE_MESSAGE"
			exit 0
		;;

		-V | --version)
			echo -n $(basename "$0")
            echo " ${_VERSION}"
			exit 0
		;;

		*)
			echo Invalid option: $1
			exit 1
		;;
	esac

	shift
done

# Debug info
# printlncolor "_OPERATION => '$_OPERATION'"
# printlncolor "_KEY => '$_KEY'"
# printlncolor "_SECRET_FILE => '$_SECRET_FILE'"

# Sanity checks
if [[ "$_KEY" = "" ]]
then    
    printlncolorERROR "No key set. Exiting..."
    exit -1
fi

if [[ "$_SECRET_FILE" = "" ]]
then    
    printlncolorERROR "No file provided. Exiting..."
    exit -1
fi


if [ "$_OPERATION" = "encrypt" ]; then
    printlncolor "Encrypting..."
    gpg --symmetric --batch --passphrase "$_KEY" --cipher-algo AES256 ${_SECRET_FILE}
    exit 0
elif [ "$_OPERATION" = "decrypt" ]; then
    printlncolor "Decrypting..."
    gpg --quiet --batch --yes --decrypt --passphrase="$_KEY" --output ${_SECRET_FILE}.decrypted ${_SECRET_FILE}
    exit 0
else
    echo "$USE_MESSAGE"
    printlncolorERROR "No operation set. Exiting..."
    exit -1
fi