#!/usr/bin/env bash

# ============================================================================================================
# FCTS: **exec_anim** take arg1 : <command_to_exec>
# Show animation in frontground while a command is exec in background.
# 1 - EXEC:
#   - 1.1 : create a temporary file to store cmd returns.
#   - 1.2 : exec a command in background and redirect the outputs to the temporary file.
#   - 1.3 : get the command PID
# 2 - RETURNS : (when background cmd is done (PID was ~killed)):
#   - 2.1 : get cmd final value (value returned by cmd in terminal)
#   - 2.2 : print cmd returns by reading temporary file
#   - 2.3 : rm temporary file
#   - 2.4 : return final return value 
# ============================================================================================================
 
 
# ============================================================================================================
# SHORT VERSION
## -[ EXEC_ANIM() ]--------------------------------------------------------------------------------------------
## print animation in frontground while cmd exec in background the print returns.
#exec_anim()
#{
#    local frames=( ▹▹▹▹▹ ▸▹▹▹▹ ▹▸▹▹▹ ▹▹▸▹▹ ▹▹▹▸▹ ▹▹▹▹▸ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ )
#    local delay=0.15
#    local cmd="${@}"
#    local tmpfile=$(mktemp "${TMPDIR:-/tmp}/exec_anim_${cmd%% *}_XXXXXX")
#    trap '[[ -f "${tmpfile}" ]] && rm -f "${tmpfile}"' EXIT RETURN
#    ${cmd} > "${tmpfile}" 2>&1 &
#    local pid=${!}
#    while kill -0 ${pid} 2>/dev/null; do
#        for frame in "${frames[@]}"; do printf "\r${frame}" && sleep ${delay} ; done
#    done
#    printf "\r" && wait ${pid}
#    local exit_code=${?}
#    printf "\r" && cat "${tmpfile}"
#    return ${exit_code}
#}
# ============================================================================================================
 
