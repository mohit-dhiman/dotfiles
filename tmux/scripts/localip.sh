#all_nics=$(/bin/cat /proc/net/dev | /usr/bin/awk '{if($2>0 && NR > 2) print substr($1, 0, index($1, ":") - 1)}' | /bin/sed '/^lo$/d')
all_nics=$(/bin/cat /proc/net/dev |/usr/bin/awk 'NR > 2' | sort -nrk2 | /usr/bin/awk '{if($2>0) print substr($1, 0, index($1, ":") - 1)}'|/bin/sed '/^lo$/d')
all_nics=(${all_nics[@]})
ips=()
for nic in "${all_nics[@]}"; do
    lan_ip="$(ip addr show ${nic} | grep '\<inet\>' | tr -s ' ' | cut -d ' ' -f3 | cut -d '/' -f1)"
    type=""
    case ${nic} in
        eth*) type=""
            ;;
        en*) type=""
            ;;
        wl*) type=""
            ;;
        tun*) type=""
            ;;

    esac
    [ -n "$lan_ip" ] && ips+=($type" "$lan_ip)
done
ipall=""
len="${#ips[@]}"
for (( i=0; i<$len; i++ )); do 
    ipall+=${ips[$i]}" "
    if [ "$((i+1))" != $len ]
    then
        ipall+=" "
    fi
    #echo ${ips[$i]}
done
echo $ipall
