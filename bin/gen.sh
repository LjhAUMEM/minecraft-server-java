#!/bin/bash

xray_path=${1:-""}
singbox_path=${2:-""}
cert_path=${3:-""}
key_path=${4:-""}
output_name=${5:-".secrets"}
ip=${6:-"127.0.0.1"}

vless_xhttp_port=${7:-"3001"}
vless_xhttp_domain=${8:-""}
vmess_xhttp_port=${9:-"3002"}
vmess_xhttp_domain=${10:-""}
ws_port=${11:-"3003"}
ws_domain=${12:-""}
vless_ws_port=${13:-"3004"}
vmess_ws_port=${14:-"3005"}
trojan_ws_port=${15:-"3006"}
tcp_reality_port=${16:-"3007"}
xhttp_reality_port=${17:-"3008"}
hy2_port=${18:-"3009"}
tuic_port=${19:-"3010"}

xhttp_path=${20:-""}
vless_ws_path=${21:-""}
vmess_ws_path=${22:-""}
trojan_ws_path=${23:-""}
xray_uuid=${24:-""}
reality_target=${25:-"www.microsoft.com:443"}
reality_private_key=${26:-""}
reality_public_key=${27:-""}
reality_sni=${28:-"www.microsoft.com"}
reality_short_id=${29:-""}
hy2_pass=${30:-""}
hy2_obfs=${31:-""}
hy2_masquerade=${32:-"https://www.microsoft.com"}
hy2_sni=${33:-"example.com"}
tuic_uuid=${34:-""}
tuic_pass=${35:-""}
tuic_sni=${36:-"example.com"}

echo "xray_path: $xray_path"
echo "singbox_path: $singbox_path"
echo "cert_path: $cert_path"
echo "key_path: $key_path"
echo "output_name: $output_name"
echo "ip: $ip"

echo "vless_xhttp_port: $vless_xhttp_port"
echo "vless_xhttp_domain: $vless_xhttp_domain"
echo "vmess_xhttp_port: $vmess_xhttp_port"
echo "vmess_xhttp_domain: $vmess_xhttp_domain"
echo "ws_port: $ws_port"
echo "ws_domain: $ws_domain"
echo "vless_ws_port: $vless_ws_port"
echo "vmess_ws_port: $vmess_ws_port"
echo "trojan_ws_port: $trojan_ws_port"
echo "tcp_reality_port: $tcp_reality_port"
echo "xhttp_reality_port: $xhttp_reality_port"
echo "hy2_port: $hy2_port"
echo "tuic_port: $tuic_port"

echo "xhttp_path: $xhttp_path"
echo "vless_ws_path: $vless_ws_path"
echo "vmess_ws_path: $vmess_ws_path"
echo "trojan_ws_path: $trojan_ws_path"
echo "xray_uuid: $xray_uuid"
echo "reality_target: $reality_target"
echo "reality_private_key: $reality_private_key"
echo "reality_public_key: $reality_public_key"
echo "reality_sni: $reality_sni"
echo "reality_short_id: $reality_short_id"
echo "hy2_pass: $hy2_pass"
echo "hy2_obfs: $hy2_obfs"
echo "hy2_masquerade: $hy2_masquerade"
echo "hy2_sni: $hy2_sni"
echo "tuic_uuid: $tuic_uuid"
echo "tuic_pass: $tuic_pass"
echo "tuic_sni: $tuic_sni"