# =[ VARIABLES ]==============================================================================================
# -[ ASCII ]--------------------------------------------------------------------------------------------------
LA_classic=( 0.25 '-' "\\" '|' '/' )
LA_box=( 0.2 ┤ ┴ ├ ┬ )
LA_bubble=( 0.6 · o O O o · )
LA_breathe=( 0.9 '  ()  ' ' (  ) ' '(    )' ' (  ) ' )
LA_growing_dots=( 0.5 '.  ' '.. ' '...' '.. ' '.  ' '   ' )
LA_passing_dots=( 0.25 '.  ' '.. ' '...' ' ..' '  .' '   ' )
LA_metro=( 0.2 '[    ]' '[=   ]' '[==  ]' '[=== ]' '[ ===]' '[  ==]' '[   =]' )
LA_snake=( 1.4 '[=     ]' '[~<    ]' '[~~=   ]' '[~~~<  ]' '[ ~~~= ]' '[  ~~~<]' '[   ~~~]' '[    ~~]' '[     ~]' '[      ]' )
LA_filling_bar=( 0.25 '█▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '███▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '█████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '██████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '███████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '█████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '██████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '███████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '█████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '██████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '███████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '█████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '██████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒' '███████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒' '████████████████████▒▒▒▒▒▒▒▒▒▒▒▒' '█████████████████████▒▒▒▒▒▒▒▒▒▒▒' '██████████████████████▒▒▒▒▒▒▒▒▒▒' '███████████████████████▒▒▒▒▒▒▒▒▒' '████████████████████████▒▒▒▒▒▒▒▒' '█████████████████████████▒▒▒▒▒▒▒' '██████████████████████████▒▒▒▒▒▒' '███████████████████████████▒▒▒▒▒' '████████████████████████████▒▒▒▒' '█████████████████████████████▒▒▒' '██████████████████████████████▒▒' '███████████████████████████████▒' '████████████████████████████████')
LA_cym=( 0.5 '⊏' '⊓' '⊐' '⊔')
LA_line=( 0.5 '☰' '☱' '☳' '☷' '☶' '☴')
LA_arr=( 0.15 '↑' '↗' '→' '↘' '↓' '↙' '←' '↖')
LA_tete=( 0.9 "(-_-)" "(o_o)" "(O_O)" "(o_o)" "(-_-)")
# -[ UTF8 ]---------------------------------------------------------------------------------------------------
LA_classic_utf8=( 0.25 '—' "\\" '|' '/' )
LA_bounce=( 0.3 . · ˙ · )
LA_vertical_block=( 0.25 ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ █ ▇ ▆ ▅ ▄ ▃ ▂ ▁ )
LA_horizontal_block=( 0.25 ▏ ▎ ▍ ▌ ▋ ▊ ▉ ▉ ▊ ▋ ▌ ▍ ▎ ▏ )
LA_quarter=( 0.25 ▖ ▘ ▝ ▗ )
LA_triangle=( 0.45 ◢ ◣ ◤ ◥)
LA_semi_circle=( 0.1 ◐ ◓ ◑ ◒ )
LA_rotating_eyes=( 0.1 ◡◡ ⊙⊙ ⊙⊙ ◠◠ )
LA_firework=( 0.4 '⢀' '⠠' '⠐' '⠈' '*' '*' ' ' )
LA_braille=( 0.2 ⠁ ⠂ ⠄ ⡀ ⢀ ⠠ ⠐ ⠈ )
LA_braille_whitespace=( 0.2 ⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷ )
LA_dot1=( 0.2 '⣾' '⣽' '⣻' '⢿' '⡿' '⣟' '⣯' '⣷' )
LA_dot2=( 0.2 '⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏' )
LA_dot3=( 0.2 '⠋' '⠙' '⠚' '⠞' '⠖' '⠦' '⠴' '⠲' '⠳' '⠓' )
LA_dot9=( 0.2  '⢹' '⢺' '⢼' '⣸' '⣇' '⡧' '⡗' '⡏' )
LA_trigram=( 0.25 ☰ ☱ ☳ ☶ ☴ )
LA_arrow=( 0.15 ▹▹▹▹▹ ▸▹▹▹▹ ▹▸▹▹▹ ▹▹▸▹▹ ▹▹▹▸▹ ▹▹▹▹▸ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ ▹▹▹▹▹ )
LA_bouncing_ball=( 0.4 '(●     )' '( ●    )' '(  ●   )' '(   ●  )' '(    ● )' '(     ●)' '(    ● )' '(   ●  )' '(  ●   )' '( ●    )' )
LA_big_dot=( 0.7 ∙∙∙ ●∙∙ ∙●∙ ∙∙● )
LA_modern_metro=( 0.15 ▰▱▱▱▱▱▱ ▰▰▱▱▱▱▱ ▰▰▰▱▱▱▱ ▱▰▰▰▱▱▱ ▱▱▰▰▰▱▱ ▱▱▱▰▰▰▱ ▱▱▱▱▰▰▰ ▱▱▱▱▱▰▰ ▱▱▱▱▱▱▰ ▱▱▱▱▱▱▱ ▱▱▱▱▱▱▱ ▱▱▱▱▱▱▱ ▱▱▱▱▱▱▱ )
LA_pong=( 0.1 '▐⠂       ▌' '▐⠈       ▌' '▐ ⠂      ▌' '▐ ⠠      ▌' '▐  ⡀     ▌' '▐  ⠠     ▌' '▐   ⠂    ▌' '▐   ⠈    ▌' '▐    ⠂   ▌' '▐    ⠠   ▌' '▐     ⡀  ▌' '▐     ⠠  ▌' '▐      ⠂ ▌' '▐      ⠈ ▌' '▐       ⠂▌' '▐       ⠠▌' '▐       ⡀▌' '▐      ⠠ ▌' '▐      ⠂ ▌' '▐     ⠈  ▌' '▐     ⠂  ▌' '▐    ⠠   ▌' '▐    ⡀   ▌' '▐   ⠠    ▌' '▐   ⠂    ▌' '▐  ⠈     ▌' '▐  ⠂     ▌' '▐ ⠠      ▌' '▐ ⡀      ▌' '▐⠠       ▌' )
LA_earth=( 0.3 🌍 🌎 🌏 )
LA_clock=( 0.2 🕛 🕐 🕑 🕒 🕓 🕔 🕕 🕖 🕗 🕘 🕙 🕚 )
LA_moon=( 0.8 🌑 🌒 🌓 🌔 🌕 🌖 🌗 🌘 )
LA_orange_pulse=( 0.35 🔸 🔶 🟠 🟠 🔶 )
LA_blue_pulse=( 0.35 🔹 🔷 🔵 🔵 🔷 )
LA_football=( 0.25 ' 👧⚽️       👦' '👧  ⚽️      👦' '👧   ⚽️     👦' '👧    ⚽️    👦' '👧     ⚽️   👦' '👧      ⚽️  👦' '👧       ⚽️👦 ' '👧      ⚽️  👦' '👧     ⚽️   👦' '👧    ⚽️    👦' '👧   ⚽️     👦' '👧  ⚽️      👦' )
LA_blink=( 0.25 😐 😐 😐 😐 😐 😐 😐 😐 😐 😑 )
LA_camera=( 0.1 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📷 📸 📷 📸 )
LA_sparkling_camera=( 0.1 '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📷 ' '📸✨' '📷 ' '📸✨' )
LA_sick=( 0.9 🤢 🤢 🤮 )
LA_monkey=( 0.4 🙉 🙈 🙊 🙈 )
LA_bomb=( 0.25 '💣   ' ' 💣  ' '  💣 ' '   💣' '   💣' '   💣' '   💣' '   💣' '   💥' '    ' '    ' )

