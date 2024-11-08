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
    [[ ${#} -eq 1 ]] && local int_err=42 || local int_err=${2}
    echo -e "${R4}Function:normi_check() Error:${int_err}${R0}: ${txt_err}${E}\n${V4}Usage${E}:  \`${BC0}normi_check ${M0}<path_to/folder>${E}\`"
    echo -e "${G0}- normi_check : List contents of directories in a tree-like format with coloration:\
        \n  ${B0}- blue means ${G0}\t\t: is a folder.\
        \n  ${V0}- green means ${G0}\t: file passed norminette.\
        \n  ${R0}- red means ${G0}\t\t: file failed norminette.\
        \n  ${E}- white means ${G0}\t: norminette can't be use on this file/folder.\n"
    echo -e "${M4}Exemple${E} : "
    echo -e "${R0}\$>${E}${BC0}${0} ${M0}./normi_check.sh ~/42/ft_printf/${G0}"
    exit ${int_err}
}

# -[ NORMI_COLOR ]----------------------------------------------------------------------------------
# applies color-code depending on norminette return and file extension
normi_color()
{
    local file_name=$(basename "${1}")
    local color_file=${G0}${file_name}${E}
    if [[ ${file_name} == *.[c,h] ]];then
        local res_norm=$(norminette ${1} > /dev/null 2>&1 && echo 0 || echo 1)
        if [[ ${res_norm} -eq 0 ]];then
            local color_file=${V0}${file_name}${E}
        else
            local color_file=${R0}${file_name}${E}
        fi
    fi
    echo -e ${color_file}
}

# -[ NORMI_CHECK_REC() ]----------------------------------------------------------------------------
# basically a tree command with coloration depending on norminette returns
normi_check_rec() 
{
    local prefix="$1"
    local dir="$2"
    local items=("$dir"/*)
    local last_item="${items[-1]}"

    for item in "${items[@]}"; do
        local is_last=false
        [ "$item" == "$last_item" ] && is_last=true
        if [ -d "$item" ]; then
            echo -e "${prefix}└──${BC0}$(basename "$item")${E}"
            if [ "$is_last" = true ]; then
                normi_check_rec "$prefix    " "$item"
            else
                normi_check_rec "$prefix│   " "$item"
            fi
        else
            color_file=$(normi_color ${item})
            if [ "$is_last" = true ]; then
                echo -e "${prefix}└──${color_file}"
            else
                echo -e "${prefix}├──${color_file}"
            fi
        fi
    done
}

# =[ REAL FCT ]=====================================================================================
# -[ NORMI_CHECK() ]--------------------------------------------------------------------------------
# wrap of normi_check_rec, manage cases of folder and file argument and case where norminette is not install.
normi_check() 
{ 
    [[ -x "$(command -v norminette)" ]] || { echo -e "${R4}ERROR 1${E}${B3}: ./norminette${G0} cmd could not be found${E}" && exit 1 ; }
    [[ -z "${1}" ]] && usage_normi_check "${R0}No arg passed to ${V1}normi_check()${R0} function.${E}" 2
    if [[ -d "${1}" ]];then
        echo -e "${BC0}$(basename "${1}")${E}/"
        normi_check_rec "  " "${1}"
    elif [[ -f "${1}" ]];then
        normi_color "${1}"
    else
        usage_normi_check "${R0}Arg ${M4}'${1}'${R0} is not a Folder nor a File${E}" 3
    fi
}
