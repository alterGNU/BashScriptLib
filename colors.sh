#!/bin/bash
 
# ==================================================================================================
# Ensemble de variables de coloration
# ==================================================================================================
# =[ BALISE DE FIN ]================================================================================
E="\033[0m"                                                      # END color balise
# =[ BLANC ]========================================================================================
W0="\033[0;29m"  # START BLANC
W1="\033[1;29m"  # START BLANC GRAS BRILLANT
W2="\033[2;29m"  # START BLANC GRAS
W3="\033[3;29m"  # START BLANC GRAS ITALIQUE
W4="\033[4;29m"  # START BLANC GRAS ITALIQUE SOULIGNE
W5="\033[5;29m"  # START BLANC GRAS ITALIQUE SOULIGNE CLIGNOTANT
W7="\033[7;29m"  # START BLANC GRAS ITALIQUE SOULIGNE CLIGNOTANT SURLIGNE
# =[ NOIR ]=========================================================================================
N0="\033[0;30m"  # START NOIR
N1="\033[1;30m"  # START NOIR GRAS BRILLANT
N2="\033[2;30m"  # START NOIR GRAS
N3="\033[3;30m"  # START NOIR GRAS ITALIQUE
N4="\033[4;30m"  # START NOIR GRAS ITALIQUE SOULIGNE
N5="\033[5;30m"  # START NOIR GRAS ITALIQUE SOULIGNE CLIGNOTANT
N7="\033[7;30m"  # START NOIR GRAS ITALIQUE SOULIGNE CLIGNOTANT SURLIGNE
# =[ ROUGE ]========================================================================================
R0="\033[0;31m"  # START ROUGE
R1="\033[1;31m"  # START ROUGE GRAS BRILLANT
R2="\033[2;31m"  # START ROUGE GRAS
R3="\033[3;31m"  # START ROUGE GRAS ITALIQUE
R4="\033[4;31m"  # START ROUGE GRAS ITALIQUE SOULIGNE
R5="\033[5;31m"  # START ROUGE GRAS ITALIQUE SOULIGNE CLIGNOTANT
R7="\033[7;31m"  # START ROUGE GRAS ITALIQUE SOULIGNE CLIGNOTANT SURLIGNE
# =[ VERT ]=========================================================================================
V0="\033[0;32m"  # START VERT
V1="\033[1;32m"  # START VERT GRAS BRILLANT
V2="\033[2;32m"  # START VERT GRAS
V3="\033[3;32m"  # START VERT GRAS ITALIQUE
V4="\033[4;32m"  # START VERT GRAS ITALIQUE SOULIGNE
V5="\033[5;32m"  # START VERT GRAS ITALIQUE SOULIGNE CLIGNOTANT
V7="\033[7;32m"  # START VERT GRAS ITALIQUE SOULIGNE CLIGNOTANT SURLIGNE
# =[ MARRON ]=======================================================================================
M0="\033[0;33m"  # START MARRON
M1="\033[1;33m"  # START MARRON GRAS BRILLANT
M2="\033[2;33m"  # START MARRON GRAS
M3="\033[3;33m"  # START MARRON GRAS ITALIQUE
M4="\033[4;33m"  # START MARRON GRAS ITALIQUE SOULIGNE
M5="\033[5;33m"  # START MARRON GRAS ITALIQUE SOULIGNE CLIGNOTANT
M7="\033[7;33m"  # START MARRON GRAS ITALIQUE SOULIGNE CLIGNOTANT SURLIGNE
# =[ BLEU ]=========================================================================================
B0="\033[0;34m"  # START BLEU
B1="\033[1;34m"  # START BLEU GRAS BRILLANT
B2="\033[2;34m"  # START BLEU GRAS
B3="\033[3;34m"  # START BLEU GRAS ITALIQUE
B4="\033[4;34m"  # START BLEU GRAS ITALIQUE SOULIGNE
B5="\033[5;34m"  # START BLEU GRAS ITALIQUE SOULIGNE CLIGNOTANT
B7="\033[7;34m"  # START BLEU GRAS ITALIQUE SOULIGNE CLIGNOTANT SURLIGNE
# =[ ROSE ]=========================================================================================
P0="\033[0;35m"  # START ROSE
P1="\033[1;35m"  # START ROSE GRAS BRILLANT
P2="\033[2;35m"  # START ROSE GRAS
P3="\033[3;35m"  # START ROSE GRAS ITALIQUE
P4="\033[4;35m"  # START ROSE GRAS ITALIQUE SOULIGNE
P5="\033[5;35m"  # START ROSE GRAS ITALIQUE SOULIGNE CLIGNOTANT
P7="\033[7;35m"  # START ROSE GRAS ITALIQUE SOULIGNE CLIGNOTANT SURLIGNE
 
# =[ TESTS ]========================================================================================
T0="\033[0;36m"  # START BLANC
T1="\033[1;36m"  # START BLANC GRAS BRILLANT
T2="\033[2;36m"  # START BLANC GRAS
T3="\033[3;36m"  # START BLANC GRAS ITALIQUE
T4="\033[4;36m"  # START BLANC GRAS ITALIQUE SOULIGNE
T5="\033[5;36m"  # START BLANC GRAS ITALIQUE SOULIGNE CLIGNOTANT
T7="\033[7;36m"  # START BLANC GRAS ITALIQUE SOULIGNE CLIGNOTANT SURLIGNE
echo -e "${T0}coucou${E}"
echo -e "${T1}coucou${E}"
echo -e "${T2}coucou${E}"
echo -e "${T3}coucou${E}"
echo -e "${T4}coucou${E}"
echo -e "${T5}coucou${E}"
echo -e "${T7}coucou${E}"
