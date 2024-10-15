#!/bin/bash
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
# Affiche l'usage en incluant la phrase passe en argument.
usage_normi_check()
{
    echo -e "${R4}Error ${R0}: ${1}${E}\n${V4}Usage${E}:  \`${BC0}${0} ${M0}<folder>${E}\`"
    echo -e "${G0}- normi_check : List contents of directories in a tree-like format with coloration:\
        \n  ${B0}- blue means ${G0}\t\t: is a folder.\
        \n  ${V0}- green means ${G0}\t: file passed norminette.\
        \n  ${R0}- red means ${G0}\t\t: file failed norminette.\
        \n  ${E}- white means ${G0}\t: norminette can't be use on this file/folder.\n"
    echo -e "${M4}Exemple${E} : "
    echo -e "${R0}\$>${E}${BC0}${0} ${M0}./normi_check.sh ~/42/ft_printf/${G0}"
    return 0
}

# -[ NORMI_CHECK_REC() ]----------------------------------------------------------------------------
# Recursive fct that take 2args
#   - first one = prefixe (char * that will start each line)
#   - second one = start directory
normi_check_rec() 
{
    local prefix="$1"
    local dir="$2"
    local items=("$dir"/*)
    local last_item="${items[-1]}"

    for item in "${items[@]}"; do
        local is_last=false
        [ "$item" == "$last_item" ] && is_last=true

        # Affiche l'élément
        if [ -d "$item" ]; then
            echo -e "${prefix}└──${BC0}$(basename "$item")${E}"
            if [ "$is_last" = true ]; then
                normi_check_rec "$prefix    " "$item"
            else
                normi_check_rec "$prefix│   " "$item"
            fi
        else
            local file_name=$(basename "${item}")
            local color_file=${G0}${file_name}${E}
            if [[ ${file_name} == *.[c,h] ]];then
                local res_norm=$(norminette ${item} > /dev/null 2>&1 && echo 0 || echo 1)
                if [[ ${res_norm} -eq 0 ]];then
                    local color_file=${V0}${file_name}${E}
                else
                    local color_file=${R0}${file_name}${E}
                fi
            fi
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
# normi_check_rec wraper, take 1arg: path to folder/file to check
normi_check() 
{ 
    if [[ -z "${1}" ]];then
        usage_normi_check "${R0}No arg passed to ${V1}normi_check()${R0} function.${E}" 
        exit 2;
    fi
    if [[ ( ! -d "${1}" ) && ( ! -f "${1}" ) ]];then
        usage_normi_check "${R0}Arg ${M4}'${1}'${R0} is not a Folder nor a File${E}" 
        exit 3;
    fi
    echo -e "${BC0}$(basename "${1}")${E}/"
    normi_check_rec "  " "${1}" ; 
}
