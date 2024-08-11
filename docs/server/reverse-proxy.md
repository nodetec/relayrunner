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

Add a configuration file for your site in the `/etc/nginx/conf.d/` directory.

```bash
cd /etc/nginx/conf.d/
```

You can name the file whatever you'd like, but it should end with `.conf`. Here is an example configuration file for a relay:

```nginx title="relay.conf"
map $http_upgrade $connection_upgrade {
    default upgrade;
    '' close;
}

upstream websocket {
    server 127.0.0.1:8080;
}

server {
    listen 80;
    listen [::]:80;
    server_name relay.relayrunner.xyz; # replace with your domain

    location /.well-known/acme-challenge/ {
        root /var/www/relayrunner; # replace with your domain
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

Make sure to replace `relayrunner` with your domain name.

## Reload Nginx

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
