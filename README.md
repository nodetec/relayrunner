# Relay Runner

## Deploy this site to Fly.io

Make and account and setup billing on [Fly.io](https://fly.io)

Install the flyctl CLI tool

```bash
brew install flyctl
```

## Dockerfile

Create a `Dockerfile`

```bash
touch Dockerfile
```

Add the following to the `Dockerfile`

```Dockerfile
FROM squidfunk/mkdocs-material:latest as BUILDER
WORKDIR /app
COPY mkdocs.yml /app/mkdocs.yml
COPY docs /app/docs
RUN ["mkdocs", "build"]

FROM nginx:stable-alpine3.17-slim
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=BUILDER /app/site /var/www/documentation
HEALTHCHECK CMD curl --fail http://localhost:80 || exit 1"
EXPOSE 80
```

## Nginx Configuration

Create an `nginx.conf` file

```bash
touch nginx.conf
```

Add the following to the `nginx.conf` file

```nginx
server {

    listen       80;
    listen  [::]:80;

    root /var/www/documentation;
    index  index.html;

    error_page 404 403 /404.html;
    error_page  404              /404.html;
    location = /404.html {
        root /var/www/documentation;
        internal;
    }

    location /healthz { # Setups the `/healthz` page
       stub_status on; # Turns on the module designed to output status of the server
       access_log off; # Do not log requests to this endpoint
       allow 127.0.0.1; # Allows Localhost
       allow 172.16.0.0/12; # Allow Consul to access the page
       deny all; # Any one else gets put in the bin
    }
}
```

## Launch fly

```bash
flyctl launch
```

## GitHub Actions

First head over to [fly.io](https://fly.io) and create a new token.

In GitHub, navigate to your repo, then Settings > Secrets and Variables > Actions

Here, create a Repository Secret called FLY_ACCESS_TOKEN - Paste in the value from the Fly.io dashboard

Next create the workflows directory and add a `build-site.yml` file

```bash
mkdir -p .github/workflows
```

```bash
touch .github/workflows/build-site.yml
```

Add the following to the `build-site.yml` file

```yaml
name: Build Site
on:
  push:
    branches:
      - main
    paths:
      - docs/**
      - .github/workflows/build-site.yaml
      - mkdocs.yml
      - Dockerfile
      - fly.toml
jobs:
  site:
    runs-on: ubuntu-latest
    name: Build Documentation
    steps:
      - name: Git Clone
        uses: actions/checkout@v4
      - name: Fly Build and Deploy
        uses: userbradley/actions-fly@v1.0.0
        with:
          flyToken: ${{ secrets.FLY_ACCESS_TOKEN }}
```
