#!/bin/bash

readonly no_errors=0
readonly number_of_parameters=6
readonly max_length_string=7
readonly array_size=2
readonly min_total_mem=1
readonly min_length_of_names=4
readonly max_length_name=240

array_sign_for_name_folders=()
array_sign_for_name_files=()

array_name_folders=()
array_name_files=()

extension_file=
file_size=

. ./check_parametrs.sh
. ./errors.sh
. ./get_data.sh
. ./create.sh

status_correct_parametrs=0;

CheckParametrsScript $@

folder_name=
file_name=

if [[ $status_correct_parametrs -eq $no_errors ]]
then

    touch log.log
    log_way=$(pwd)
    echo -e "Empty_mem_start: $(GetEmptyMem) Mb\n" >> $log_way/log.log

    if [[ $(GetFreeTotalMem) -gt $min_total_mem ]]
    then
        InitializingVariables $@
        InitializationParametrs $3 $5

        for ((iteration_counter = 0 ; iteration_counter < $number_folders ; iteration_counter++));
        do  
            cd $way
            if [[ $(GetFreeTotalMem) -le $min_total_mem ]]
            then
                break
            fi
            CreateFolder
            echo -e "Dir_name: $folder_name\n$(date +'%Y-%m-%d %H:%M:%S')\n$way\n" >> $log_way/log.log
                for ((iteration_counter_files = 0 ; iteration_counter_files < $number_files ; iteration_counter_files++));
                do
                    if [[ $(GetFreeTotalMem) -le $min_total_mem ]]
                    then 
                        break
                    fi
                    CreateNameFiles
                    file_name=$(GetName ${array_name_files[@]})$extension_file
                    fallocate -l $file_size"KB" $file_name
                    echo -e "File_name: $file_name\n$(date +'%Y-%m-%d %H:%M:%S')\n$(pwd)\nFile_size: $file_size\n"  >> $log_way/log.log
                done
        done
    else
        echo mem: $(GetFreeTotalMem) Gi
        echo min_total_mem: $min_total_mem Gi
    fi
else
    PrintErrors status_correct_parametrs
fi

echo -e "Empty_mem_finish: $(GetEmptyMem) Mb\nCheck_error: $check_error" >> $log_way/log.log