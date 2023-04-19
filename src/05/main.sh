#!bin/bash

# Скрипт запускается с 1 параметром, который принимает значение 1, 2, 3 или 4.

# 1: Все записи, отсортированные по коду ответа
# 2: Все уникальные IP, встречающиеся в записях
# 3: Все запросы с ошибками (код ответа - 4хх или 5хх)
# 4: Все уникальные IP, которые встречаются среди ошибочных запросов

check_error=0
# 1 - неверное количество параметров при вызове скрипта
# 2 - неверный параметр (не 1, не 2, не 3 и не 4)

readonly sorted_by_response_code=1
readonly unique_ip=2
readonly requests_with_errors=3
readonly unique_ip_among_requests_with_errors=4

readonly no_error=0
readonly quantity_parametrs=1

. ./check_parametrs.sh
. ./processing.sh

CheckQuantityParametrs $#
CheckDigit $1

if [[ $check_error -eq $no_error ]]
then
    if [[ $1 -eq $sorted_by_response_code ]]
    then
        SortedByResponseCode
    elif [[ $1 -eq $unique_ip ]]
    then
        SortedByUniqueIp
    elif [[ $1 -eq $requests_with_errors ]]
    then
        SortedRequestsWithErrors
    elif [[ $1 -eq $unique_ip_among_requests_with_errors ]]
    then
        SortedUniqueIpAmongRequestsWithErrors
    fi
fi