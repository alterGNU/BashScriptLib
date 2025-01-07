# BashScriptLib
BSL is a collection of **use{full,less}** {script,command,function} in bashscript.

When I write scripts in bash I often use the same functions or variables (usage, colors, etc...).

To avoid writing them each time, I group them in a folder (**BSL**) and source them in my bash scripts.

## Usage Guide
In order to use these BashScript Collection, first clone the repo to `<path_to_BSL_folder>` : 
*(dont forget to replace `<path_to_BSL_folder>` by your path to the cloned BSL folder)*
```bash
git clone https://github.com/alterGNU/BashScriptLib.git <path_to_BSL_folder>
```

### Use a specifique bash script
- To add/import/source **a specifique** bashscript from my collection to your script put these line at the top of your script 
*(dont forget to replace <path_to_BSL_folder> and <spec_bash_script_name> by appropriate filepath and script name)*
- 1 : `source <path_to_BSL_folder>/src/<spec_bash_script_name>`
- 2 : to avoid multiple sourcing you can also use an **ENV_VAR** (exemple with colors.sh bashscript):
    `[[ -z "${_COLORS_SH}" ]] && source <path_to_BSL_folder>/src/colors.sh && _COLORS_SH=1`

### Use my entire BashScriptLib
- To add/import/source **all** my bashscript collection to a script put these lines at the top of your script 
*(dont forget to replace :`<path_to_BSL_folder>` by your path to BSL folder)*
```bash
for src_file in $(ls <path_to_BSL_folder>/src);do source <path_to_BSL_folder>/src/${src_file};done
```

## Table of content
| File                | Fonction Usage                          | Description                                                                             |
| :-----------------: | :-------------------------------------: | :-------------------------------------------------------------------------------------: |
| **colors.sh**       | `source ./colors.sh`                    | Set of Variable for Syntax Coloration                                                   |
| **normi_check.sh**  | `normi_check.sh <path/folder>`          | Applies norminette and display result as `tree` for folder/file 's path passed as arg1  |
| **load_anim.sh**    | `exec_anim <cmd> <anim_name>`           | Exec cmd in backgroung, and display animation while waiting for end of exec             |
| **print.sh**        | ``                                      | Print text                                                                              |

### colors.sh
- set of variables allowing syntax highlighting in the terminal .

### normi_check.sh
- `usage_normi_check()`:
    - takes 1 or 2 arguments :
        - arg1 : **mandatory argument** specific text to the encountered error (will be display in the first usage line)
        - arg2 : **optionnal argument** the non null error number (integer returned in terminal)
    - ~static function : call by `normi_check()` when something goes wrong (wrong usage) then display usage with
      specific text arg1 then exit with arg2

- `normi_color()`:
    - takes 1 **mandatory argument <path_to/file>**
    - ~static function : call by `normi_check_rec` and `normi_check` to applies the norminette command to the file
      passed as an argument and returns the results in color:
        - green : norminette ok
        - red   : norminette ko
        - white : not an extension supported by norminette

- `normi_check_rec()`:
    - takes 2 arguments :
        - arg1 : **mandatory argument** prefix
        - arg2 : **mandatory argument** pathto/directory/
    - ~static function : called in `normi_check`, will recursively go through the folder structure of the directory provided as an argument and exec `normi_color` to the files.

- `normi_check()`:
    - takes **1 mandatory argument** : path to dir or file to check with the norminette.
    - ~global function called by user :
        - if arg1 is a folder   : use `normi_check_rec()` to recursively go through the folder structure of the directory provided as an argument and then applies `normi_color` to each files encountered.
        - if arg1 is a file     : use `normi_color()` on that file

### load_anim.sh
- In this script animations are stored into list named : **LA_<list_name>=( <speed_frame_value> 'symb1' 'symb2' ... 'symbX' )**

- `usage_exec_anim()`:
    - takes 1 or 2 arguments :
        - arg1 : **mandatory argument** specific text to the encountered error (will be display in the first usage line)
        - arg2 : **optionnal argument** the non null error number (integer returned in terminal)
    - ~static function : call by `exec_anim()` when something goes wrong (wrong usage) then display usage with
      specific text arg1 then exit with arg2

- `loading_animation()`:
    - takes 1 or 2 arguments :
        - arg1 : **mandatory argument** specific text to the encountered error (will be display in the first usage line)
        - arg2 : **optionnal argument** the non null error number (integer returned in terminal)
    - ~static function : call by `exec_anim()` when something goes wrong (wrong usage) then display usage with
      specific text arg1 then exit with arg2

- `exec_anim()`:
    - takes 1 or 2 arguments :
        - arg1 : **mandatory argument** the command to execute, make sure that the command and his argument are one arg
          ("cmd arg1 arg2 ... argX")
        - arg2 : **optionnal argument** the *list_name* (see at the beginning of the file what are the list_name
          availlable)
    - ~global function : call by user to exec a fct in background while an animation is launch in frontground, then
      display the commands return to the terminal.

### print_in_box.sh  
- Multiples fonctions to print in boxes, all theses fun have opt. to define the box:
  + `-t` or `--type`    : int between 0 and 3 define the box type (default simple line)
  + `-c` or `--colors`  : str (cf COLORS dict), def. the box color (default white)
  + `-i` or `--indent`  : int (specific to echol fun.), def. the indentation and symbol of the line inside the box
- `print_title [-t] [-c] <text_to_print_as_title>`
- `echol [-i] [-t] [-c] <line_to_print_in_the_box>`
- `print_last [-t] [-c]`
- `print_in_box [-t] [-c] <text_to_print_as_title>`

## Sources
### **load_anim**
- [bash_progress_bar by @pollev](https://github.com/pollev/bash_progress_bar.git)
- [bash_loading_animations by @Silejonu](https://github.com/Silejonu/bash_loading_animations.git)
