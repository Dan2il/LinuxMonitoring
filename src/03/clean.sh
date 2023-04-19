#!bin/bash

function CleanByLogFile {
    echo -e "Write the way to the log file (example: ../02/log.log):"
    read way_to_log
    logs="$(cat $way_to_log | awk -F'  ' '{print $1}')"
    array_address=($(echo $logs | tr " " "\n"))

    del_dir_name=()
    del_way=()

    for (( counter_log = 0; counter_log < ${#array_address[@]}; counter_log++ ))
    do  
        if [[ ${array_address[counter_log]} = "Dir_name:" ]]
        then
            counter_log=$(( $counter_log + 1 ))
            del_dir_name+=(${array_address[counter_log]})
        fi
        
        if [[ ${array_address[counter_log]} = "Way:" ]]
        then
            counter_log=$(( $counter_log + 1 ))
            del_way+=(${array_address[counter_log]})
        fi
    done

    for (( counter = 0; counter < ${#del_dir_name[@]}; counter++ ))
    do  
        rm -rf ${del_way[counter]}/${del_dir_name[counter]}
    done
}

function CleanByDateAndTime {
    echo -e "Write start time (example: 2023-01-22 19:22):"
    read del_start
    echo -e "Write finish time (example: 2023-01-22 19:24):"
    read del_finish
    del_file=$(find / -type f -newerct "$del_start" ! -newerct "$del_finish" 2>/dev/null | grep $(date +"%d%m%y") )
    array_del_file=($(echo $del_file | tr " " "\n"))
    for (( i = 0; i < ${#array_del_file[@]}; i++ ))
    do  
        del_way=${array_del_file[i]}
        del_way=$(echo ${del_way%/*})
        if [[ -d "$del_way" ]] 
        then
            rm -rf $del_way
        fi

    done
}

function CleanByMask {
    echo -e "Write mask (example: gfop_220123):"
    read mask
    del_file=$(find / -path "*$mask*" 2>/dev/null)
    array_del_file=($(echo $del_file | tr " " "\n"))
    for (( i = 0; i < ${#array_del_file[@]}; i++ ))
    do  
        del_way=${array_del_file[i]}
        if [[ -d "$del_way" ]] 
        then
            echo $del_way
            rm -rf $del_way
        fi

    done
}