xray() {
    if [ "$xhttp_path" = "" ]; then
        xhttp_path=$($xray_path uuid)
        xhttp_path=${xhttp_path:0:8}
    fi
    if [ "$vless_ws_path" = "" ]; then
        vless_ws_path=$($xray_path uuid)
        vless_ws_path=${vless_ws_path:0:8}
    fi
    if [ "$vmess_ws_path" = "" ]; then
        vmess_ws_path=$($xray_path uuid)
        vmess_ws_path=${vmess_ws_path:0:8}
    fi
    if [ "$trojan_ws_path" = "" ]; then
        trojan_ws_path=$($xray_path uuid)
        trojan_ws_path=${trojan_ws_path:0:8}
    fi
    if [ "$xray_uuid" = "" ]; then
        xray_uuid=$($xray_path uuid)
    fi
    if [ "$reality_private_key" = "" ]; then
        reality_keypair=$($xray_path x25519)
        # reality_private_key=$(echo "$reality_keypair" | grep -oP 'Private key: \K\S+')
        # reality_public_key=$(echo "$reality_keypair" | grep -oP 'Public key: \K\S+')
        reality_private_key=$(echo "$reality_keypair" | awk '/Private key:/ {print $3}')
        reality_public_key=$(echo "$reality_keypair" | awk '/Public key:/ {print $3}')
    fi
    if [ "$reality_short_id" = "" ]; then
        reality_short_id=$($xray_path uuid)
        reality_short_id=${reality_short_id:0:8}
    fi

    if [ "${vless_ws_path:0:1}" != "/" ]; then
        vless_ws_path="/$vless_ws_path"
    fi
    if [ "${vmess_ws_path:0:1}" != "/" ]; then
        vmess_ws_path="/$vmess_ws_path"
    fi
    if [ "${trojan_ws_path:0:1}" != "/" ]; then
        trojan_ws_path="/$trojan_ws_path"
    fi

    echo "{
    \"log\": {
        \"loglevel\": \"none\"
    },
    \"outbounds\": [
        {
            \"protocol\": \"freedom\"
        }
    ],
    \"inbounds\": [
        {
            \"listen\": \"::\",
            \"port\": $vless_xhttp_port,
            \"protocol\": \"vless\",
            \"settings\": {
                \"clients\": [
                    {
                        \"id\": \"$xray_uuid\"
                    }
                ],
                \"decryption\": \"none\"
            },
            \"streamSettings\": {
                \"network\": \"xhttp\",
                \"xhttpSettings\": {
                    \"path\": \"$xhttp_path\"
                }
            }
        },
        {
            \"listen\": \"::\",
            \"port\": $vmess_xhttp_port,
            \"protocol\": \"vmess\",
            \"settings\": {
                \"clients\": [
                    {
                        \"id\": \"$xray_uuid\"
                    }
                ]
            },
            \"streamSettings\": {
                \"network\": \"xhttp\",
                \"xhttpSettings\": {
                    \"path\": \"$xhttp_path\"
                }
            }
        },
        {
            \"listen\": \"::\",
            \"port\": $ws_port,
            \"protocol\": \"vless\",
            \"settings\": {
                \"clients\": [
                    {
                        \"id\": \"$xray_uuid\"
                    }
                ],
                \"decryption\": \"none\",
                \"fallbacks\": [
                    {
                        \"dest\": $vless_ws_port,
                        \"path\": \"$vless_ws_path\",
                        \"xver\": 1
                    },
                    {
                        \"dest\": $vmess_ws_port,
                        \"path\": \"$vmess_ws_path\",
                        \"xver\": 1
                    },
                    {
                        \"dest\": $trojan_ws_port,
                        \"path\": \"$trojan_ws_path\",
                        \"xver\": 1
                    }
                ]
            },
            \"streamSettings\": {
                \"network\": \"raw\"
            }
        },
        {
            \"listen\": \"::\",
            \"port\": $vless_ws_port,
            \"protocol\": \"vless\",
            \"settings\": {
                \"clients\": [
                    {
                        \"id\": \"$xray_uuid\"
                    }
                ],
                \"decryption\": \"none\"
            },
            \"streamSettings\": {
                \"network\": \"ws\",
                \"wsSettings\": {
                    \"path\": \"$vless_ws_path\",
                    \"acceptProxyProtocol\": true
                }
            }
        },
        {
            \"listen\": \"::\",
            \"port\": $vmess_ws_port,
            \"protocol\": \"vmess\",
            \"settings\": {
                \"clients\": [
                    {
                        \"id\": \"$xray_uuid\"
                    }
                ]
            },
            \"streamSettings\": {
                \"network\": \"ws\",
                \"wsSettings\": {
                    \"path\": \"$vmess_ws_path\",
                    \"acceptProxyProtocol\": true
                }
            }
        },
        {
            \"listen\": \"::\",
            \"port\": $trojan_ws_port,
            \"protocol\": \"trojan\",
            \"settings\": {
                \"clients\": [
                    {
                        \"password\": \"$xray_uuid\"
                    }
                ]
            },
            \"streamSettings\": {
                \"network\": \"ws\",
                \"wsSettings\": {
                    \"path\": \"$trojan_ws_path\",
                    \"acceptProxyProtocol\": true
                }
            }
        },
        {
            \"listen\": \"::\",
            \"port\": $tcp_reality_port,
            \"protocol\": \"vless\",
            \"settings\": {
                \"clients\": [
                    {
                        \"id\": \"$xray_uuid\"
                    }
                ],
                \"decryption\": \"none\"
            },
            \"streamSettings\": {
                \"network\": \"raw\",
                \"security\": \"reality\",
                \"realitySettings\": {
                    \"target\": \"$reality_target\",
                    \"serverNames\": [\"$reality_sni\"],
                    \"privateKey\": \"$reality_private_key\",
                    \"shortIds\": [\"$reality_short_id\"]
                }
            }
        },
        {
            \"listen\": \"::\",
            \"port\": $xhttp_reality_port,
            \"protocol\": \"vless\",
            \"settings\": {
                \"clients\": [
                    {
                        \"id\": \"$xray_uuid\"
                    }
                ],
                \"decryption\": \"none\"
            },
            \"streamSettings\": {
                \"network\": \"xhttp\",
                \"xhttpSettings\": {
                    \"path\": \"$xhttp_path\"
                },
                \"security\": \"reality\",
                \"realitySettings\": {
                    \"target\": \"$reality_target\",
                    \"serverNames\": [\"$reality_sni\"],
                    \"privateKey\": \"$reality_private_key\",
                    \"shortIds\": [\"$reality_short_id\"]
                }
            }
        }
    ]
}" > config.json
    nohup $xray_path &>/dev/null &
    sleep 1
    rm config.json
}

