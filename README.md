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
| File                  | Fonction Usage                                  | Description                                                                             |
| :-------------------: | :---------------------------------------------: | :-------------------------------------------------------------------------------------: |
| check42_funused.sh    | `check42_funused <path/project> <projectName>`  | Use <path/project>/Makefile to create <projectName>, then list the function used        |
| check42_makefile.sh   | `check42_makefile <path/project> <projectName>` | Check if <path/project>/Makefile is conforme (rules, compilation tools used ... )       |
| check42_norminette.sh | `check42_norminette.sh <path/folder>`           | Applies norminette and display result as `tree` for folder/file 's path passed as arg1  |
| colors.sh             | `source ./colors.sh`                            | Set of Variable for Syntax Coloration                                                   |
| exec_anim.sh          | `exec_anim <cmd> <anim_name>`                   | Exec cmd in backgroung, and display animation while waiting for end of exec             |
| print.sh              | `print_box_title [-t] [-c] <title>`             | Print start of the box (with <title> as the box's title)                                |
| print.sh              | `echol [-i] [-t] [-c] <line>`                   | Print <line> in a box                                                                   |
| print.sh              | `print_last [-t] [-c]`                          | Print end of the box                                                                    |
| print.sh              | `print_in_box [-t] [-c] <txt1> <txt2>`          | Print <txt1> and <txt2> in box                                                          |
| print.sh              | `printif <test> <text> [<sep>, <OK>, <fail>]`   | Print <text>(<sep> x LEN)(<test>?<pass>:<fail>) in box                                  |

### check42_funused.sh
- Dependencies: 
    - Makefile with all and fclean rules
    - `file` and `nm` commands
- Functions: 
    - GLOBAL:`check42_funused` that list for each arg2..i:<object_files> create by arg1:<path/project>'s Makefile the functions used.
        - Takes at least 2 arguments:
          - arg1    : <path/project>   , path to project
          - arg2..i : <..objectfiles..>, object files (bin, .o, static_lib.a) for which to list the functions used.
        - Examples:
            - `check42_funused ../ft_printf/ libftprintf.a          `: list all functions used by the static lib. libftprintf.a"
            - `check42_funused ../Push_Swap push_swap               `: list all the functions used by the program push_swap"
            - `check42_funused ../libft/ ft_strdup.o ft_putstr_fd.o `: list all functions used by the object file ft_strdup.o and ft_putstr.o"

### check42_makefile.sh
- Dependencies: 
    - print.sh for `printif` function
- Functions: 
    - GLOBAL:`check42_makefile <path/project> <projectName>` : Check if <path/project>/Makefile is conforme
        - Takes exactly 2 arguments then:
            - ☑ check if Makefile exist
            - ☑ check compilation command (not gcc used and have -Wall, -Wextra & -Werror) 
            - ☑ check make all, $(NAME) and no relink
            - ☑ check make clean remove object.o only
            - ☑ check make fclean remove object.o and ${2} ~ $(NAME)
            - ☑ check make re rebuild all
        - Examples:
            - `check42_makefile /../../ft_printf/ libftprintf.a` : Check ft_printf/Makefile conformity, $(NAME) = libftprintf.a
            - `check42_makefile ../Push_Swap push_swap`          : Check Push_swap/Makefile conformity, $(NAME) = push_swap

### check42_norminette.sh
- Dependencies:
    - NONE
- Functions:
    - STATIC:`usage_check42_norminette()`:
        - takes 1 or 2 arguments :
            - arg1 : **mandatory argument** specific text to the encountered error (will be display in the first usage line)
            - arg2 : **optionnal argument** the non null error number (integer returned in terminal)
        - ~static function : call by `check42_norminette()` when something goes wrong (wrong usage) then display usage with
          specific text arg1 then exit with arg2
    
    - STATIC:`normi_color()`:
        - takes 1 **mandatory argument <path_to/file>**
        - ~static function : call by `check42_norminette_rec` and `check42_norminette` to applies the norminette command to the file
          passed as an argument and returns the results in color:
            - green : norminette ok
            - red   : norminette ko
            - white : not an extension supported by norminette
    
    - STATIC:`check42_norminette_rec()`:
        - takes 2 arguments :
            - arg1 : **mandatory argument** prefix
            - arg2 : **mandatory argument** pathto/directory/
        - ~static function : called in `check42_norminette`, will recursively go through the folder structure of the directory provided as an argument and exec `normi_color` to the files.
    
    - GLOBAL:`check42_norminette()`:
        - takes **1 mandatory argument** : path to dir or file to check with the norminette.
        - ~global function called by user :
            - if arg1 is a folder   : use `check42_norminette_rec()` to recursively go through the folder structure of the directory provided as an argument and then applies `normi_color` to each files encountered.
            - if arg1 is a file     : use `normi_color()` on that file

### colors.sh
_Notes:set of variables allowing text highlighting in the terminal._

### exec_anim.sh
_Notes: In this script animations are stored into list named : **LA_<list_name>=( <speed_frame_value> 'symb1' 'symb2' ... 'symbX' )**_
- Dependencies:
    - NONE
- Functions:
    - STATIC:`usage_exec_anim()`:
        - takes 1 or 2 arguments :
            - arg1 : **mandatory argument** specific text to the encountered error (will be display in the first usage line)
            - arg2 : **optionnal argument** the non null error number (integer returned in terminal)
        - ~static function : call by `exec_anim()` when something goes wrong (wrong usage) then display usage with
          specific text arg1 then exit with arg2
    
    - STATIC:`loading_animation()`:
        - takes 1 or 2 arguments :
            - arg1 : **mandatory argument** specific text to the encountered error (will be display in the first usage line)
            - arg2 : **optionnal argument** the non null error number (integer returned in terminal)
        - ~static function : call by `exec_anim()` when something goes wrong (wrong usage) then display usage with
          specific text arg1 then exit with arg2
    
    - GLOBAL:`exec_anim()`:
        - takes 1 or 2 arguments :
            - arg1 : **mandatory argument** the command to execute, make sure that the command and his argument are one arg
              ("cmd arg1 arg2 ... argX")
            - arg2 : **optionnal argument** the *list_name* (see at the beginning of the file what are the list_name
              availlable)
        - ~global function : call by user to exec a fct in background while an animation is launch in frontground, then
          display the commands return to the terminal.

### print_in_box.sh  
_NOTES:Has multiples fonctions to print text inside a box, all theses fun works with opt. to define the box:
  + `-t` or `--type`    : int between 0 and 3 define the box type (default simple line)
  + `-c` or `--colors`  : str (cf COLORS dict), def. the box color (default white)
  + `-i` or `--indent`  : int (specific to echol fun.), def. the indentation and symbol of the line inside the box_
- Dependencies:
    - NONE
- Functions:
    - GLOBAL:`print_title [-t] [-c] <text_to_print_as_title>`
    - GLOBAL:`echol [-i] [-t] [-c] <line_to_print_in_the_box>`
    - GLOBAL:`print_last [-t] [-c]`
    - GLOBAL:`print_in_box [-t] [-c] <text_to_print_as_title>`
    - GLOBAL:`printif <test> <text> [<sep>, <OK>, <fail>]`

## Sources
### **exec_anim**
- [bash_progress_bar by @pollev](https://github.com/pollev/bash_progress_bar.git)
- [bash_loading_animations by @Silejonu](https://github.com/Silejonu/bash_loading_animations.git)
