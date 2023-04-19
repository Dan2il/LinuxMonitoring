#!bin/bash

function SortedByResponseCode {
    printf "Write way to log (../04): \n"
    read way_to_log
    counter=1
    for i in $way_to_log/*
    do
        if [[ $i == *".log" ]];
        then
            touch result_$counter.log
            awk -F ' ' '{ print $11":", $0 }' "$way_to_log/$i" | sort >> result_$counter.log
            counter=$(( $counter + 1))
        fi
    done
}

function SortedByUniqueIp {
    printf "Write way to log (../04): \n"
    read way_to_log
    counter=1
    for i in $way_to_log/*
    do
        if [[ $i == *".log" ]];
        then
            touch result_$counter.log
            awk -F ' ' '{ print $1 }' "$way_to_log/$i" | sort -nu >> result_$counter.log
            counter=$(( $counter + 1))
        fi
    done
}

function SortedRequestsWithErrors {
    printf "Write way to log (../04): \n"
    read way_to_log
    counter=1
    for i in $way_to_log/*
    do
        if [[ $i == *".log" ]];
        then
            touch result_$counter.log
            awk -F ' ' '/[45][0-9][0-9]/{ print $0 }' "$way_to_log/$i" >> result_$counter.log
            counter=$(( $counter + 1))
        fi
    done
}

function SortedUniqueIpAmongRequestsWithErrors {
    printf "Write way to log (../04): \n"
    read way_to_log
    counter=1
    for i in $way_to_log/*
    do
        if [[ $i == *".log" ]];
        then
            touch result_$counter.log
            awk -F ' ' '/[45][0-9][0-9]/{ print $0 }' "$way_to_log/$i" | awk -F ' ' '{ print $1 }' "$way_to_log/$i" | sort -nu >> result_$counter.log
            counter=$(( $counter + 1))
        fi
    done
}