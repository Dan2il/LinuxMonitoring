#!bin/bash

function GenetateIpAddress {
    first_octet=$(shuf -i 0-172 -n 1)
    second_octet=$(shuf -i 0-255 -n 1)
    third_octet=$(shuf -i 0-255 -n 1)
    fourth_octet=$(shuf -i 0-255 -n 1)
    ip_address=$first_octet.$second_octet.$third_octet.$fourth_octet
}

function GenerateDayInDate {
    if [[ $num_month -eq 1 || $num_month -eq 3 || $num_month -eq 5 || $num_month -eq 7 || $num_month -eq 8 || $num_month -eq 10 || $num_month -eq 12 ]]
    then
        date_day=$(shuf -i 1-31 -n 1)
    elif [[ $num_month -eq 2 ]] 
    then
        date_day=$(shuf -i 1-28 -n 1)
    else
        date_day=$(shuf -i 1-30 -n 1)
    fi
    if [[ $date_day -lt 10 ]]
    then
        date_day=0$date_day
    fi
}

function GenerateDate {
    date_year=$(shuf -i $min_year-$max_year -n 1)
    num_month=$(shuf -i 0-11 -n 1)
    date_month=${array_months[$num_month]}
    GenerateDayInDate
}

function GenerateRequest {
    num_methods=$(shuf -i 0-4 -n 1)
    methods=${array_methods[num_methods]}

    num_url=$(shuf -i 0-2 -n 1)
    url=${array_url[num_url]}

    num_protocols=$(shuf -i 0-2 -n 1)
    protocol=${array_protocols[num_protocols]}

    http_request="\"$methods $array_url $protocol\""
}

function GenerateCode {
    num_response_codes=$(shuf -i 0-9 -n 1)
    response_code=${array_response_codes[num_response_codes]}
}

function GenerateBytes {
	response_byte=$(shuf -i 64-8192 -n 1)
}

function GenerateAgent {
    num_agents=$(shuf -i 0-7 -n 1)
    agent="\"${array_agents[num_agents]}\""
}