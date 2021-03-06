#!/usr/bin/env bash
#
# Description: A tool to manage git repos.
# Author: Niklas Heer (niklas.heer@gmail.com)
# Version: 0.1.1 (2017-06-30)

REPO_DIR="$HOME/repos"
UPDATABLE_DIRS=()

#########################
# The command line help #
#########################
repo_display_help() {
    echo "Usage: repos [option...]" >&2
    echo
    echo "   -h, help           Displays this help page."
    echo "   -a, add            Add a repository to repos."
    echo "   -l, list           Displays a tree of all repos."
    echo "   -s, status         Displays all repos with uncommited changes."
    echo "   -j, jump <int>     Jumps into the repo main dir. ($REPO_DIR)"
    echo "              └────── Jumps into the repo which number is provided by \"status\"."
    echo
}

##################
# Status command #
##################
repo_status() {
    echo "$REPO_DIR"
    cd "$REPO_DIR"
    
    UPDATABLE_DIRS=()
    
    bold=$(tput bold)
    normal=$(tput sgr0)
    
    all_dirs=0;
    up_dirs=0;
    
    for file in */*/*; do
        if [[ -d "$file" && ! -L "$file" ]]; then
            ((all_dirs++))
            output="$(git -c color.status=always -C $file status -s -u)"
            
            if [ ! -z "$output" ]; then
                
                ((up_dirs++))
                
                UPDATABLE_DIRS+="$file"
                
                folder="${file%%/*}";
                subfolder="${file#*/}";

                printf "├── $folder\n";
                printf "│   └── ($up_dirs) $subfolder\n";

                # outputs each files git status  
                while read -r output; do
                    printf "│             $output\n"
                done <<< "$output"
            fi;
        fi;
    done;
    
    if [ "$up_dirs" -eq "0" ]; then
        printf "└── ${bold}Everything is okay. :)${normal}\n";
    else
        printf "│\n└── ${bold}$up_dirs${normal} out of ${bold}$all_dirs${normal} have changes.\n";
    fi
    
    cd $OLDPWD
}

list() {
    tree -d -L 3 "$REPO_DIR"
}

add_repo(){
    url=$1
    url_without_suffix="${url%.*}"
    reponame="$(basename "${url_without_suffix}")"
    hostname="$(basename "${url_without_suffix%/${reponame}}")"

    echo "$url_without_suffix"
    echo "$reponame"
    echo "$hostname"
    # echo "Error: NIY. (URL: $1)"
}


main() {
    case "$1" in
        -h | help)
            repo_display_help  # Call your function
        ;;
        -j | jump)
            if [ -z "$2" ]; then
                cd "$REPO_DIR"
            else
                cd "$REPO_DIR/${UPDATABLE_DIRS[$2]}"
            fi
        ;;
        -a | add)
            add_repo $2
        ;;
        -l | list)
            list
        ;;
        -s | status)
            repo_status
        ;;
        -*)
            echo "Error: Unknown option: $1" >&2
        ;;
        *)  # No more options
            list
        ;;
    esac
}

main "$@"