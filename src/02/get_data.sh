#!bin/bash

function GetEmptyMem {
    echo $(df -h / -BM | grep "/" | awk -F"M" '{ print $3 }')
}

function GetDate {
    local file_name=`date +_%d%m%y`
    echo $file_name
}

function GetSizeFileName {
    local size=0
    for symblos in ${array_name_files[@]}
    do
        size=$(( $size + ${#symblos} ))
    done
    echo $size
}


function GetSizeFolderName {
    local size=0
    for symblos in ${array_name_folders[@]}
    do
        size=$(( $size + ${#symblos} ))
    done
    echo $size
}
