#!bin/bash

check_error=0
# 1 - неверное количество параметров при вызове скрипта

readonly no_error=0

function CheckQuantityParametrs {
    if [[ $1 -ne $quantity_parametrs ]]
    then
        check_error=1
    fi
}

CheckQuantityParametrs $#

if [[ $check_error -eq $no_error ]]
then
    printf "Write way to log (../04): \n"
    read way_to_log
    goaccess $way_to_log/*.log --log-format=COMBINED -o index.html
fi