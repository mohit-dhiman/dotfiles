all_nics=$(ifconfig | pcregrep -M -o '^[^\t:]+(?=:([^\n]|\n\t)*status: active)')
all_nics=(${all_nics[@]})
ips=()
for nic in "${all_nics[@]}"; do
    lan_ip="$(ip addr show ${nic} | grep '\<inet\>' | cut -d ' ' -f2 | cut -d '/' -f1)"
    type=""
    case ${nic} in
        eth*) type=""
            ;;
        en*) type=""
            ;;
        wl*) type=""
            ;;
        tun*) type=""
            ;;
        pp*) type=""
            ;;

    esac
    [ -n "$lan_ip" ] && ips+=($type" "$lan_ip)
done
ipall=""
len="${#ips[@]}"
if [ $len -lt 1 ]
then
    ipall=""    
fi
for (( i=0; i<$len; i++ )); do 
    ipall+=${ips[$i]}" "
    if [ "$((i+1))" != $len ]
    then
        ipall+=" "
    fi
    #echo ${ips[$i]}
done
#ip addr show en0 | grep '\<inet\>' | cut -d ' ' -f2 | cut -d '/' -f1
echo $ipall
