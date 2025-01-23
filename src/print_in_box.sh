#!/usr/bin/env bash

# ============================================================================================================
# Multiples fonctions to print in boxes, all theses fun have opt. to define the box:
#   -t or --type    : int between 0 and 3 define the box type (default simple line)
#   -c or --colors  : str (cf COLORS dict), def. the box color (default white)
#   -i or --indent  : int (specific to echol fun.), def. the indentation and symbol of the line inside the box
# FCTS: 
# - print_box_title [-t] [-c] <text_to_print_as_title>
# - echol [-i] [-t] [-c] <line_to_print_in_the_box>
# - print_last [-t] [-c]
# - print_in_box [-t] [-c] <text_to_print_as_title>
# - printif line <test> <text> [<sep_symbol>, <success_symbol>, <fail_symbol>] (IF LEN NOT DEFINE:default 80)
#
# Exemples:
#  - print_box_title -c r -t 2 "This is a title"
#  - echol -c r -i 1 -t 2 "line 1"
#  - echol -c r -i 2 -t 2 "line 2"
#  - echol -c r -i 3 -t 2 "line 3"
#  - print_last -c r -t 2
#  ╔═════════════════╗
#  ║ This is a title ╠═══════════════════════════╗
#  ╠═════════════════╝                           ║
#  ║ ✦ line 1                                    ║
#  ║  ➣ line 2                                   ║
#  ║   ⤷ line 3                                  ║
#  ╚═════════════════════════════════════════════╝
#  - print_in_box -t 1 -c y "coucou petite" "perruche"
#  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
#  ┃ coucou petite                               ┃
#  ┃ perruche                                    ┃
#  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
#  - printif "[ 1 -lt 2 ]" "1 < 2"
#  1 < 2                                       ✓
#  - printif "[ 1 -gt 2 ]" "1 > 2" "." "OK" "FAIL"
#  1 > 2....................................FAIL
# ============================================================================================================
 
# =[ VARIABLES ]==============================================================================================
# -[ LAYOUT ]-------------------------------------------------------------------------------------------------
[[ -n ${LEN} ]] && BOX_SIZE=${LEN} || BOX_SIZE=50     # ☑ Width of the line (line size of this script stdout)
E="\033[0m"                                           # END color balise
# -[ COLORS ]-------------------------------------------------------------------------------------------------
# Dict key:colors name/abbrev -> value:color-balise (used by print_in_box to convert option value into color-balise)
declare -A COLORS=( \
    ["w"]="\033[1;29m" ["white"]="\033[1;29m" ["W"]="\033[1;29m" ["WHITE"]="\033[1;29m" \
    ["r"]="\033[1;31m" ["red"]="\033[1;31m" ["R"]="\033[1;31m" ["RED"]="\033[1;31m" \
    ["g"]="\033[1;32m" ["green"]="\033[1;32m" ["G"]="\033[1;32m" ["GREEN"]="\033[1;32m" \
    ["m"]="\033[1;33m" ["marron"]="\033[1;33m" ["M"]="\033[1;33m" ["MARRON"]="\033[1;33m" ["brown"]="\033[1;33m" ["BROWN"]="\033[1;33m"\
    ["b"]="\033[1;36m" ["blue"]="\033[1;36m" ["B"]="\033[1;36m" ["BLUE"]="\033[1;36m" \
    ["y"]="\033[0;93m" ["yellow"]="\033[0;93m" ["Y"]="\033[0;93m" ["YELLOW"]="\033[0;93m" \
    ["bw"]="\033[5;29m" ["blinking-white"]="\033[5;29m" ["BW"]="\033[5;29m" ["BLINKING-WHITE"]="\033[5;29m" \
    ["br"]="\033[5;31m" ["blinking-red"]="\033[5;31m" ["BR"]="\033[5;31m" ["BLINKING-RED"]="\033[5;31m" \
    ["bg"]="\033[5;32m" ["blinking-green"]="\033[5;32m" ["BG"]="\033[5;32m" ["BLINKING-GREEN"]="\033[5;32m" \
    ["bm"]="\033[5;33m" ["blinking-marron"]="\033[5;33m" ["BM"]="\033[5;33m" ["BLINKING-MARRON"]="\033[5;33m" ["blinking-brown"]="\033[5;33m" ["BLINKING-BROWN"]="\033[5;33m"\
    ["bb"]="\033[5;36m" ["blinking-blue"]="\033[5;36m" ["BB"]="\033[5;36m" ["BLINKING-BLUE"]="\033[5;36m" \
    ["by"]="\033[5;93m" ["blinking-yellow"]="\033[5;93m" ["BY"]="\033[5;93m" ["BLINKING-YELLOW"]="\033[5;93m" \
)
# -[ BOX ]----------------------------------------------------------------------------------------------------
#      0   1   2   3                                      # ☒ 0:simple, 1:bold, 2:double, 3:round
ULC=( "┌" "┏" "╔" "╭" )                                   # ☒ Upper Left Corner
DLC=( "└" "┗" "╚" "╰" )                                   # ☒ Down Left Corner
URC=( "┐" "┓" "╗" "╮" )                                   # ☒ Upper Right Corner
DRC=( "┘" "┛" "╝" "╯" )                                   # ☒ Down Right Corner
  H=( "─" "━" "═" "─" )                                   # ☒ Horizontal
  V=( "│" "┃" "║" "│" )                                   # ☒ Vertical
 UT=( "┬" "┳" "╦" "┬" )                                   # ☒ Upper T
 DT=( "├" "┣" "╠" "├" )                                   # ☒ Down T
 MC=( "┼" "╋" "╬" "┼" )                                   # ☒ Middle Cross
 RT=( "┤" "┫" "╣" "┤" )                                   # ☒ Right T
 LT=( "┴" "┻" "╩" "┴" )                                   # ☒ Left T

