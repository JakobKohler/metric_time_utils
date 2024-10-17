t=0
sleep_pid=0

getPrintVal() {
    local val=$1
    if [ $val -lt 10 ]; then
        printf "0%d" $val
    else
        printf "%d" $val
    fi
}

printDecimalTime() {
    timezoneOffsetInMilliSeconds=$(( $(date +%z | sed 's/^..//;s/..$//') * 3600 * 1000 ))
    currentUnixMilliSeconds=$(( $(date +%s%3N) + timezoneOffsetInMilliSeconds ))

    milliSecondsToday=$(( currentUnixMilliSeconds % 86400000 ))

    decimalTime=$(echo "scale=10; $milliSecondsToday / 86400000 * 10" | bc)
    decimalHours=$(echo "$decimalTime / 1" | bc)
    decimalMinutes=$(echo "($decimalTime - $decimalHours) * 100 / 1" | bc)
    
    echo "$(getPrintVal $decimalHours)":"$(getPrintVal $decimalMinutes)"
}

toggle() {
    t=$(((t + 1) % 2))

    if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
    fi
}


trap "toggle" USR1

while true; do
    if [ $t -eq 0 ]; then
        date +"%H:%M"
    else
        printDecimalTime
    fi
    sleep 1 &
    sleep_pid=$!
    wait
done