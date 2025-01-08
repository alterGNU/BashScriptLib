#!/usr/bin/env bash

# ==================================================================================================
# FCTS: **normi_check** , take arg1 : <path/folder>
# List contents of directories in a tree-like format with coloration:
#   - blue means    : it's a folder.
#   - green means   : file passed norminette.
#   - red means     : file failed norminette.
#   - white means   : norminette can't be use on this file/folder.
# Usage:
#   -> normi_check <path/folder>
# ==================================================================================================

# =[ STATIC/LOCAL FCTS ]============================================================================
# -[ USAGE ]----------------------------------------------------------------------------------------
# print usage
usage_normi_check()
{
    local txt_err=${1}
    [[ -z ${2} ]] && local int_err=42 || local int_err=${2}
    echo -e "\033[4;31mFunction:normi_check() Error:${int_err}\033[0;31m: ${txt_err}\033[0m\n\033[4;32mUsage\033[0m:  \`\033[0;36mnormi_check \033[0;33m<path_to/folder>\033[0m\`"
    echo -e "\033[0;37m- normi_check : List contents of directories in a tree-like format with coloration:\
        \n  \033[0;34m- blue means \033[0;37m\t\t: is a folder.\
        \n  \033[0;32m- green means \033[0;37m\t: file passed norminette.\
        \n  \033[0;31m- red means \033[0;37m\t\t: file failed norminette.\
        \n  \033[0m- white means \033[0;37m\t: norminette can't be use on this file/folder.\n"
    echo -e "\033[4;33mExemple\033[0m : "
    echo -e "\033[0;31m\$>\033[0m\033[0;36m${0} \033[0;33m./normi_check.sh ~/42/ft_printf/\033[0;37m"
    exit ${int_err}
}

# -[ NORMI_COLOR ]----------------------------------------------------------------------------------
# applies color-code depending on norminette return and file extension
normi_color()
{
    local file_name=$(basename "${1}")
    local color_file="\033[0;37m${file_name}\033[0m"
    if [[ ${file_name} == *.[c,h] ]];then
        local res_norm=$(norminette ${1} > /dev/null 2>&1 && echo 0 || echo 1)
        if [[ ${res_norm} -eq 0 ]];then
            local color_file="\033[0;32m${file_name}\033[0m"
        else
            local color_file="\033[0;31m${file_name}\033[0m"
        fi
    fi
    echo -e ${color_file}
    return ${res_norm}
}

# -[ NORMI_CHECK_REC() ]----------------------------------------------------------------------------
# basically a tree command with coloration depending on norminette returns
normi_check_rec() 
{
    local prefix="${1}"
    local dir="${2}"
    local items=("${dir}"/*)
    local last_item="${items[-1]}"
    exit_value=0

    for item in "${items[@]}"; do
        local is_last=false
        [ "${item}" == "${last_item}" ] && is_last=true
        if [ -d "${item}" ]; then
            echo -e "${prefix}└──\033[0;36m$(basename "${item}")\033[0m"
            if [ "${is_last}" = true ]; then
                normi_check_rec "${prefix}    " "${item}"
            else
                normi_check_rec "${prefix}│   " "${item}"
            fi
        else
            color_file=$(normi_color ${item})
            exit_value=$(( exit_value + ${?} ))
            if [ "${is_last}" = true ]; then
                echo -e "${prefix}└──${color_file}"
            else
                echo -e "${prefix}├──${color_file}"
            fi
        fi
    done
    return ${exit_value}
}

# =[ REAL FCT ]=====================================================================================
# -[ NORMI_CHECK() ]--------------------------------------------------------------------------------
# wrap of normi_check_rec, manage cases of folder and file argument and case where norminette is not install.
normi_check() 
{ 
    [[ -x "$(command -v norminette)" ]] || { echo -e "\033[4;31mERROR 1\033[0m\033[3;34m: ./norminette\033[0;37m cmd could not be found\033[0m" && exit 1 ; }
    [[ -z "${1}" ]] && usage_normi_check "\033[0;31mNo arg passed to \033[1;32mnormi_check()\033[0;31m function.\033[0m" 2
    exit_value=0
    if [[ -d "${1}" ]];then
        echo -e "\033[0;36m$(basename "${1}")\033[0m/"
        normi_check_rec "  " "${1}"
    elif [[ -f "${1}" ]];then
        normi_color "${1}"
    else
        usage_normi_check "\033[0;31mArg \033[4;33m'${1}'\033[0;31m is not a Folder nor a File\033[0m" 3
    fi
    return ${?}
}
