# SSL/TLS Certificate

SSL/TLS certificates are used to secure the connection between the client and the server. This is important for protecting sensitive information such as passwords and personal information. The certificates are used to encrypt the data that is sent between the client and the server. This ensures that the data cannot be intercepted by a third party.

By generating SSL/TLS certificates for our server, we'll be enabling the ability to use HTTPS on the server which we'll then configure for Nginx.

## Install Certbot

Certbot is a tool that can be used to automatically generate and renew SSL/TLS certificates.

To install Certbot on your server run:

```bash
apt install certbot python3-certbot-nginx
```

## Add acme-challenge Directory

To generate the SSL/TLS certificate, we need to create a directory to store the challenge files:

```bash
mkdir -p /var/www/relay.relayrunner.xyz/.well-known/acme-challenge
```

The `acme-challenge` directory will be used by Certbot to verify that you own the domain.

Be sure to replace the `relay.relayrunner.xyz` directory with your domain name that you're using for your relay.

## Generate SSL/TLS Certificate

Generate the SSL/TLS certificate using Certbot:

```bash
certbot certonly --webroot -w /var/www/relay.relayrunner.xyz -d relay.relayrunner.xyz
```

Be sure to replace `relay.relayrunner.xyz` with your domain name that you're using for your relay.

### Certbot Email

If this is your first time running Certbot on your server, you'll be prompted to provide an email address which is used to send warnings about upcoming certificate expirations as well as warnings about using a deprecated and possibly insecure setup.

If you don't want to provide an email, leave the input empty. It's possible to add an email to your Certbot account later if you decide you do want to receive the notifications.

If you do provide an email, you'll be asked if you want to share your email with the Electronic Frontier Foundation (EFF) to receive news, campaigns, ways to support digital freedom, etc. If you don't want to receive EFF emails, type `n` and press enter.

To add an email to your Certbot account and to update the email associated with your Certbot account run:

```bash
certbot update_account --email your-email@example.com
```

Be sure to replace `your-email@example.com` with the email address you want to use with your Certbot account.

## Configure Nginx

Replace the contents of `/etc/nginx/conf.d/relay_relayrunner_xyz.conf` with the following configuration where `relay_relayrunner_xyz.conf` should be replaced by whatever name you used for your Nginx config file:

```nginx title="relay_relayrunner_xyz.conf"
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name relay.relayrunner.xyz; # replace with your domain

    location / {
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

The SSL/TLS directives and the security headers specified above can be changed to meet the specific needs of your relay. The values chosen here place an emphasis on security and privacy. There are even more strict values that can be set especially for the `Permissions-Policy` and `Content-Security-Policy` headers depending on your requirements.

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
