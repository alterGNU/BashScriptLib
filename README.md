# Scripts
Collection of personnal Script Or Command

## Use
- 1 : Copy Or Clone **BashScriptLib** inside your bash project
- 2 : Import functions:
    - 2.1 : One by One  : Only the fcts needed : `source ./BashScriptLib/colors.sh`
    - 2.2 : One by One  : not source twice `[[ -z "${_COLORS_SH}" ]] && source ./colors.sh && _COLORS_SH=1`
    - 2.3 : ALL at Ones : `for file in $(ls ./BashScriptLib | grep -v .md);do source ./BashScriptLib/${file};done`

## Table of content
|       File         | Fonction Usage                   |                                 Description                                           |
| :-----------------:|:--------------------------------:|:-------------------------------------------------------------------------------------:|
| **colors.sh**      | `source ./colors.sh`             | Set of Variable for Syntax Coloration                                                 |
| **normi_check.sh** | `normi_check.sh <path/folder>   `| Apply norminette cmd and display result as `tree` for folder passed as arg1           |
| **load_anim.sh**   | `source ./load_anim.sh`  | Exec cmd in backgroung, and display animation while waiting for end of exec           |
