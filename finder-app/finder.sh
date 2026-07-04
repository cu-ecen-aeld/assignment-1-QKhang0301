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
        1st argument: the file directory to find the string
        2nd argument: the string that you want to find"
    exit $exit_with_error
fi


filedir=$1
searchstr=$2 
# Check if the direction exists
if ! [[ -d $filedir ]]
then
    _error "The input directory is invalid"
    exit $exit_with_error
fi
# _info "The directory: $(realpath $filedir)"
# _info "The string: $searchstr"


#Number of files in the directory
X=$(find $filedir -type f | wc -l)
#number of lines having matich string
Y=$(grep -r $searchstr $filedir | wc -l)

#print out the result
echo "The number of files are $X and the number of matching lines are $Y"