# =[ FONCTIONS SCRIPTS ]======================================================================================
# -[ GET_LEN ]------------------------------------------------------------------------------------------------
# return real len
get_len() { echo $(echo -en "${1}" | sed 's/\x1b\[[0-9;]*m//g' | wc -m) ; }
# -[ PRINT N TIMES ]------------------------------------------------------------------------------------------
# print $arg1 $arg2 times
pnt() { for i in $(seq 0 $((${2})));do echo -en ${1};done ; }
# -[ PRINT_BOX_TITLE ]----------------------------------------------------------------------------------------
print_box_title()
{
    local color_code="white"
    local box_type="0"
    local text=()
    # HANDLE OPTION
    while [[ ${#} -gt 0 ]];do
        case "${1}" in
            -c|--color)
                local color_code="${2}"
                shift 2
                ;;
            -t|--type)
                local box_type="${2}"
                shift 2
                ;;
            *)
                text+=("${1}")
                shift
                ;;
        esac
    done
    # CHECK IF COLOR VALUE IS IN DICT-COLORS
    local C="${COLORS["w"]}"
    [[ -n "${COLORS[${color_code}]}" ]] && C=${COLORS[${color_code}]} || echo -e "${R}WRONG OPTION:--color='${M}${color_code}${R}' INVALID VALUE ⇒ keep default value:${U}WHITE.\033[0m"
    # CHECK IF TYPE VALUE IN RANGE
    [[ ( ! "${box_type}" =~ ^[0-9]+$ ) || ( ${box_type} -lt 0 ) || ( ${box_type} -gt 3 ) ]] && { echo -e "${R}WRONG OPTION:--type='${M}${box_type}${R}' INVALID VALUE ⇒ keep default value:${U}0 for 'SIMPLE-LINE-BOX'.\033[0m" && local box_type="0" ; }

    local titre="${text}\033[0m"
    local size=$(get_len "${titre}")
    echo -en "${C}${ULC[${box_type}]}" && pnt ${H[${box_type}]} $(( size + 1 )) && echo -en "${URC[${box_type}]}\033[0m\n"
    echo -en "${C}${V[${box_type}]}\033[0m ${titre} ${C}${DT[${box_type}]}" && pnt "${H[${box_type}]}" $((BOX_SIZE - $(get_len "${titre}") - 5 )) && echo -en "${URC[${box_type}]}\033[0m\n"
    echo -en "${C}${DT[${box_type}]}" && pnt ${H[${box_type}]} $(( size + 1 )) && echo -en "${DRC[${box_type}]}\033[0m"
    pnt "\x20" $((BOX_SIZE - $(get_len "${titre}") - 5 )) && echo -en "${C}${V[${box_type}]}\033[0m\n"
}
print_last()
{ 
    local color_code="white"
    local box_type="0"
    local text=()
    # HANDLE OPTION
    while [[ ${#} -gt 0 ]];do
        case "${1}" in
            -c|--color)
                local color_code="${2}"
                shift 2
                ;;
            -t|--type)
                local box_type="${2}"
                shift 2
                ;;
            *)
                text+=("${1}")
                shift
                ;;
        esac
    done
    # CHECK IF COLOR VALUE IS IN DICT-COLORS
    local C="${COLORS["w"]}"
    [[ -n "${COLORS[${color_code}]}" ]] && C=${COLORS[${color_code}]} || echo -e "${R}WRONG OPTION:--color='${M}${color_code}${R}' INVALID VALUE ⇒ keep default value:${U}WHITE.\033[0m"
    # CHECK IF TYPE VALUE IN RANGE
    [[ ( ! "${box_type}" =~ ^[0-9]+$ ) || ( ${box_type} -lt 0 ) || ( ${box_type} -gt 3 ) ]] && { echo -e "${R}WRONG OPTION:--type='${M}${box_type}${R}' INVALID VALUE ⇒ keep default value:${U}0 for 'SIMPLE-LINE-BOX'.\033[0m" && local box_type="0" ; }

    echo -en "${C}${DLC[${box_type}]}" && pnt ${H[${box_type}]} $(( BOX_SIZE - 2 )) && echo -en "${DRC[${box_type}]}\033[0m\n"
}
# -[ ECHO LINE ]----------------------------------------------------------------------------------------------
# echo line inside the box (arg2 optionnal=indentation with custom. list items symb.)
echol()
{
    local color_code="white"
    local box_type="0"
    local indent="0"
    local text=()
    # HANDLE OPTION
    while [[ ${#} -gt 0 ]];do
        case "${1}" in
            -c|--color)
                local color_code="${2}"
                shift 2
                ;;
            -t|--type)
                local box_type="${2}"
                shift 2
                ;;
            -i|--indent)
                local indent="${2}"
                shift 2
                ;;
            *)
                text+=("${1}")
                shift
                ;;
        esac
    done
    # CHECK IF COLOR VALUE IS IN DICT-COLORS
    local C="${COLORS["w"]}"
    [[ -n "${COLORS[${color_code}]}" ]] && C=${COLORS[${color_code}]} || echo -e "${R}WRONG OPTION:--color='${M}${color_code}${R}' INVALID VALUE ⇒ keep default value:${U}WHITE.\033[0m"
    # CHECK IF TYPE VALUE IN RANGE
    [[ ( ! "${box_type}" =~ ^[0-9]+$ ) || ( ${box_type} -lt 0 ) || ( ${box_type} -gt 3 ) ]] && { echo -e "${R}WRONG OPTION:--type='${M}${box_type}${R}' INVALID VALUE ⇒ keep default value:${U}0 for 'SIMPLE-LINE-BOX'.\033[0m" && local box_type="0" ; }

    local sym_list=( "✦" "➣" "⤷" )
    [[ ${indent} -eq 0 ]] && local sym=" " || local sym=${sym_list[$(((${indent} % ${#sym_list[@]})-1))]}
    local spaces=$(printf ' %.s' $(seq 1 ${indent}))
    local line="${C}${V[${box_type}]}\033[0m${spaces}${B}${sym}\033[0m ${text}"
    local size=$(get_len "${line}")
    echo -en "${line}"
    pnt "\x20" $(( BOX_SIZE - size - 1 ))
    if [[ ${BOX_SIZE} -gt $((size - 1)) ]];then
        echo -en "${C}${V[${box_type}]}\033[0m\n"
    else
        echo -en "\n"
    fi
}
# -[ END_MESSAGE ]--------------------------------------------------------------------------------------------
# Print last-arg in a box:
# This function have -c or --color option, default:none, accepte:[r,red,b,blue,y,yellow]
print_in_box()
{
    local color_code="white"
    local box_type="0"
    local text=()
    # HANDLE OPTION
    while [[ ${#} -gt 0 ]];do
        case "${1}" in
            -c|--color)
                local color_code="${2}"
                shift 2
                ;;
            -t|--type)
                local box_type="${2}"
                shift 2
                ;;
            *)
                text+=("${1}")
                shift
                ;;
        esac
    done
    # CHECK IF COLOR VALUE IS IN DICT-COLORS
    local C="${COLORS["w"]}"
    [[ -n "${COLORS[${color_code}]}" ]] && C=${COLORS[${color_code}]} || echo -e "${R}WRONG OPTION:--color='${M}${color_code}${R}' INVALID VALUE ⇒ keep default value:${U}WHITE.\033[0m"
    # CHECK IF TYPE VALUE IN RANGE
    [[ ( ! "${box_type}" =~ ^[0-9]+$ ) || ( ${box_type} -lt 0 ) || ( ${box_type} -gt 3 ) ]] && { echo -e "${R}WRONG OPTION:--type='${M}${box_type}${R}' INVALID VALUE ⇒ keep default value:${U}0 for 'SIMPLE-LINE-BOX'.\033[0m" && local box_type="0" ; }

    # PRINT THE BOX
    echo -en "${C}${ULC[${box_type}]}" && pnt "${H[${box_type}]}" $((BOX_SIZE-2)) && echo -en "${URC[${box_type}]}\n"
    for line in "${text[@]}";do
        local line="${C}${V[${box_type}]}\033[0m ${line}"
        local size=$(get_len "${line}")
        echo -en "${line}" && pnt "\x20" $(( BOX_SIZE - size - 1 ))
        [[ ${BOX_SIZE} -gt $((size - 1)) ]] && echo -en "${C}${V[${box_type}]}\033[0m"
        [[ ${BOX_SIZE} -gt $((size - 1)) ]] && echo -en "${sym}\n" || echo -en "\n"
    done
    echo -en "${C}${DLC[${box_type}]}" && pnt "${H[${box_type}]}" $((BOX_SIZE-2)) && echo -en "${DRC[${box_type}]}\033[0m\n"
}
# -[ PRINTIF() ]----------------------------------------------------------------------------------------------
# print line <test> <text> [<sep_symbol>, <success_symbol>, <fail_symbol>]
# if test succed, print line : text+(n x sep)+success_symbol else print text+(n x sep)+fail_symbol
printif()
{
    [[ -n ${LEN} ]] || local LEN=80
    local TEST="${1}"
    local TEXT="${2}"
    [[ -n ${3} ]] && local SEP="${3}" || local SEP="\x20"
    [[ -n ${4} ]] && local PASS="${4}" || local PASS="\033[0;32m\u2713\033[0m"
    [[ -n ${5} ]] && local FAIL="${5}" || local FAIL="\033[0;31m\u2717\033[0m"
    $(eval ${TEST}) && local SYMB="${PASS}" || local SYMB="${FAIL}"
    echo -en ${TEXT} && pnt "${SEP}" $((LEN - $(get_len "${TEXT}") - $(get_len "${SYMB}") - 6 )) && echo -en "${SYMB}\n"
    [[ "${PASS}" == "${SYMB}" ]] && return 0 || return 1
}
