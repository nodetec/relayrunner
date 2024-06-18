# Reverse Proxy

A reverse proxy is a server that sits between clients and the backend server(s) that they’re trying to access. It receives requests from clients and forwards them to the backend server(s). The response from the backend server(s) is then sent back to the client.

## Update your server

You should update your server to make sure you have the latest software. You can do this by running the following command:

```bash
apt update && apt upgrade -y
```

## Install Nginx

```bash
apt install nginx
```

## Configure Nginx

Add a configuration file for your site in the `/etc/nginx/conf.d/` directory. You can name the file whatever you'd like, but it should end with `.conf`. Here is an example configuration file for a relay:

```nginx
# relayrunner.xyz
server {
    listen 80;
    listen [::]:80;
    server_name relayrunner.xyz;

    location /.well-known/acme-challenge/ {
        root /var/www/relayrunner;
        allow all;
    }

    location / {
        root /var/www/relayrunner.xyz;
        index index.html;
    }
}

# www.relayrunner.xyz
server {
    listen 80;
    listen [::]:80;
    server_name www.relayrunner.xyz;

    return 301 http://relayrunner.xyz$request_uri;
}

map $http_upgrade $connection_upgrade {
    default upgrade;
    '' close;
}

upstream websocket {
    server 127.0.0.1:8080;
}

# relay.relayrunner.xyz
server {
    listen 80;
    listen [::]:80;
    server_name relay.relayrunner.xyz;

    location /.well-known/acme-challenge/ {
        root /var/www/relayrunner;
        allow all;
    }

    location / {
        proxy_pass http://websocket;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $remote_addr;
    }
}
```

Make sure to replace `relayrunner.xyz` with your domain name.

Create the directory for your relay homepage:

```bash
mkdir /var/www/relayrunner.xyz
```

Create an `index.html` file in the directory and add whatever information you'd like to include about your relay, here is an example:

```html
<!doctype html>
<html>
  <head>
    <title>Relay Runner</title>
  </head>
  <body>
    <h1>Welcome to Relay Runner</h1>
    <p>This is a personal relay for my notes and other stuff.</p>
  </body>
</html>
```

now test your config and restart Nginx to apply the changes:

```bash
nginx -t # if this command fails, you have a syntax error in your config

systemctl restart nginx
```

## Nginx Resources

- [Nginx Documentation](https://docs.nginx.com/)
- [Nginx Configuration](https://nginx.org/en/docs/beginners_guide.html)
- [Nginx Directory Structure](https://wiki.debian.org/Nginx/DirectoryStructure)
- [Nginx Configuration Generator](https://www.digitalocean.com/community/tools/nginx)
