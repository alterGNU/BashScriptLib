#!/usr/bin/env bash

# ============================================================================================================
# FCTS: **check42_funused** , list for each object_files create by project's Makefile the functions used.
# - Takes at least 2 arguments
#   - arg1    : <path/project>   , path to project
#   - arg2..i : <..objectfiles..>, object files (bin, .o, static_lib.a) for which to list the functions used.
# Usage:
#   - check42_funused <path/project> <objectfile> [<other_obj_files>, ...]
# ============================================================================================================

# =[ STATIC/LOCAL FCTS ]======================================================================================
# -[ USAGE ]--------------------------------------------------------------------------------------------------
usage_check42_funused()
{
    local txt_err=${1}
    [[ -z ${2} ]] && local int_err=42 || local int_err=${2}
    echo -e "\033[4;31m[Error:${int_err}] Wrong usage fun:check42_funused()\033[0;31m: ${txt_err}\033[0m\n\033[4;32mUsage\033[0m:  \`\033[0;36mcheck42_funused \033[0;33m<path/project> <objectfile> [...<other_obj_file>..]\033[0m\`"
    echo -e " - \033[0;36mcheck42_funused\033[0m : Check if Makefile exist and make all object_files, takes at least 2 arguments:"
    echo -e "   - \033[0;33m<path/project>\033[0m: The first one is always the path to the project folder"
    echo -e "   - \033[0;33m<objectfiles>\033[0m : Then all args are the object_file's names, create by Makefile, for which to list the functions used"
    echo -e "\033[4;32mExamples\033[0m: "
    echo -e " - \033[0m\033[0;36mcheck42_funused\033[0;33m ../ft_printf/ libftprintf.a\033[0;37m          : list all functions used by the static lib. libftprintf.a"
    echo -e " - \033[0m\033[0;36mcheck42_funused\033[0;33m ../Push_Swap push_swap\033[0;37m               : list all the functions used by the program push_swap"
    echo -e " - \033[0m\033[0;36mcheck42_funused\033[0;33m ../libft/ ft_strdup.o ft_putstr_fd.o\033[0;37m : list all functions used by the object file ft_strdup.o and ft_putstr.o"
    exit ${int_err}
}

# -[ check42_funused() ]-------------------------------------------------------------------------------------
# If the arg1:project has a Makefile that create the arg2..i:<objectfiles> file.
# Then for each objectfile, list all functions used.
check42_funused()
{
    [[ ${#} -lt 2 ]] && usage_check42_funused "Not enought argument, need at least 2 arguments and ${#} was given." "2"
    local project=$(realpath ${1})
    [[ -d ${project} ]] || { usage_check42_funused "Arg1 is not a folder" "3" ; }
    [[ -f ${project}/Makefile ]] || { usage_check42_funused "Project's Makefile not found" "4" ; }
    make -C ${project} > /dev/null
    for obj in ${@:2:$#};do 
        if [[ -f ${project}/${obj} ]];then
            if file "${project}/${obj}" | grep -qE 'relocatable|executable|shared object|ar archive';then
                echo -e "\033[4;33m- Functions Used by ${obj}:\033[m"
                local all_fun=$(nm -g "${project}/${obj}" | grep " U " | sort | uniq | sed -e 's/[ \tU\n]*/-/')
                echo -e "  - \033[4;29mHomemade:\033[m"
                for fun in ${all_fun};do [[ ${fun} == *"ft_"* ]] && echo -e "    ${fun/-/-\ }";done
                echo -e "  - \033[4;29mOther:\033[m"
                for fun in ${all_fun};do [[ ${fun} == *"ft_"* ]] || echo -e "    ${fun/-/-\ }";done
            else
                echo -e "\033[4;31m${project}/${obj} is not an object file\033[m"
            fi

        else
            echo -e "\033[4;31m${project}/${obj} is not a file\033[m"
        fi
    done
    make -C ${project} fclean > /dev/null
} 
