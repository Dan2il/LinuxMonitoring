#!bin/bash

# Cкрипт запускается с 1 параметром.
# Скрипт должен уметь очистить систему от созданных папок и файлов 3 способами:
# 1: По лог файлу
# 2: По дате и времени создания
# 3: По маске имени (т.е. символы, нижнее подчёркивание и дата).

# Способ очистки задается при запуске скрипта, как параметр со значением 1, 2 или 3.
# При удалении по дате и времени создания, пользователем вводятся 
# времена начала и конца с точностью до минуты. 
# Удаляются все файлы, созданные в указанном временном промежутке. 
# Ввод может быть реализован как через параметры, так и во время выполнения программы.

check_error=0
# 1 - неверное количество параметров при вызове скрипта
# 2 - неверный параметр (не 1, не 2 и не 3)

readonly log_file=1
readonly date_and_time=2
readonly by_name=3

readonly no_error=0
readonly quantity_parametrs=1

. ./check_parametrs.sh
. ./clean.sh

CheckQuantityParametrs $#
CheckDigit $1

if [[ $check_error -eq $no_error ]]
then
    CheckCorrectParametrs $1
    clean_parametrs=$1
    if [[ $check_error -eq $no_error  ]]
    then
        if [[ $clean_parametrs -eq $log_file ]]
        then
            CleanByLogFile
        elif [[ $clean_parametrs -eq $date_and_time ]]
        then
            CleanByDateAndTime
        elif [[ $clean_parametrs -eq $by_name ]]
        then
            CleanByMask
        fi
    fi
fi
if [[ $check_error -ne $no_error ]]
then
    echo "check_error = $check_error"
fi