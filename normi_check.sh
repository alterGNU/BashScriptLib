#!/bin/bash
# ==================================================================================================
# Script lancant la forcant le plantage de mallocs.
# Usage:
#   -> ./test_malloc.sh <path_to_program>
# ==================================================================================================

# =[ VARIABLES ]====================================================================================
# -[ MISE EN PAGE ]---------------------------------------------------------------------------------
VB="\xE2\x94\x82"                                                # Symbole separant test du resultat
HB="\xE2\x94\x80"                                                # Symbole separant test du resultat
VHB="\xE2\x94\x9C"                                               # Symbole separant test du resultat
CR="\xE2\x94\x94"
# RED COLOR
R="\033[0;31m"                                                   # START RED
RI="\033[3;31m"                                                  # START RED-ITALIQUE
RU="\033[4;31m"                                                  # START RED-UNDERLINE
RB="\033[9;31m"                                                  # START RED-BARRE
RC="\033[6;31m"                                                  # START RED-CLIGNOTANT
RS="\033[7;31m"                                                  # START RED-SURLIGNER
# GREEN COLOR
G="\033[0;32m"                                                   # START GREEN
GI="\033[3;32m"                                                  # START GREEN-ITALIQUE
GU="\033[4;32m"                                                  # START GREEN-UNDERLINE
GB="\033[9;32m"                                                  # START GREEN-BARRE
GC="\033[6;32m"                                                  # START GREEN-CLIGNOTANT
GS="\033[7;32m"                                                  # START GREEN-SURLIGNER
# BLUE COLOR
B="\033[0;36m"                                                   # START BLUE
BI="\033[3;36m"                                                  # START BLUE-ITALIQUE
BU="\033[4;36m"                                                  # START BLUE-UNDERLINE
BB="\033[9;36m"                                                  # START BLUE-BARRE
# BROWN COLOR
M="\033[0;33m"                                                   # START MARRON
MI="\033[3;33m"                                                  # START MARRON-ITALIQUE
MU="\033[4;33m"                                                  # START MARRON-UNDERLINE
MB="\033[9;33m"                                                  # START MARRON-BARRE
# GREY COLOR
T="\033[0;37m"                                                   # START MARRON
TI="\033[3;37m"                                                  # START MARRON-ITALIQUE
TU="\033[4;37m"                                                  # START MARRON-UNDERLINE
TB="\033[9;37m"                                                  # START MARRON-BARRE
# END BALISE
E="\033[0m"                                                      # END color balise
# -[ FICHIERS/DOSSIERS ]----------------------------------------------------------------------------
SCRIPTNAME=$0                                                    # Nom du script
WORKFOLDER=${!#}                                                 # Dossier sur lequel travailler

# =[ FONCTIONS SCRIPTS ]============================================================================
# -[ USAGE ]----------------------------------------------------------------------------------------
# Affiche l'usage en incluant la phrase passe en argument.
usage()
{
    echo -e "${RU}Mauvais usage${R}: ${1}${E}\n${GU}Usage${E}:  \`${B}${SCRIPTNAME} ${M}<dossier>${E}\`"
    echo -e "${T}- Affiche l'arborescence du dossier passe en argument, et color ses fichiers
    d'extension .c et .h en vert et rouge s'ils passent ou ne passent pas la norminette."
    echo -e "${MU}Exemple${E} : "
    echo -e "${R}\$>${E}${B}${0} ${M}./normi_check.sh ~/42/ft_printf/${T}"
    return 0
}

# ==================================================================================================
# MAIN
# ==================================================================================================
# =[ CHECKS ARGS ]==================================================================================
# -[ CAS PAS DE DOSSIER PASSE EN ARGUMENT ]---------------------------------------------------------
[[ "${#}" -eq 0 ]] && { usage "Manque argument au script" && exit 2; }
# =[ DO-IT ]========================================================================================
normi_check() {
    local prefix="$1"
    local dir="$2"
    local items=("$dir"/*)
    local last_item="${items[-1]}"

    for item in "${items[@]}"; do
        local is_last=false
        [ "$item" == "$last_item" ] && is_last=true

        # Affiche l'élément
        if [ -d "$item" ]; then
            echo -e "${prefix}└──${B}$(basename "$item")${E}"
            if [ "$is_last" = true ]; then
                normi_check "$prefix    " "$item"
            else
                normi_check "$prefix│   " "$item"
            fi
        else
            local file_name=$(basename "${item}")
            local color_file=${T}${file_name}${E}
            if [[ ${file_name} == *.[c,h] ]];then
                local res_norm=$(norminette ${item} > /dev/null 2>&1 && echo 0 || echo 1)
                if [[ ${res_norm} -eq 0 ]];then
                    local color_file=${G}${file_name}${E}
                else
                    local color_file=${R}${file_name}${E}
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

# Point d'entrée du script
echo -e "${B}$(basename "${WORKFOLDER}")${E}/"
normi_check "" "${WORKFOLDER}"
