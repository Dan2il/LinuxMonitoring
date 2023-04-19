#!bin/bash

function CheckParametrs {
    CheckQuantitySignFolders ${#array_sign_for_name_folders[@]}
    CheckQuantitySignFiles ${#array_sign_for_name_files[@]}
    CheckQuantitySignExtension ${#extension_file}
    CheckDigit $file_size
    if [[ check_error -eq no_errors ]]
    then
        CheckFileSize $file_size
    fi
}

function CheckQuantityParametrs {
    if [[ $1 -ne 3 ]]
    then
        check_error=1
    fi
}

function CheckQuantitySignFolders {
    if [[ $1 -gt $max_sign_for_name || $1 -eq 0 ]]
    then
        check_error=2
    fi
}

function CheckQuantitySignFiles {
    if [[ $1 -gt $max_sign_for_name || $1 -eq 0 ]]
    then
        check_error=3
    fi
}

function CheckQuantitySignExtension {
    if [[ $1 -gt $max_sign_for_extension || $1 -eq 0 ]]
    then
        check_error=4
    fi
}

function CheckFileSize {
    if [[ $1 -gt $max_file_size ]]
    then
        check_error=5
    fi
}

function CheckDigit {
    if ! [[ $1 =~ [[:digit:]] ]] || [[ $1 =~ [[:alpha:]] ]]
    then
        check_error=6
    fi
}

function CheckBinInWay {
    if [[ $1 == *"/bin"* || $1 == *"/sbin"*  ]]
    then
        echo 1
    else
        echo 0
    fi
}

function CheckNameFolder {
    while :
    do
        if [ -d "$random_way/$folder_name" ]
        then
            CreateNameFolder
            folder_name=$(GetName ${array_name_folders[@]})
        else
            break
        fi
    done
}

function CheckSizeNameFoldes {
    if [[ ${#array_sign_for_name_folders[@]} -lt $(( $min_length_name - 1 )) ]]
    then
        for (( counter_ar_folders = ${#array_sign_for_name_folders[@]}; counter_ar_folders < min_length_name; counter_ar_folders++ ))
        do
            CreateNameFolder
        done
    fi
}

function CheckSizeNameFiles {
    if [[ ${#array_sign_for_name_files[@]} -lt $(( $min_length_name - 1 )) ]]
    then
        for (( counter_ar_folders = ${#array_sign_for_name_files[@]}; counter_ar_folders < min_length_name; counter_ar_folders++ ))
        do
            CreateNameFiles
        done
    fi
}

function CheckSizeName {
    CheckSizeNameFoldes
    CheckSizeNameFiles
}