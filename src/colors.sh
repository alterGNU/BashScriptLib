#!/usr/bin/env bash
 
# ==================================================================================================
# Set Of VAR for coloration
#   - echo -e "${N1}hello ${M5}world!${E}"
#   W=White, N=black, R=Red, V=green, M=brown, B=Blue, BC=Blue, P=Pink, G=Grey
# ==================================================================================================

# =[ BALISE DE FIN ]================================================================================
E="\033[0m"      # END color balise
# =[ BLACK ]========================================================================================
N0="\033[0;30m"  # START BLACK
N1="\033[1;30m"  # START BLACK BOLD GLOSSY
N2="\033[2;30m"  # START BLACK BOLD
N3="\033[3;30m"  # START BLACK BOLD ITALIC
N4="\033[4;30m"  # START BLACK BOLD ITALIC UNDERLINES
N5="\033[5;30m"  # START BLACK BOLD ITALIC UNDERLINES BLINKING/FLASHING
N7="\033[7;30m"  # START BLACK BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ RED ]==========================================================================================
R0="\033[0;31m"  # START RED
R1="\033[1;31m"  # START RED BOLD GLOSSY
R2="\033[2;31m"  # START RED BOLD
R3="\033[3;31m"  # START RED BOLD ITALIC
R4="\033[4;31m"  # START RED BOLD ITALIC UNDERLINES
R5="\033[5;31m"  # START RED BOLD ITALIC UNDERLINES BLINKING/FLASHING
R7="\033[7;31m"  # START RED BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ GREEN ]========================================================================================
V0="\033[0;32m"  # START GREEN
V1="\033[1;32m"  # START GREEN BOLD GLOSSY
V2="\033[2;32m"  # START GREEN BOLD
V3="\033[3;32m"  # START GREEN BOLD ITALIC
V4="\033[4;32m"  # START GREEN BOLD ITALIC UNDERLINES
V5="\033[5;32m"  # START GREEN BOLD ITALIC UNDERLINES BLINKING/FLASHING
V7="\033[7;32m"  # START GREEN BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ BROWN ]========================================================================================
M0="\033[0;33m"  # START BROWN
M1="\033[1;33m"  # START BROWN BOLD GLOSSY
M2="\033[2;33m"  # START BROWN BOLD
M3="\033[3;33m"  # START BROWN BOLD ITALIC
M4="\033[4;33m"  # START BROWN BOLD ITALIC UNDERLINES
M5="\033[5;33m"  # START BROWN BOLD ITALIC UNDERLINES BLINKING/FLASHING
M7="\033[7;33m"  # START BROWN BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ BLUE ]=========================================================================================
B0="\033[0;34m"  # START BLUE
B1="\033[1;34m"  # START BLUE BOLD GLOSSY
B2="\033[2;34m"  # START BLUE BOLD
B3="\033[3;34m"  # START BLUE BOLD ITALIC
B4="\033[4;34m"  # START BLUE BOLD ITALIC UNDERLINES
B5="\033[5;34m"  # START BLUE BOLD ITALIC UNDERLINES BLINKING/FLASHING
B7="\033[7;34m"  # START BLUE BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ AZURE ]========================================================================================
BC0="\033[0;36m"  # START AZURE
BC1="\033[1;36m"  # START AZURE BOLD GLOSSY
BC2="\033[2;36m"  # START AZURE BOLD
BC3="\033[3;36m"  # START AZURE BOLD ITALIC
BC4="\033[4;36m"  # START AZURE BOLD ITALIC UNDERLINES
BC5="\033[5;36m"  # START AZURE BOLD ITALIC UNDERLINES BLINKING/FLASHING
BC7="\033[7;36m"  # START AZURE BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ PINK ]=========================================================================================
P0="\033[0;35m"  # START PINK
P1="\033[1;35m"  # START PINK BOLD GLOSSY
P2="\033[2;35m"  # START PINK BOLD
P3="\033[3;35m"  # START PINK BOLD ITALIC
P4="\033[4;35m"  # START PINK BOLD ITALIC UNDERLINES
P5="\033[5;35m"  # START PINK BOLD ITALIC UNDERLINES BLINKING/FLASHING
P7="\033[7;35m"  # START PINK BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ GREY ]========================================================================================
G0="\033[0;37m"  # START GREY
G1="\033[1;37m"  # START GREY BOLD GLOSSY
G2="\033[2;37m"  # START GREY BOLD
G3="\033[3;37m"  # START GREY BOLD ITALIC
G4="\033[4;37m"  # START GREY BOLD ITALIC UNDERLINES
G5="\033[5;37m"  # START GREY BOLD ITALIC UNDERLINES BLINKING/FLASHING
G7="\033[7;37m"  # START GREY BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
