#!bin/bash

start_time=$(date +%T)
start_time_counter=$(date +%s)
echo -e "Script launch time: $start_time\n" >> log.log


. ./check_parametrs.sh
. ./initialization_parametrs.sh
. ./error_processing.sh
. ./create.sh
. ./get_data.sh

# запуск с 3 параметрами:
# Параметр 1 - список букв английского алфавита, используемый в названии папок (не более 7 знаков). 
# Параметр 2 - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). 
# Параметр 3 - размер файла (в Мегабайтах, но не более 100).
# Пример:
# main.sh az az.az 3Mb

array_sign_for_name_folders=()
array_sign_for_name_files=()

array_name_folders=()
array_name_files=()

extension_file=
file_size=

counter_create_folders=0
counter_create_files=0

check_error=0
# 1 - неверное количество параметров при вызове скрипта
# 2 - букв для имени папки дано больше 7 (максимум по условию)
# 3 - букв для имени файла дано больше 7 (максимум по условию) или не даны вообще
# 4 - букв для расширения дано больше 3 (максимум по условию) или не даны вообще
# 5 - превышен макисмальный размер файла
# 6 - лишние символы в параметре размера файла

readonly quantity_parametrs=3
readonly max_sign_for_name=7
readonly max_sign_for_extension=4
readonly max_file_size=100
readonly no_errors=0
readonly max_length_name=240
readonly min_length_name=4
readonly max_create_folders=100

readonly limit_mem=78000

CheckQuantityParametrs $#

if [[ check_error -eq no_errors ]]
then
    InitializationParametrs $@
    CheckParametrs
fi

touch log.log
log_way=$(pwd)
echo -e "Empty_mem_start: $(GetEmptyMem) Mb\n" >> $log_way/log.log

if [[ check_error -eq no_errors ]]
then
    CheckSizeName
    for (( empty_mem=$(GetEmptyMem); empty_mem > $limit_mem; empty_mem=$(GetEmptyMem) ))
    do  
        random_way=$(CreateRandomWay)
        check_bin=$(CheckBinInWay $random_way)
        if [[ $check_bin -eq 0 ]]
        then
            cd $random_way
            if [[ -d $random_way ]]
            then
                CreateFolder

                quantity_files=$(( $RANDOM % 1000 ))
                echo -e "Dir_name: $folder_name\nQuantity_files: $quantity_files\n$(date +'%Y-%m-%d %H:%M:%S')\nWay: $random_way\n" >> $log_way/log.log

                for (( counter_files = 0; counter_files < quantity_files; counter_files++ ))
                do  
                    empty_mem=$(GetEmptyMem)
                    if [[ $empty_mem -gt $limit_mem ]]
                    then   
                        CreateNameFiles
                        file_name=$(GetName ${array_name_files[@]})$extension_file
                        fallocate -l $file_size"MB" $file_name

                        counter_create_files=$(( $counter_create_files + 1 ))

                        echo -e "File_name: $file_name\n$(date +'%Y-%m-%d %H:%M:%S')\n$(pwd)\nFile_size: $file_size\n"  >> $log_way/log.log
                    else
                        break
                    fi
                done
            fi
        fi
        if [[ $counter_create_folders -gt $max_create_folders ]]
        then
            breal
        fi
    done

fi

echo -e "Empty_mem_finish: $(GetEmptyMem) Mb\nCreate_folders: $counter_create_folders\nCreate_files: $counter_create_files\nCheck_error: $check_error\n" >> $log_way/log.log

end_time=$(date +%T)
end_tome_counter=$(date +%s)
run_time=$(( $end_tome_counter - $start_time_counter ))

echo -e "Script completion time: $end_time_to_display\nrun time: $run_time\n" >> log.log

echo -e "Start time: $start_time\nEnd time:  $end_time\nRuntime: $run_time seconds"