# =[ FONCTIONS SCRIPTS ]======================================================================================
# -[ USAGE ]--------------------------------------------------------------------------------------------------
usage_exec_anim()
{
    [[ ${#} -eq 2 ]] && local int_err=${2} || local int_err=42
    echo -e "${R4}Function Error: exec_anim(), err_${int_err}${R0}: ${1}${E}\n${V4}Usage${E}:  \`${BC0}exec_anim ${M0}<command> <anim_var>${E}\`"
    echo -e "${G0}- exec_anim : run a fct in background while displaying an animation:\n"
    echo -e "${M4}Exemple${E} : "
    echo -e "${R0}\$>${E}${BC0}fct exec_anim ${M0}\"sleep 3\"${G0} :\n  run sleep in background while displaying the default animation in frontground"
    echo -e "${R0}\$>${E}${BC0}fct exec_anim ${M0}\"sleep 3\" LA_clock${G0} :\n  run sleep in background while displaying the animation named LA_arrow in frontground"
    echo -e "${R0}\$>${E}${BC0}fct exec_anim ${M0}\"sleep 3\" coucou${G0} :\n  return error since 'coucou' is not an animation name"
    exit ${int_err}
}

# -[ LOADING_ANIMATION ]--------------------------------------------------------------------------------------
# print animation in frontground takes 2 arguments: cmd PID and animation_list
loading_animation()
{
    local pid=${1}
    local delay=${2}
    shift 2
    local frames=("${@}")

    while kill -0 ${pid} 2>/dev/null; do  # while process is running...
        for frame in "${frames[@]}"; do
            printf "\r${frame}"
            sleep ${delay}
        done
    done
    printf "\r"  # clean animation
}

# -[ EXEC_ANIM ]----------------------------------------------------------------------------------------------
# main function, print animation in frontground while cmd exec in background the print returns.
exec_anim()
{
    [[ ${#} -lt 1 ]] && usage_exec_anim "Too few arguments" 2
    [[ ${#} -gt 2 ]] && usage_exec_anim "Too many arguments" 3
    local cmd=${1}
    local tmpfile=$(mktemp "${TMPDIR:-/tmp}/exec_anim_${cmd%% *}_XXXXXX")
    trap '[[ -f "${tmpfile}" ]] && rm -f "${tmpfile}"' EXIT RETURN # makes sure that tmp file is always remove
    if [[ ${#} -eq 1 ]]; then
        local anim_list=${LA_arr[@]}
    else
        if declare -p "${2}" 2>/dev/null | grep -q 'declare \-a'; then
            eval "local anim_list=\${${2}[@]}"
        else
            usage_exec_anim "${2} is not an animation name!" 5
        fi
    fi
    ${cmd} >"${tmpfile}" 2>&1 &
    local pid=$!
    loading_animation ${pid} ${anim_list[@]}
    wait ${pid}
    local exit_code=${?}
    printf "\r"
    cat "${tmpfile}"
    return ${exit_code}
}
