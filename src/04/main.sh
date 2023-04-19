#!bin/bash

readonly quantity_files=5
readonly max_entrys=100
readonly min_entrys=10
readonly quantity_parametrs=0
readonly no_error=0

readonly array_response_codes=(200 201 400 401 403 404 500 501 502 503)

# 200 - OK
# 201 - CREATED
# 400 - BAD REQUEST
# 401 - UNAUTHORIZED
# 403 - FORBIDDEN
# 404 - NOT FOUND
# 500 - INTERNAL SERVER ERROR
# 501 - NOT IMPLEMENTED 
# 502 - BAD GATEWAY
# 503 - SERVICE UNAVAILABLE

readonly array_methods=(GET POST PUT PATCH DELETE)
readonly array_url=("/wiki" "/ya.ru" "/mozilla.org")
readonly array_protocols=("HTTP/1.0" "HTTP/1.1" "HTTP/2")
readonly array_agents=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")

readonly min_year=1970
readonly max_year=2023
readonly array_months=(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec) 

check_error=0
# 1 - неверное количество параметров при вызове скрипта

. ./check_parametrs.sh
. ./generate.sh

CheckQuantityParametrs $#

if [[ $check_error -eq $no_error ]]
then
    ip_address=
    identity_of_client="- -"
    
    date_year=
    date_month=
    date_day=

    http_request=

    response_code=
    response_byte=

    url_address_request="-"

    agent=

    for (( counter_files = 1; counter_files <= $quantity_files; counter_files++ ))
    do  
        GenerateDate
        log_name=$counter_files"_st.log"
        touch $log_name
        quantity_entrys=$(shuf -i $min_entrys-$max_entrys -n 1)
        for (( counter_entrys = 0; counter_entrys < $quantity_entrys; counter_entrys++ ))
        do
            GenetateIpAddress
            GenerateRequest
            GenerateCode
            GenerateBytes
            GenerateAgent
            echo "$ip_address $identity_of_client [ $date_day/$date_month/$date_year:$(date -d "$date + $seconds seconds"  +'%H:%M:%S %z') ] $http_request $response_code $response_byte $url_address_request $agent" >> $log_name
        done
    done
fi