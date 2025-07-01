public class Main {
    public static java.nio.file.Path extract(String original, String name, String suffix, boolean exec) throws Exception {
        java.io.InputStream in = Main.class.getResourceAsStream("/" + original);

        // java.nio.file.Path file = java.nio.file.Files.createTempFile(name, suffix);
        // file.toFile().deleteOnExit();

        java.nio.file.Path tmp = java.nio.file.Paths.get(System.getProperty("java.io.tmpdir"));
        java.nio.file.Path file = tmp.resolve(suffix == null ? name : name + "." + suffix);
        java.nio.file.Files.createFile(file);
        file.toFile().deleteOnExit();

        java.nio.file.Files.copy(in, file, java.nio.file.StandardCopyOption.REPLACE_EXISTING);
        if (exec) {
            file.toFile().setExecutable(true);
        }
        // System.out.println(file.toString());
        return file;
    }
    public static void main(String[] args) throws Exception {
        System.setProperty("java.net.preferIPv4Stack", "true");

        final String[] input_name = {".env"};
        final String[] output_name = {".secrets"};
        final String[] http_host = {"127.0.0.1"};
        final String[] http_port = {"3000"};

        final String[] nezha_name = {"n"};
        final String[] cloudflared_name = {"c"};
        final String[] xray_name = {"x"};
        final String[] singbox_name = {"s"};

        final String[] server = {""};
        final String[] client_secret = {""};
        final String[] uuid = {""};
        final String[] tls = {"true"};
        final String[] insecure_tls = {"false"};
        final String[] disable_auto_update = {"true"};

        final String[] token = {""};

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

        java.nio.file.Path envPath = java.nio.file.Paths.get(input_name[0]);
        if (java.nio.file.Files.exists(envPath)) {
            // java.util.List<String> lines = java.nio.file.Files.readAllLines(envPath);
            byte[] encoded = java.nio.file.Files.readAllBytes(envPath);
            String decodedEnv = new String(java.util.Base64.getDecoder().decode(encoded), java.nio.charset.StandardCharsets.UTF_8);
            java.util.List<String> lines = java.util.Arrays.asList(decodedEnv.split("\\R"));
            for (String line : lines) {
                line = line.trim();
                if (line.isEmpty() || line.startsWith("#")) continue;
                int idx = line.indexOf('=');
                if (idx == -1) {
                    idx = line.indexOf(' ');
                }
                if (idx == -1) continue;
                String key = line.substring(0, idx).trim();
                String value = line.substring(idx + 1).trim();
                switch (key) {
                    case "output_name": output_name[0] = value; break;
                    case "http_host": http_host[0] = value; break;
                    case "http_port": http_port[0] = value; break;
                    case "nezha_name": nezha_name[0] = value; break;
                    case "cloudflared_name": cloudflared_name[0] = value; break;
                    case "xray_name": xray_name[0] = value; break;
                    case "singbox_name": singbox_name[0] = value; break;
                    case "server": server[0] = value; break;
                    case "client_secret": client_secret[0] = value; break;
                    case "uuid": uuid[0] = value; break;
                    case "tls": tls[0] = value; break;
                    case "insecure_tls": insecure_tls[0] = value; break;
                    case "disable_auto_update": disable_auto_update[0] = value; break;
                    case "token": token[0] = value; break;
                    case "vless_xhttp_port": vless_xhttp_port[0] = value; break;
                    case "vless_xhttp_domain": vless_xhttp_domain[0] = value; break;
                    case "vmess_xhttp_port": vmess_xhttp_port[0] = value; break;
                    case "vmess_xhttp_domain": vmess_xhttp_domain[0] = value; break;
                    case "ws_port": ws_port[0] = value; break;
                    case "ws_domain": ws_domain[0] = value; break;
                    case "vless_ws_port": vless_ws_port[0] = value; break;
                    case "vmess_ws_port": vmess_ws_port[0] = value; break;
                    case "trojan_ws_port": trojan_ws_port[0] = value; break;
                    case "tcp_reality_port": tcp_reality_port[0] = value; break;
                    case "xhttp_reality_port": xhttp_reality_port[0] = value; break;
                    case "hy2_port": hy2_port[0] = value; break;
                    case "tuic_port": tuic_port[0] = value; break;
                    case "xhttp_path": xhttp_path[0] = value; break;
                    case "vless_ws_path": vless_ws_path[0] = value; break;
                    case "vmess_ws_path": vmess_ws_path[0] = value; break;
                    case "trojan_ws_path": trojan_ws_path[0] = value; break;
                    case "xray_uuid": xray_uuid[0] = value; break;
                    case "reality_target": reality_target[0] = value; break;
                    case "reality_private_key": reality_private_key[0] = value; break;
                    case "reality_public_key": reality_public_key[0] = value; break;
                    case "reality_sni": reality_sni[0] = value; break;
                    case "reality_short_id": reality_short_id[0] = value; break;
                    case "hy2_pass": hy2_pass[0] = value; break;
                    case "hy2_obfs": hy2_obfs[0] = value; break;
                    case "hy2_masquerade": hy2_masquerade[0] = value; break;
                    case "hy2_sni": hy2_sni[0] = value; break;
                    case "tuic_uuid": tuic_uuid[0] = value; break;
                    case "tuic_pass": tuic_pass[0] = value; break;
                    case "tuic_sni": tuic_sni[0] = value; break;
                }
            }
        }

        java.nio.file.Path file_nezha = extract("nezha-agent", nezha_name[0], null, true);
        java.nio.file.Path file_cloudflared = extract("cloudflared-linux-amd64", cloudflared_name[0], null, true);
        java.nio.file.Path file_xray = extract("xray", xray_name[0], null, true);
        java.nio.file.Path file_singbox = extract("sing-box", singbox_name[0], null, true);

        java.nio.file.Path file_gen = extract("gen.sh", "prerun", null, true);
        java.nio.file.Path file_cert = extract("cert.pem", "cert", null, true);
        java.nio.file.Path file_key = extract("key.pem", "key", null, true);

        if (!server[0].equals("")) {
            new Thread(() -> {
                try {
                    String content = "server: " + server[0] + "\n" +
                                     "client_secret: " + client_secret[0] + "\n" +
                                     "uuid: " + uuid[0] + "\n" +
                                     "tls: " + tls[0] + "\n" +
                                     "insecure_tls: " + insecure_tls[0] + "\n" +
                                     "disable_auto_update: " + disable_auto_update[0] + "\n";
                    java.nio.file.Files.write(java.nio.file.Paths.get(System.getProperty("java.io.tmpdir")).resolve("config.yml"), content.getBytes(java.nio.charset.StandardCharsets.UTF_8));
                    new ProcessBuilder(file_nezha.toString())
                        .redirectOutput(new java.io.File("/dev/null"))
                        .redirectError(new java.io.File("/dev/null"))
                        .start();
                    Thread.sleep(1000);
                    java.nio.file.Files.deleteIfExists(java.nio.file.Paths.get(System.getProperty("java.io.tmpdir")).resolve("config.yml"));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }).start();
        }

        if (!token[0].equals("")) {
            new Thread(() -> {
                try {
                    new ProcessBuilder(file_cloudflared.toString(), "tunnel", "run", "--token", token[0])
                        .redirectOutput(new java.io.File("/dev/null"))
                        .redirectError(new java.io.File("/dev/null"))
                        .start();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }).start();
        }

        new Thread(() -> {
            try {
                String ip;
                try {
                    java.net.http.HttpClient client = java.net.http.HttpClient.newHttpClient();
                    java.net.http.HttpRequest request = java.net.http.HttpRequest.newBuilder()
                            .uri(new java.net.URI("http://ip.sb"))
                            .header("User-Agent", "curl/7.79.1")
                            .GET()
                            .build();
                    java.net.http.HttpResponse<String> response = client.send(request, java.net.http.HttpResponse.BodyHandlers.ofString());
                    ip = response.body();
                } catch (Exception e) {
                    e.printStackTrace();
                    ip = "127.0.0.1";
                }
                new ProcessBuilder(file_gen.toString(), file_xray.toString(), file_singbox.toString(), file_cert.toString(), file_key.toString(), output_name[0], ip,
                    vless_xhttp_port[0], vless_xhttp_domain[0], vmess_xhttp_port[0], vmess_xhttp_domain[0], ws_port[0], ws_domain[0], vless_ws_port[0], vmess_ws_port[0], trojan_ws_port[0], tcp_reality_port[0], xhttp_reality_port[0], hy2_port[0], tuic_port[0],
                    xhttp_path[0], vless_ws_path[0], vmess_ws_path[0], trojan_ws_path[0], xray_uuid[0], reality_target[0], reality_private_key[0], reality_public_key[0], reality_sni[0], reality_short_id[0], hy2_pass[0], hy2_obfs[0], hy2_masquerade[0], hy2_sni[0], tuic_uuid[0], tuic_pass[0], tuic_sni[0])
                    .inheritIO().start().waitFor();
                java.nio.file.Files.deleteIfExists(file_gen);
                java.nio.file.Files.deleteIfExists(file_cert);
                java.nio.file.Files.deleteIfExists(file_key);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }).start();

        com.sun.net.httpserver.HttpServer http_server = com.sun.net.httpserver.HttpServer.create(new java.net.InetSocketAddress(http_host[0], Integer.parseInt(http_port[0])), 0);
        http_server.createContext("/", exchange -> {
            try {
                if ("GET".equals(exchange.getRequestMethod())) {
                    byte[] content = java.nio.file.Files.readAllBytes(java.nio.file.Paths.get(output_name[0]));
                    exchange.sendResponseHeaders(200, content.length);
                    java.io.OutputStream os = exchange.getResponseBody();
                    os.write(content);
                    os.close();
                } else {
                    exchange.sendResponseHeaders(405, -1);
                }
            } catch (Exception e) {
                try {
                    String msg = e.getMessage();
                    exchange.sendResponseHeaders(500, msg.length());
                    java.io.OutputStream os = exchange.getResponseBody();
                    os.write(msg.getBytes());
                    os.close();
                } catch (Exception ignored) {}
            }
        });
        http_server.setExecutor(null);
        http_server.start();

        // new ProcessBuilder("sh", "-c", "tail -f /dev/null").inheritIO().start().waitFor();

        while (true) { Thread.sleep(1000); }
    }
}