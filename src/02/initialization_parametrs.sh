#!bin/bash

function InitializationParametrs {
    array_sign_for_name_folders=($(echo $(InitializationArraySignNameFolders $1) | tr " " "\n"))
    array_name_folders=(${array_sign_for_name_folders[@]})
    InitializationArraySignNameFilesAndExtensionFiles $2
    array_name_files=(${array_sign_for_name_files[@]})
    InitializationFileSize $3
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

function InitializationFileSize {
    file_size=${1%%Mb}
}