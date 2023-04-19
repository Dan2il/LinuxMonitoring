#!bin/bash

function CheckQuantityParametrs {
    if [[ $1 -ne $quantity_parametrs ]]
    then
        check_error=1
    fi
}