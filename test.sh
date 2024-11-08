#!/usr/bin/env bash

# ==================================================================================================
# Exemple of how to use some of my bash script in anoter script.
# ==================================================================================================
 
# =[ VAR ]==========================================================================================
BSL="/home/altergnu/Projects/BSL"                          # path to BashScriptLib folder

# =[ SRC ]==========================================================================================
for src_file in $(ls ${BSL}/src);do source ${BSL}/src/${src_file};done

# =[ FCTS ]=========================================================================================
# -[ SCRIPT_USAGE ]---------------------------------------------------------------------------------
# Takes 1 to 2 args:
# - arg1:message to display  -> (mandatory)
# - arg2:error int to return -> (optionnal)
script_usage()
{
    [[ ${#} -eq 2 ]] && local int_err=${2} || local int_err=42
    echo -e "${R4}Error ${int_err}${R0}: ${1}${E}\n${V4}Usage${E}:  \`${BC0}${0} ${M0}<path_to_folder>${E}\`"
    echo -e "${M4}Exemple${E} : "
    echo -e "${R0}\$>${E}${BC0}${0} ~/42/ft_printf/${G0}"
    exit ${int_err}
}

# ==================================================================================================
# MAIN
# ==================================================================================================
# =[ CHECKINGS ]====================================================================================
[[ ${#} -ne 1 ]] && script_usage "this script take 1 argument" 2
[[ ( ! -d ${1} ) && ( ! -f ${1} ) ]] && script_usage "the argument '${1}' is not a folder nor a file" 3

# =[ # NORMINETTE CHECKING ]========================================================================
echo norminette:
exec_anim "normi_check ${1}" LA_modern_metro
last_cmd=${?}
echo return ${last_cmd}!!
