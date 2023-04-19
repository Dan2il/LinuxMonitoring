#!bin/bash

function CreateRandomWay {
    start_way=$(pwd)
    number_slashes=$(echo $start_way| grep -o "\/" | wc -w)
    
    if [[ $number_slashes -gt 2 ]]
    then
        number_slashes=$(( $number_slashes - 1 ))
    fi
    randon_number=$(shuf -i 1-$number_slashes -n 1)

    if [[ $number_slashes -gt 2 ]]
    then
        for (( i = 0; i < $randon_number; i++ ))
        do
            cd ..
        done
    else
        cd
    fi

    shopt -s failglob
    dirs=(*/)
    [[ $dirs ]] && cd -- "${dirs[RANDOM%${#dirs[@]}]}"
    echo $(pwd)
}

function GetName {
    local name=
    for symbols in $@
    do 
        name+=$symbols
    done
    name+=$(GetDate)
    echo $name
}

function GetNextIndexIncrease {
    local result=-1
    for (( search = $(( $index + 1 )); search < quantity_sign; search++ ))
    do
        if [[ ${#array_name_folders[index]} -eq $max_length_name ]]
        then
            result=$search
            break;
        fi
    done
    echo $result
}

function ClearIndexInName {
    for (( clear_index = 0; clear_index < search_next_increance; clear_index++ ))
    do
        array_name_folders[clear_index]=${array_sign_for_name_folders[clear_index]}
    done
}

function CreateNameFolder () {
    quantity_sign=${#array_sign_for_name_folders[@]}
    quantity_index=$(( $quantity_sign - 1 ))

    for (( index = 0; index < quantity_sign; index++ ))
    do
        if [[ ${#array_name_folders[index]} -lt $max_length_name ]]
        then
            array_name_folders[index]+=${array_sign_for_name_folders[index]}
            break
        elif [[ ${#array_name_folders[index]} -ge $max_length_name || $(GetSizeFolderName) -ge $max_length_name ]]
        then
            if [[ $index -lt $quantity_index ]]
            then
                array_name_folders[0]=${array_sign_for_name_folders[0]}
                search_next_increance=$(GetNextIndexIncrease)
                if [[ search_next_increance -ne -1 ]]
                then
                    array_name_folders[search_next_increance]+=${array_sign_for_name_folders[search_next_increance]}
                    ClearIndexInName
                fi

                break
            else
                printf "End of names"
            fi
        fi
    done
}


function GetNextIndexIncreaseFiles {
    local result=-1
    for (( search = $(( $index + 1 )); search < quantity_sign; search++ ))
    do
        if [[ ${#array_name_files[index]} -eq $max_length_name ]]
        then
            result=$search
            break;
        fi
    done
    echo $result
}

function ClearIndexInNameFiles {
    for (( clear_index = 0; clear_index < search_next_increance; clear_index++ ))
    do
        array_name_files[$clear_index]=${array_sign_for_name_files[clear_index]}
    done
}

function CreateNameFiles {
    local quantity_sign=${#array_sign_for_name_files[@]}
    local quantity_index=$(( $quantity_sign - 1 ))

    for (( index = 0; index < quantity_sign; index++ ))
    do  
        if [[ ${#array_name_files[index]} -lt $max_length_name ]]
        then
            array_name_files[index]+=${array_sign_for_name_files[index]}
            break
        elif [[ ${#array_sign_for_name_files[index]} -ge $max_length_name || $(GetSizeFileName) -ge $max_length_name ]]
        then
            if [[ $index -lt $quantity_index ]]
            then
                array_name_files[0]=${array_sign_for_name_files[0]}
                search_next_increance=$(GetNextIndexIncreaseFiles)
                if [[ $search_next_increance -ne -1 ]]
                then
                    array_name_files[$search_next_increance]+=${array_sign_for_name_files[search_next_increance]}
                    for (( clear_index = 0; clear_index < search_next_increance; clear_index++ ))
                    do
                        array_name_files[$clear_index]=${array_sign_for_name_files[clear_index]}
                    done
                fi
                break
            else
                printf "End of names"
            fi
        fi
    done
}

function CreateFolder {
    CreateNameFolder
    folder_name=$(GetName ${array_name_folders[@]})
    CheckNameFolder
    mkdir $folder_name
    counter_create_folders=$(( $counter_create_folders + 1 ))
    cd $folder_name
}

