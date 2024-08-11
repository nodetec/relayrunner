# SSL/TLS Certificate

SSL/TLS certificates are used to secure the connection between the client and the server. This is important for protecting sensitive information such as passwords and personal information. The certificates are used to encrypt the data that is sent between the client and the server. This ensures that the data cannot be intercepted by a third party.

## Install Certbot

Certbot is a tool that can be used to automatically generate and renew SSL/TLS certificates.

```bash
apt install certbot python3-certbot-nginx
```

## Add acme-challenge directory
 
To generate the SSL/TLS certificate, we need to create a directory to store the challenge files. This directory will be used by Certbot to verify that you own the domain. Replace this directory name with your domain name.

```bash
mkdir -p /var/www/relayrunner # replace with your domain

mkdir -p /var/www/relayrunner/.well-known/acme-challenge/ # replace with your domain
```

## Generate SSL/TLS Certificate

Generate the SSL/TLS certificate using Certbot. Replace `relayrunner.xyz` with your domain name.

```bash
certbot certonly --webroot -w /var/www/relayrunner -d relay.relayrunner.xyz # replace with your domain
```

## Configure Nginx

Replace the contents of `/etc/nginx/conf.d/relay.conf` with the following configuration:

```nginx title="relay.conf"
map $http_upgrade $connection_upgrade {
    default upgrade;
    '' close;
}

upstream websocket {
    server 127.0.0.1:8080;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name relay.relayrunner.xyz; # replace with your domain

    location / {
        proxy_pass http://websocket;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $remote_addr;
    }

    #### SSL Configuration ####
    ssl_certificate /etc/letsencrypt/live/relayrunner.xyz/fullchain.pem; # replace with your domain
    ssl_certificate_key /etc/letsencrypt/live/relayrunner.xyz/privkey.pem; # replace with your domain

    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;
    ssl_protocols TLSv1.2 TLSv1.1 TLSv1;
    ssl_prefer_server_ciphers on;
    ssl_ciphers "EECDH+ECDSA+AESGCM EECDH+aRSA+AESGCM EECDH+ECDSA+SHA384 EECDH+ECDSA+SHA256 EECDH+aRSA+SHA384 EECDH+aRSA+SHA256 EECDH+aRSA+RC4 EECDH EDH+aRSA RC4 !aNULL !eNULL !LOW !3DES !MD5 !EXP !PSK !SRP !DSS";
    ssl_stapling on;
    ssl_stapling_verify on;
    ssl_ecdh_curve secp384r1;

    add_header Strict-Transport-Security "max-age=31536000; includeSubdomains";
    add_header X-Frame-Options DENY;
    add_header X-Content-Type-Options nosniff;
    add_header X-XSS-Protection "1; mode=block";
    add_header Referrer-Policy same-origin;
    add_header Feature-Policy "geolocation none;midi none;notifications none;push none;sync-xhr none;microphone none;camera none;magnetometer none;gyroscope none;speaker self;vibrate none;fullscreen self;payment none;";
}
```

## Reload Nginx

First, test the configuration to make sure there are no syntax errors:

```bash
nginx -t
```

If that went well, reload Nginx to apply the changes:

```bash
systemctl reload nginx
```