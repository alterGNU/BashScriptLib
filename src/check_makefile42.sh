#!/usr/bin/env bash

# ============================================================================================================
# FCTS: **check_makefile42** , takes exactly 2 arguments
#   - arg1 : <path/project> (path to project)
#   - arg2 : <projectName> (project's name, a.k.a var./rule $(NAME) value in Makefile)
# Usage:
#   - check_makefile42 <path/project> <projectName>
# Dependances:
#   - Need `source print_in_box.sh` to work (printif use)
# ============================================================================================================

# =[ STATIC/LOCAL FCTS ]======================================================================================
# -[ USAGE ]--------------------------------------------------------------------------------------------------
# print usage
usage_check_makefile42()
{
    local txt_err=${1}
    [[ -z ${2} ]] && local int_err=42 || local int_err=${2}
    echo -e "\033[4;31mFunction:check_makefile42() Error:${int_err}\033[0;31m: ${txt_err}\033[0m\n\033[4;32mUsage\033[0m:  \`\033[0;36mcheck_makefile42 \033[0;33m<path/project> <projectName>\033[0m\`"
    echo -e "  - \033[0;36mcheck_makefile42\033[0m  : Check if Makefile exist and is conform to 42 rules, takes exactly 2 arguments:"
    echo -e "    - \033[0;33m<path/project>\033[0m  : Path to the project folder"
    echo -e "    - \033[0;33m<projectName>\033[0m   : Project's Name (used as \$(NAME) variable in Makefile)"
    echo -e "\033[4;33mExemple\033[0m : "
    echo -e "\033[0;31m\$>\033[0m\033[0;36m${0}\033[0;33m /../../ft_printf/ libftprintf.a\033[0;37m"
    echo -e "\033[0;31m\$>\033[0m\033[0;36m${0}\033[0;33m ../Push_Swap push_swap\033[0;37m"
    exit ${int_err}
}

# -[ CHECK_MAKEFILE42() ]-------------------------------------------------------------------------------------
# Check that the makefile contain at least the rules  `push_swap`, `all`, `clean`, `fclean` and `re` without relink
check_makefile42()
{
    [[ ${#} -eq 2 ]] || { usage_check_makefile42 "Wrong number of argument, 2 needed but ${#} was given." "3" ; }
    local folder=$(realpath ${1})
    local pname=${2}
    [[ -d ${folder} ]] || { usage_check_makefile42 "Arg1 is not a folder" "4" ; }

    final=0
    # Check if Makefile is present
    printif "[ -f ${folder}/Makefile ]" "${BC0}Makefile${E} in '${M0}${folder}${E}'"
    final=$(( final + ${?} ))

    # Check compile command use
    local tmp="0"
    grep -Eq "[^g]cc" ${folder}/Makefile || tmp+="1"
    grep -Eq "\-Wall" ${folder}/Makefile || tmp+="2"
    grep -Eq "\-Wextra" ${folder}/Makefile || tmp+="3"
    grep -Eq "\-Werror" ${folder}/Makefile || tmp+="4"
    if [[ ${tmp} != "0" ]];then
        [[ "${tmp}" == *"1"* ]] && printif "[ 0 -eq 1 ]" "Error: Makefile use gcc instead of cc"
        [[ "${tmp}" == *"2"* ]] && printif "[ 0 -eq 1 ]" "Error: No flag -Wall"
        [[ "${tmp}" == *"3"* ]] && printif "[ 0 -eq 1 ]" "Error: No flag -Wextra"
        [[ "${tmp}" == *"4"* ]] && printif "[ 0 -eq 1 ]" "Error: No flag -Werror"
    else
        printif "[ 0 ]" "Compile with \`cc -Wall -Wextra -Werror\`"
    fi
    
    # test make ${2}
    printif "make -C ${folder} ${2} > /dev/null && [ -f ${folder}/${2} ]" "\`make ${2}\` exist and create the ${M0}${folder}${E}/${V0}${2}${E}/ bin"
    final=$(( final + ${?} ))
    
    # test make all and no relink
    printif "make -C ${folder} all | grep -q \"Nothing to be done for 'all'.\"" "\`make all\` cmd exist a do not relink"
    final=$(( final + ${?} ))
    
    # test make clean
    res=0
    make -C ${folder} clean > /dev/null 2>&1 || { res=1 && printif "[ 1 -eq 2 ]" "\`make clean\` cmd does not exist" ; }
    [[ -f ${folder}/${2} ]] || { res=1 && printif "[ 1 -eq 2 ]" "\`make clean\` cmd exist but erase ${2} bin" ; }
    [[ $(find ${folder} -name "*.o" | wc -l) -eq 0 ]] || { res=1 && printif "[ 1 -eq 2 ]" "\`make clean\` cmd exist but do not erase object.o files" ; }
    [[ ${res} -eq 0 ]] && printif "[[ ${res} -eq 0 ]]" "\`make clean\` cmd exist and work"
    final=$(( final + ${res} ))
    
    # test make fclean
    res=0
    make -C ${folder} > /dev/null 2>&1
    make -C ${folder} fclean > /dev/null 2>&1 || { res=1 && printif "[ 1 -eq 2 ]" "\`make fclean\` cmd does not exist" ; }
    [[ $(find ${folder} -name "*.o" | wc -l) -eq 0 ]] || { res=1 && printif "[ 1 -eq 2 ]" "\`make fclean\` cmd exist but do not erase object.o files" ; }
    [[ -f ${folder}/${2} ]] && { res=1 && printif "[ 1 -eq 2 ]" "\`make fclean\` cmd exist but do not erase ${2} bin" ; }
    [[ ${res} -eq 0 ]] && printif "[[ ${res} -eq 0 ]]" "\`make fclean\` cmd exist and work"
    final=$(( final + ${res} ))
    
    # test make re
    res=0
    make -C ${folder} re > /dev/null 2>&1 || { res=1 && printif "[ 1 -eq 2 ]" "\`make re\` cmd does not exist" ; }
    [[ -f ${folder}/${2} ]] || { res=1 && printif "[ 1 -eq 2 ]" "\`make re\` cmd exist but do not create ${2} bin" ; }
    [[ $(find ${folder} -name "*.o" | wc -l) -eq 0 ]] && { res=1 && printif "[ 1 -eq 2 ]" "\`make re\` cmd exist but do not create object.o files" ; }
    [[ ${res} -eq 0 ]] && printif "[[ ${res} -eq 0 ]]" "\`make re\` cmd exist and work"
    final=$(( final + ${res} ))

    # clean folder
    make -C ${folder} fclean > /dev/null 2>&1

    return ${final}
} 
