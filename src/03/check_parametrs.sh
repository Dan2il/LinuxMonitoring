#!bin/bash

function CheckQuantityParametrs {
    if [[ $1 -ne $quantity_parametrs ]]
    then
        check_error=1
    fi
}

function CheckDigit {
    if ! [[ $1 =~ [[:digit:]] ]] || [[ $1 =~ [[:alpha:]] ]]
    then
        check_error=6
    fi
}

function CheckCorrectParametrs {
    if [[ $1 -ne $log_file && $1 -ne $date_and_time && $1 -ne $by_name ]]
    then
        check_error=2
    fi
}