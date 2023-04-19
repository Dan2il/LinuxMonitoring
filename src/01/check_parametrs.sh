#!/bin/bash

function СomparingTwoNumbers {
    if [[ $1 -lt $2 ]] 
    then
        status_correct_parametrs=1
    elif [[ $1 -gt $2 ]]
    then
        status_correct_parametrs=2
    fi
}

function CheckCorrectWay {
    if ! [[ -e $1 ]]
    then
        status_correct_parametrs=3
    elif ! [[ -r $1 ]]
    then
        status_correct_parametrs=4
    fi
}

function CheckNum {
    if [[ $1 -le 0 ]]
    then
        status_correct_parametrs=8
    fi
}

function CheckDigit {
    if ! [[ $1 =~ [[:digit:]] ]] || [[ $1 =~ [[:alpha:]] ]]
    then
        status_correct_parametrs=5
    fi
}

function CheckAlpha {
    if [[ $1 =~ [[:digit:]] ]] || ! [[ $1 =~ [[:alpha:]] ]]
    then
        status_correct_parametrs=6
    fi
}

function CheckLengthString {
    if [[ $(expr length "$1") -gt $2 ]]
    then
        status_correct_parametrs=7
    fi
}

function CheckParametrsScript {
    СomparingTwoNumbers $# number_of_parameters
    if [[ status_correct_parametrs -eq 0 ]]
    then
        CheckCorrectWay $1
        CheckDigit $2
        CheckNum $2
        CheckAlpha $3
        CheckLengthString $3 max_length_string
        CheckDigit $4
        CheckNum $4

        IFS='.' read -ra my_array <<< $5
        СomparingTwoNumbers ${#my_array[*]} array_size
        CheckAlpha ${my_array[0]}
        CheckLengthString ${my_array[0]} max_length_string
        CheckAlpha ${my_array[1]}
        CheckLengthString ${my_array[1]} max_length_string

        CheckDigit ${6%%kb}
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