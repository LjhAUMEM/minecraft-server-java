## 仓库中 bin 文件版本
- https://github.com/nezhahq/agent/releases/tag/v1.13.0
- https://github.com/cloudflare/cloudflared/releases/tag/2025.6.1
- https://github.com/XTLS/Xray-core/releases/tag/v25.6.8
- https://github.com/SagerNet/sing-box/releases/tag/v1.11.14
- 自签证书
```
openssl ecparam -genkey -name prime256v1 -out "key.pem"
openssl req -new -x509 -key "key.pem" \
    -out "cert.pem" \
    -days 36500 -subj "/CN=example.com"
```

## 编译
- 下载 JDK: https://www.oracle.com/java/technologies/downloads/
- 添加 jar 所在目录到 path
```
git clone https://github.com/LjhAUMEM/minecraft-server-java.git
cd minecraft-server-java
javac --release 18 Main.java
jar cfm server.jar MANIFEST.MF Main.class -C bin .
```

## 参考启动命令

```
java -Xms128M -Xmx256M -jar server.jar
```

## 部署方式一：base64 编码的 .env 文件
```
server=xxx
client_secret=xxx
token=xxx
vless_xhttp_domain=xxx
vmess_xhttp_domain=xxx
ws_domain=xxx
tuic_port=28075
```
经过编码后为
```
c2VydmVyPXh4eA0KY2xpZW50X3NlY3JldD14eHgNCnRva2VuPXh4eA0Kdmxlc3NfeGh0dHBfZG9tYWluPXh4eA0Kdm1lc3NfeGh0dHBfZG9tYWluPXh4eA0Kd3NfZG9tYWluPXh4eA0KdHVpY19wb3J0PTI4MDc1
```

## 部署方式二：修改内置变量直接编译

## 变量说明
```
final String[] input_name = {".env"}; // 读入文件
final String[] output_name = {".secrets"}; // 订阅输出文件
final String[] http_host = {"127.0.0.1"};
final String[] http_port = {"3000"};

// 自定义进程名称
final String[] nezha_name = {"n"};
final String[] cloudflared_name = {"c"};
final String[] xray_name = {"x"};
final String[] singbox_name = {"s"};

// 哪吒相关
final String[] server = {""};
final String[] client_secret = {""};
final String[] uuid = {""};
final String[] tls = {"true"};
final String[] insecure_tls = {"false"};
final String[] disable_auto_update = {"true"};

// 固定隧道 token
final String[] token = {""};

// 节点相关，使用隧道 domain 必填
final String[] vless_xhttp_port = {"3001"};
final String[] vless_xhttp_domain = {""};
final String[] vmess_xhttp_port = {"3002"};
final String[] vmess_xhttp_domain = {""};
final String[] ws_port = {"3003"};
final String[] ws_domain = {""};
final String[] vless_ws_port = {"3004"};
final String[] vmess_ws_port = {"3005"};
final String[] trojan_ws_port = {"3006"};
final String[] tcp_reality_port = {"3007"};
final String[] xhttp_reality_port = {"3008"};
final String[] hy2_port = {"3009"};
final String[] tuic_port = {"3010"};

// 需要固定密码才设置，否则每次重启将变化密码，需要重新订阅
final String[] xhttp_path = {""};
final String[] vless_ws_path = {""};
final String[] vmess_ws_path = {""};
final String[] trojan_ws_path = {""};
final String[] xray_uuid = {""};
final String[] reality_target = {""};
final String[] reality_private_key = {""};
final String[] reality_public_key = {""};
final String[] reality_sni = {""};
final String[] reality_short_id = {""};
final String[] hy2_pass = {""};
final String[] hy2_obfs = {""};
final String[] hy2_masquerade = {""};
final String[] hy2_sni = {""};
final String[] tuic_uuid = {""};
final String[] tuic_pass = {""};
final String[] tuic_sni = {""};
```