singbox() {
    if [ "$hy2_pass" = "" ]; then
        hy2_pass=$($singbox_path generate uuid)
        hy2_pass=${hy2_pass:0:8}
    fi
    if [ "$hy2_obfs" = "" ]; then
        hy2_obfs=$($singbox_path generate uuid)
        hy2_obfs=${hy2_obfs:0:8}
    fi
    if [ "$tuic_uuid" = "" ]; then
        tuic_uuid=$($singbox_path generate uuid)
    fi
    if [ "$tuic_pass" = "" ]; then
        tuic_pass=$($singbox_path generate uuid)
        tuic_pass=${tuic_pass:0:8}
    fi
    echo "{
    \"log\": {
        \"disabled\": true,
        \"level\": \"info\",
        \"timestamp\": true
    },
    \"inbounds\": [
        {
            \"type\": \"hysteria2\",
            \"listen\": \"::\",
            \"listen_port\": $hy2_port,
            \"obfs\": {
                \"type\": \"salamander\",
                \"password\": \"$hy2_obfs\"
            },
            \"users\": [
                {
                    \"password\": \"$hy2_pass\"
                }
            ],
            \"ignore_client_bandwidth\": true,
            \"tls\": {
                \"enabled\": true,
                \"certificate_path\": \"$cert_path\",
                \"key_path\": \"$key_path\"
            },
            \"masquerade\": \"$hy2_masquerade\"
        },
        {
            \"type\": \"tuic\",
            \"listen\": \"::\",
            \"listen_port\": $tuic_port,
            \"users\": [
                {
                    \"uuid\": \"$tuic_uuid\",
                    \"password\": \"$tuic_pass\"
                }
            ],
            \"congestion_control\": \"bbr\",
            \"tls\": {
                \"enabled\": true,
                \"alpn\": [\"h3\"],
                \"certificate_path\": \"$cert_path\",
                \"key_path\": \"$key_path\"
            }
        }
    ]
}" > config.json
    nohup $singbox_path run &>/dev/null &
    sleep 1
    rm config.json
}

