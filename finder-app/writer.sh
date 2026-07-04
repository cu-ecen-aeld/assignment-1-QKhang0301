#!/usr/bin/bash
#Just for decoration
C_RED="\e[0;31;1m"
C_GREEN="\e[0;32;1m"
C_CYAN="\e[0;36;1m"
C_RESET="\e[0m"
#Define some variables
num_arg=$#
expected_num_arg=2
exit_with_error=1
exit_with_success=0
#Function to show error
_error() {
  local message="${1:-}"

  printf "%bERROR: %s%b\n" "${C_RED}" "${message}" "${C_RESET}" >&2
}
#Function to show information
_info() {
  local message="${1:-}"

  printf "%b%s:%b\n" "${C_CYAN}" "${message}" "${C_RESET}"
}
# Check if the number of arguments is valid
if [ $num_arg -lt $expected_num_arg ]
then
    _error "In valid number of input arguments.
        This script expectes 2 arguments
        1st argument: the path of the file which will be written
        2nd argument: the string that you want to write into the file"
    exit $exit_with_error
fi

writefile=$1 #the file path
writestr=$2 #the string

#check if the file exists, if not, then create it
if ! [[ -f $writefile ]]
then
    # _info "Creating the file: $writefile"
    touch $writefile
    error_code=$?
    if [ $error_code -ne 0 ]
    then
        _error "Cannot create the file
        Exit code: $error_code"
        exit $exit_with_error
    fi

    # _info "File created"
fi

# Write content to the file
echo $writestr > $writefile
# Check if write successfully
if [ $? -ne 0 ]
then
    _error "Cannot writing to file"
    exit $exit_with_error

fi