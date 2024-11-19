#!/usr/bin/env bash
 
# ============================================================================================================
# Set Of VAR for coloration
#   - echo -e "${N1}hello ${M5}world!${E}"
#   W=White, N=black, R=Red, V=green, M=brown, B=Blue, BC=Blue, P=Pink, G=Grey
#
# Usage: copy and past your color selection at the top of your script (cause 150 VAR is not a goog idea)
# ============================================================================================================

 
# ============================================================================================================
# PATTERN
# \033[x;ym
# - x : select color                                |   - y : select color (ADD +10 for background)
#   - 0 : normal mode                               |       - 30 black  + 60 = 90 intense black
#   - 1 : bold glossy                               |       - 31 red    + 60 = 91 intense red     
#   - 2 : bold                                      |       - 32 green  + 60 = 92 intense green  
#   - 3 : bold italic                               |       - 33 brown  + 60 = 93 YELLOW          
#   - 4 : bold italic underlines                    |       - 34 bleu   + 60 = 94 intense bleu   
#   - 5 : bold italic underlines blinking           |       - 35 pink   + 60 = 95 intense pink   
#   -                                               |       - 36 cyan   + 60 = 96 intense cyan   
#   - 7 : bold italic underlines blinking highlight |       - 37 white  + 60 = 97 intense white  
# ============================================================================================================
 
# ============================================================================================================
# BASICS SELECTION
E="\033[0m"       # END color balise
N0="\033[0;30m"   # START BLACK
R0="\033[0;31m"   # START RED
V0="\033[0;32m"   # START GREEN
M0="\033[0;33m"   # START BROWN
Y0="\033[0;93m"   # START YELLOW
B0="\033[0;34m"   # START BLUE
BC0="\033[0;36m"  # START AZURE
P0="\033[0;35m"   # START PINK
G0="\033[0;37m"   # START GREY
# ============================================================================================================
 