xray
singbox

ip=$(echo "$ip" | head -n 1)
ip_warpper="$ip"
if [[ "$ip_warpper" == *:* ]]; then
    ip_warpper="[$ip_warpper]"
fi

vless_xhttp_link="vless://${xray_uuid}@ip.sb:443?encryption=none&security=tls&type=xhttp&host=${vless_xhttp_domain}&path=${xhttp_path}&mode=packet-up#$ip vless xhttp"
vmess_xhttp_config="{
  \"v\": \"2\",
  \"ps\": \"$ip vmess xhttp\",
  \"add\": \"ip.sb\",
  \"port\": \"80\",
  \"id\": \"$xray_uuid\",
  \"aid\": \"0\",
  \"scy\": \"auto\",
  \"net\": \"xhttp\",
  \"type\": \"packet-up\",
  \"host\": \"$vmess_xhttp_domain\",
  \"path\": \"$xhttp_path\",
  \"tls\": \"\",
  \"sni\": \"\",
  \"alpn\": \"\",
  \"fp\": \"\"
}"
vmess_xhttp_link="vmess://$(echo -n "$vmess_xhttp_config" | base64 -w 0)"
vless_ws_link="vless://${xray_uuid}@ip.sb:443?encryption=none&security=tls&type=ws&host=${ws_domain}&path=${vless_ws_path}#$ip vless ws"
vmess_ws_config="{
  \"v\": \"2\",
  \"ps\": \"$ip vmess ws\",
  \"add\": \"ip.sb\",
  \"port\": \"80\",
  \"id\": \"$xray_uuid\",
  \"aid\": \"0\",
  \"scy\": \"auto\",
  \"net\": \"ws\",
  \"type\": \"none\",
  \"host\": \"$ws_domain\",
  \"path\": \"$vmess_ws_path\",
  \"tls\": \"\",
  \"sni\": \"\",
  \"alpn\": \"\",
  \"fp\": \"\"
}"
vmess_ws_link="vmess://$(echo -n "$vmess_ws_config" | base64 -w 0)"
trojan_ws_link="trojan://${xray_uuid}@ip.sb:443?security=tls&type=ws&host=${ws_domain}&path=${trojan_ws_path}#$ip trojan ws"
vless_tcp_reality_link="vless://${xray_uuid}@${ip_warpper}:${tcp_reality_port}?encryption=none&security=reality&sni=${reality_sni}&fp=chrome&pbk=${reality_public_key}&sid=${reality_short_id}&type=tcp&headerType=none#$ip vless tcp reality"
vless_xhttp_reality_link="vless://${xray_uuid}@${ip_warpper}:${xhttp_reality_port}?encryption=none&security=reality&sni=${reality_sni}&fp=chrome&pbk=${reality_public_key}&sid=${reality_short_id}&type=xhttp&path=${xhttp_path}&mode=auto#$ip vless tcp reality"
hy2_link="hysteria2://${hy2_pass}@${ip_warpper}:${hy2_port}?sni=${hy2_sni}&obfs=salamander&obfs-password=${hy2_obfs}&insecure=1#$ip hysteria2 bbr"
tuic_link="tuic://${tuic_uuid}%3A${tuic_pass}@${ip_warpper}:${tuic_port}?sni=${tuic_sni}&alpn=h3&congestion_control=bbr&allowInsecure=1#$ip tuic bbr"

echo "${vless_xhttp_link}
${vmess_xhttp_link}
${vless_ws_link}
${vmess_ws_link}
${trojan_ws_link}
${vless_tcp_reality_link}
${vless_xhttp_reality_link}
${hy2_link}
${tuic_link}" | base64 -w 0 > "$output_name"

for pid_path in /proc/[0-9]*/; do
  if [ -r "${pid_path}cmdline" ]; then
    pid="${pid_path//[^0-9]/}"
    echo -n "${pid}: "
    xargs -0 < "${pid_path}cmdline"
    echo
  fi
done