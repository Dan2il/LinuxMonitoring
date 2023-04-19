#!/bin/bash

function GetFreeTotalMem {
    array_mem=$(echo $(df -h / | awk '{print $4}') | tr " " "\n")
    mem=($(echo $array_mem | tr " " "\n"))
    echo ${mem[1]%%G}
}

function GetEmptyMem {
    echo $(df -h / -BM | grep "/" | awk -F"M" '{ print $3 }')
}

function InitializingVariables {
    readonly way=$1
    readonly number_folders=$2
    readonly letters_for_generating_names_folders=$3
    readonly number_files=$4
    IFS='.' read -ra my_array <<< $5
    readonly letters_for_generating_names_files=${my_array[0]}
    readonly letters_for_generating_expansion_files=${my_array[1]}
    readonly file_size=${6%%kb}
}

function InitializationParametrs {
    array_sign_for_name_folders=($(echo $(InitializationArraySignNameFolders $1) | tr " " "\n"))
    array_name_folders=(${array_sign_for_name_folders[@]})
    InitializationArraySignNameFilesAndExtensionFiles $2
    array_name_files=(${array_sign_for_name_files[@]})
}

function InitializationArraySignNameFolders {
    echo $1 | grep -o .
}

function InitializationArraySignNameFilesAndExtensionFiles {
    IFS='.' read -ra data_array <<< $1
    array_sign_for_name_files=($(echo $(echo ${data_array[0]} | grep -o .) | tr " " "\n"))
    if [[ ${#data_array[@]} -eq 2 ]]
    then
        extension_file=.${data_array[1]}
    fi
}

function GetSizeFileName {
    local size=0
    for symblos in ${array_name_files[@]}
    do
        size=$(( $size + ${#symblos} ))
    done
    echo $size
}