# Reverse Proxy

A reverse proxy is a server that sits between clients and the backend server(s) that the clients are trying to access. It receives requests from clients and forwards them to the backend server(s). The response from the backend server(s) is then sent back to the client.

We'll be setting up an HTTP server with an upstream backend WebSocket server.

Since the server only uses HTTP, the communication between the client and the server isn't encrypted. We'll be going over how to set up an SSL/TLS certificate in the next section to enable HTTPS which will encrypt the communication between the client and the server.

## Install Nginx

Install Nginx by running:

```bash
apt install nginx
```

## Configure Nginx

You now need to add an Nginx config file for your site in the `/etc/nginx/conf.d` directory.

First, navigate to the `/etc/nginx/conf.d` directory by running:

```bash
cd /etc/nginx/conf.d
```

You can name the file whatever you'd like, but it should end with `.conf`.

We'll be naming the file using the `relay` subdomain we previously set up in [Namecheap](https://www.namecheap.com "Namecheap"), i.e., `relay.relayrunner.xyz`.

To create the file run:

```bash
touch relay_relayrunner_xyz.conf
```

Be sure to replace `relay_relayrunner_xyz.conf` with your Nginx config file name.

Here's an example config file for `relay_relayrunner_xyz.conf`:

```nginx title="relay_relayrunner_xyz.conf"
server {
    listen 80;
    listen [::]:80;
    server_name relay.relayrunner.xyz; # replace with your domain

    location /.well-known/acme-challenge/ {
        root /var/www/relay.relayrunner.xyz; # replace with your domain
        allow all;
    }

    location / {
        try_files $uri $uri/ =404;
    }

    # Only return Nginx in server header
    server_tokens off;

    #### Security Headers ####
    # Test configuration:
    # https://securityheaders.com/
    # https://observatory.mozilla.org/
    add_header X-Frame-Options DENY;

    # Avoid MIME type sniffing
    add_header X-Content-Type-Options "nosniff" always;

    add_header Referrer-Policy "no-referrer" always;

    add_header X-XSS-Protection "1; mode=block" always;

    add_header Permissions-Policy "geolocation=(), midi=(), sync-xhr=(), microphone=(), camera=(), magnetometer=(), gyroscope=(), fullscreen=(self), payment=()" always;

    #### Content-Security-Policy (CSP) ####
    add_header Content-Security-Policy "base-uri 'self'; object-src 'none'; frame-ancestors 'none';" always;
}
```

Be sure to replace `relay.relayrunner.xyz` with your domain name.

The security headers specified above can be changed to meet the specific needs of your relay. The values chosen here place an emphasis on security and privacy, but there are even more strict values that can be set depending on your use case.

If you want to properly secure your server, be sure to set up an SSL/TLS certificate in the next section.

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