# =[ BALISE DE FIN ]==========================================================================================
E="\033[0m"      # END color balise
# =[ BLACK ]==================================================================================================
# -[ FRONTGROUND ]--------------------------------------------------------------------------------------------
N0="\033[0;30m"   # START BLACK
N1="\033[1;30m"   # START BLACK BOLD GLOSSY
N2="\033[2;30m"   # START BLACK BOLD
N3="\033[3;30m"   # START BLACK BOLD ITALIC
N4="\033[4;30m"   # START BLACK BOLD ITALIC UNDERLINES
N5="\033[5;30m"   # START BLACK BOLD ITALIC UNDERLINES BLINKING/FLASHING
N7="\033[7;30m"   # START BLACK BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# -[ BACKGROUND ]---------------------------------------------------------------------------------------------
BGN0="\033[0;40m" # START BACKGROUND BLACK
BGN1="\033[1;40m" # START BACKGROUND BLACK BOLD GLOSSY
BGN2="\033[2;40m" # START BACKGROUND BLACK BOLD
BGN3="\033[3;40m" # START BACKGROUND BLACK BOLD ITALIC
BGN4="\033[4;40m" # START BACKGROUND BLACK BOLD ITALIC UNDERLINES
BGN5="\033[5;40m" # START BACKGROUND BLACK BOLD ITALIC UNDERLINES BLINKING/FLASHING
BGN7="\033[7;40m" # START BACKGROUND BLACK BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ RED ]====================================================================================================
# -[ FRONTGROUND ]--------------------------------------------------------------------------------------------
R0="\033[0;31m"   # START RED
R1="\033[1;31m"   # START RED BOLD GLOSSY
R2="\033[2;31m"   # START RED BOLD
R3="\033[3;31m"   # START RED BOLD ITALIC
R4="\033[4;31m"   # START RED BOLD ITALIC UNDERLINES
R5="\033[5;31m"   # START RED BOLD ITALIC UNDERLINES BLINKING/FLASHING
R7="\033[7;31m"   # START RED BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# -[ BACKGROUND ]---------------------------------------------------------------------------------------------
BGR0="\033[0;41m" # START BACKGROUND RED
BGR1="\033[1;41m" # START BACKGROUND RED BOLD GLOSSY
BGR2="\033[2;41m" # START BACKGROUND RED BOLD
BGR3="\033[3;41m" # START BACKGROUND RED BOLD ITALIC
BGR4="\033[4;41m" # START BACKGROUND RED BOLD ITALIC UNDERLINES
BGR5="\033[5;41m" # START BACKGROUND RED BOLD ITALIC UNDERLINES BLINKING/FLASHING
BGR7="\033[7;41m" # START BACKGROUND RED BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ GREEN ]==================================================================================================
# -[ FRONTGROUND ]--------------------------------------------------------------------------------------------
V0="\033[0;32m"   # START GREEN
V1="\033[1;32m"   # START GREEN BOLD GLOSSY
V2="\033[2;32m"   # START GREEN BOLD
V3="\033[3;32m"   # START GREEN BOLD ITALIC
V4="\033[4;32m"   # START GREEN BOLD ITALIC UNDERLINES
V5="\033[5;32m"   # START GREEN BOLD ITALIC UNDERLINES BLINKING/FLASHING
V7="\033[7;32m"   # START GREEN BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# -[ BACKGROUND ]---------------------------------------------------------------------------------------------
BGV0="\033[0;42m" # START BACKGROUND GREEN
BGV1="\033[1;42m" # START BACKGROUND GREEN BOLD GLOSSY
BGV2="\033[2;42m" # START BACKGROUND GREEN BOLD
BGV3="\033[3;42m" # START BACKGROUND GREEN BOLD ITALIC
BGV4="\033[4;42m" # START BACKGROUND GREEN BOLD ITALIC UNDERLINES
BGV5="\033[5;42m" # START BACKGROUND GREEN BOLD ITALIC UNDERLINES BLINKING/FLASHING
BGV7="\033[7;42m" # START BACKGROUND GREEN BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ BROWN ]==================================================================================================
# -[ FRONTGROUND ]--------------------------------------------------------------------------------------------
M0="\033[0;33m"   # START BROWN
M1="\033[1;33m"   # START BROWN BOLD GLOSSY
M2="\033[2;33m"   # START BROWN BOLD
M3="\033[3;33m"   # START BROWN BOLD ITALIC
M4="\033[4;33m"   # START BROWN BOLD ITALIC UNDERLINES
M5="\033[5;33m"   # START BROWN BOLD ITALIC UNDERLINES BLINKING/FLASHING
M7="\033[7;33m"   # START BROWN BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# -[ BACKGROUND ]---------------------------------------------------------------------------------------------
BGM0="\033[0;43m" # START BACKGROUND BROWN
BGM1="\033[1;43m" # START BACKGROUND BROWN BOLD GLOSSY
BGM2="\033[2;43m" # START BACKGROUND BROWN BOLD
BGM3="\033[3;43m" # START BACKGROUND BROWN BOLD ITALIC
BGM4="\033[4;43m" # START BACKGROUND BROWN BOLD ITALIC UNDERLINES
BGM5="\033[5;43m" # START BACKGROUND BROWN BOLD ITALIC UNDERLINES BLINKING/FLASHING
BGM7="\033[7;43m" # START BACKGROUND BROWN BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ YELLOW ]=================================================================================================
# -[ FRONTGROUND ]--------------------------------------------------------------------------------------------
Y0="\033[0;93m"   # START YELLOW
Y1="\033[1;93m"   # START YELLOW BOLD GLOSSY
Y2="\033[2;93m"   # START YELLOW BOLD
Y3="\033[3;93m"   # START YELLOW BOLD ITALIC
Y4="\033[4;93m"   # START YELLOW BOLD ITALIC UNDERLINES
Y5="\033[5;93m"   # START YELLOW BOLD ITALIC UNDERLINES BLINKING/FLASHING
Y7="\033[7;93m"   # START YELLOW BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# -[ BACKGROUND ]---------------------------------------------------------------------------------------------
BGY0="\033[0;103m" # START BACKGROUND YELLOW
BGY1="\033[1;103m" # START BACKGROUND YELLOW BOLD GLOSSY
BGY2="\033[2;103m" # START BACKGROUND YELLOW BOLD
BGY3="\033[3;103m" # START BACKGROUND YELLOW BOLD ITALIC
BGY4="\033[4;103m" # START BACKGROUND YELLOW BOLD ITALIC UNDERLINES
BGY5="\033[5;103m" # START BACKGROUND YELLOW BOLD ITALIC UNDERLINES BLINKING/FLASHING
BGY7="\033[7;103m" # START BACKGROUND YELLOW BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ BLUE ]==================================================================================================
# -[ FRONTGROUND ]--------------------------------------------------------------------------------------------
B0="\033[0;34m"   # START BLUE
B1="\033[1;34m"   # START BLUE BOLD GLOSSY
B2="\033[2;34m"   # START BLUE BOLD
B3="\033[3;34m"   # START BLUE BOLD ITALIC
B4="\033[4;34m"   # START BLUE BOLD ITALIC UNDERLINES
B5="\033[5;34m"   # START BLUE BOLD ITALIC UNDERLINES BLINKING/FLASHING
B7="\033[7;34m"   # START BLUE BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# -[ BACKGROUND ]---------------------------------------------------------------------------------------------
BGB0="\033[0;44m" # START BACKGROUND BLUE
BGB1="\033[1;44m" # START BACKGROUND BLUE BOLD GLOSSY
BGB2="\033[2;44m" # START BACKGROUND BLUE BOLD
BGB3="\033[3;44m" # START BACKGROUND BLUE BOLD ITALIC
BGB4="\033[4;44m" # START BACKGROUND BLUE BOLD ITALIC UNDERLINES
BGB5="\033[5;44m" # START BACKGROUND BLUE BOLD ITALIC UNDERLINES BLINKING/FLASHING
BGB7="\033[7;44m" # START BACKGROUND BLUE BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ AZURE ]=================================================================================================
# -[ FRONTGROUND ]--------------------------------------------------------------------------------------------
BC0="\033[0;36m"   # START AZURE
BC1="\033[1;36m"   # START AZURE BOLD GLOSSY
BC2="\033[2;36m"   # START AZURE BOLD
BC3="\033[3;36m"   # START AZURE BOLD ITALIC
BC4="\033[4;36m"   # START AZURE BOLD ITALIC UNDERLINES
BC5="\033[5;36m"   # START AZURE BOLD ITALIC UNDERLINES BLINKING/FLASHING
BC7="\033[7;36m"   # START AZURE BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# -[ BACKGROUND ]---------------------------------------------------------------------------------------------
BGBC0="\033[0;46m" # START BACKGROUND AZURE
BGBC1="\033[1;46m" # START BACKGROUND AZURE BOLD GLOSSY
BGBC2="\033[2;46m" # START BACKGROUND AZURE BOLD
BGBC3="\033[3;46m" # START BACKGROUND AZURE BOLD ITALIC
BGBC4="\033[4;46m" # START BACKGROUND AZURE BOLD ITALIC UNDERLINES
BGBC5="\033[5;46m" # START BACKGROUND AZURE BOLD ITALIC UNDERLINES BLINKING/FLASHING
BGBC7="\033[7;46m" # START BACKGROUND AZURE BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ PINK ]==================================================================================================
# -[ FRONTGROUND ]--------------------------------------------------------------------------------------------
P0="\033[0;35m"   # START PINK
P1="\033[1;35m"   # START PINK BOLD GLOSSY
P2="\033[2;35m"   # START PINK BOLD
P3="\033[3;35m"   # START PINK BOLD ITALIC
P4="\033[4;35m"   # START PINK BOLD ITALIC UNDERLINES
P5="\033[5;35m"   # START PINK BOLD ITALIC UNDERLINES BLINKING/FLASHING
P7="\033[7;35m"   # START PINK BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# -[ BACKGROUND ]---------------------------------------------------------------------------------------------
BGP0="\033[0;45m" # START BACKGROUND PINK
BGP1="\033[1;45m" # START BACKGROUND PINK BOLD GLOSSY
BGP2="\033[2;45m" # START BACKGROUND PINK BOLD
BGP3="\033[3;45m" # START BACKGROUND PINK BOLD ITALIC
BGP4="\033[4;45m" # START BACKGROUND PINK BOLD ITALIC UNDERLINES
BGP5="\033[5;45m" # START BACKGROUND PINK BOLD ITALIC UNDERLINES BLINKING/FLASHING
BGP7="\033[7;45m" # START BACKGROUND PINK BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# =[ GREY ]=================================================================================================
# -[ FRONTGROUND ]--------------------------------------------------------------------------------------------
G0="\033[0;37m"   # START GREY
G1="\033[1;37m"   # START GREY BOLD GLOSSY
G2="\033[2;37m"   # START GREY BOLD
G3="\033[3;37m"   # START GREY BOLD ITALIC
G4="\033[4;37m"   # START GREY BOLD ITALIC UNDERLINES
G5="\033[5;37m"   # START GREY BOLD ITALIC UNDERLINES BLINKING/FLASHING
G7="\033[7;37m"   # START GREY BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
# -[ BACKGROUND ]---------------------------------------------------------------------------------------------
BGG0="\033[0;47m" # START BACKGROUND GREY
BGG1="\033[1;47m" # START BACKGROUND GREY BOLD GLOSSY
BGG2="\033[2;47m" # START BACKGROUND GREY BOLD
BGG3="\033[3;47m" # START BACKGROUND GREY BOLD ITALIC
BGG4="\033[4;47m" # START BACKGROUND GREY BOLD ITALIC UNDERLINES
BGG5="\033[5;47m" # START BACKGROUND GREY BOLD ITALIC UNDERLINES BLINKING/FLASHING
BGG7="\033[7;47m" # START BACKGROUND GREY BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED

# =[ TEST AREA ]==============================================================================================
#T0="\033[0;103m"   # START GREY
#T1="\033[1;103m"   # START GREY BOLD GLOSSY
#T2="\033[2;103m"   # START GREY BOLD
#T3="\033[3;103m"   # START GREY BOLD ITALIC
#T4="\033[4;103m"   # START GREY BOLD ITALIC UNDERLINES
#T5="\033[5;103m"   # START GREY BOLD ITALIC UNDERLINES BLINKING/FLASHING
#T7="\033[7;103m"   # START GREY BOLD ITALIC UNDERLINES BLINKING/FLASHING HIGHTLIGHTED
#echo -e ${T0}Test0${E}
#echo -e ${T1}Test0${E}
#echo -e ${T2}Test0${E}
#echo -e ${T3}Test0${E}
#echo -e ${T4}Test0${E}
#echo -e ${T5}Test0${E}
#echo -e ${T7}Test0${E}
