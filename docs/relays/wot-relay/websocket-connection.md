# WebSocket Connection

We're now going to set up the upstream WebSocket connection by editing the Nginx config file.

Replace the contents of `/etc/nginx/conf.d/relay_relayrunner_xyz.conf` with the following configuration where `relay_relayrunner_xyz.conf` should be replaced by whatever name you used for your WoT Relay Nginx config file:

```nginx title="relay_relayrunner_xyz.conf"
map $http_upgrade $connection_upgrade {
    default upgrade;
    '' close;
}

upstream wot_relay_websocket { # can replace with a unique upstream WebSocket name that you choose
    server localhost:3334;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name relay.relayrunner.xyz; # replace with your domain

    location / {
        proxy_pass http://wot_relay_websocket; # can replace with your unique upstream WebSocket name
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        try_files $uri $uri/ =404;
    }

    # Only return Nginx in server header
    server_tokens off;

    #### SSL Configuration ####
    # Test configuration:
    # https://www.ssllabs.com/ssltest/analyze.html
    # https://cryptcheck.fr/
    ssl_certificate /etc/letsencrypt/live/relay.relayrunner.xyz/fullchain.pem; # replace with your domain
    ssl_certificate_key /etc/letsencrypt/live/relay.relayrunner.xyz/privkey.pem; # replace with your domain
    # Verify chain of trust of OCSP response using Root CA and Intermediate certs
    ssl_trusted_certificate /etc/letsencrypt/live/relay.relayrunner.xyz/chain.pem; # replace with your domain

    ssl_protocols TLSv1.3 TLSv1.2;

    # For more information on the security of different cipher suites, you can refer to the following link:
    # https://ciphersuite.info/
    # Compilation of the top cipher suites 2024:
    # https://ssl-config.mozilla.org/#server=nginx
    ssl_ciphers "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305";

    # Perfect Forward Secrecy (PFS) is frequently compromised without this
    ssl_prefer_server_ciphers on;

    ssl_session_tickets off;

    # Enable SSL session caching for improved performance
    # Try setting ssl_session_timeout to 1d if performance is bad
    ssl_session_timeout 10m;
    ssl_session_cache shared:SSL:10m;

    # By default, the buffer size is 16k, which corresponds to minimal overhead when sending big responses.
    # To minimize Time To First Byte it may be beneficial to use smaller values
    ssl_buffer_size 8k;

    # OCSP stapling
    ssl_stapling on;
    ssl_stapling_verify on;

    #### Security Headers ####
    # Test configuration:
    # https://securityheaders.com/
    # https://observatory.mozilla.org/
    add_header Strict-Transport-Security "max-age=31536000; includeSubdomains; preload";

    add_header X-Frame-Options DENY;

    # Avoid MIME type sniffing
    add_header X-Content-Type-Options "nosniff" always;

    add_header Referrer-Policy "no-referrer" always;

    add_header X-XSS-Protection "1; mode=block" always;

    add_header Permissions-Policy "geolocation=(), midi=(), sync-xhr=(), microphone=(), camera=(), magnetometer=(), gyroscope=(), fullscreen=(self), payment=()" always;

    #### Content-Security-Policy (CSP) ####
    add_header Content-Security-Policy "base-uri 'self'; object-src 'none'; frame-ancestors 'none'; upgrade-insecure-requests;" always;
}

server {
    listen 80;
    listen [::]:80;
    server_name relay.relayrunner.xyz; # replace with your domain

    location /.well-known/acme-challenge/ {
        root /var/www/relay.relayrunner.xyz; # replace with the directory you used to store the challenge files in
        allow all;
    }

    location / {
        return 301 https://relay.relayrunner.xyz$request_uri; # replace with your domain
    }
}
```

Be sure to replace `relay.relayrunner.xyz` with your domain name and `/var/www/relay.relayrunner.xyz` with the directory you used to store the challenge files in.

You can also replace `wot_relay_websocket` with a unique upstream WebSocket name that you choose.

The proxy headers specified in the `location` block above, the SSL/TLS directives, and the security headers specified above can be changed to meet the specific needs of your relay. There are even more strict values that can be set especially for the `Permissions-Policy` and `Content-Security-Policy` headers depending on your requirements. Be sure to test any changes you make are compatible with the WoT Relay implementation.

## Test Nginx

Now you can test your Nginx configuration:

```bash
nginx -t
```

If this command fails, you most likely have a syntax error in your Nginx config file.

## Reload Nginx

After successfully testing your Nginx config file, you can reload Nginx to apply the changes:

```bash
systemctl reload nginx
```

## View Website

After setting up the upstream WebSocket connection, you can open up a browser and navigate to your relay's domain, e.g., `relay.relayrunner.xyz`.

This should show the WoT Relay HTML page specified in the environment file.
