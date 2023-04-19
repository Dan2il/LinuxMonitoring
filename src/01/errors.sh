#!/bin/bash

errors[0]="Correct parametrs"
errors[1]="Not enough parameters are specified"
errors[2]="Extra parameters are specified"
errors[3]="Non-existent path"
errors[4]="No access"
errors[5]="Number contains letters"
errors[6]="String contains numbers"
errors[7]="String length exceeded"
errors[8]="Zero or negative number"

function PrintErrors {
    code_errors=$1
    if [[ code_errors -ne 0 ]]
    then
        echo ${errors[code_errors]}
    fi
}