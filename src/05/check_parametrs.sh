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
    if [[ $1 -ne $sorted_by_response_code && $1 -ne $unique_ip && $1 -ne $requests_with_errors && $1 -ne $unique_ip_among_requests_with_errors ]]
    then
        check_error=2
    fi
}
