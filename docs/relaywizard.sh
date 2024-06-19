#!/bin/bash

# Function to install nginx
function install_nginx() {
  echo "Updating package lists..."
  apt update
  echo "Installing nginx..."
  apt install -y nginx
}

# Function to install Certbot and dependencies
function install_certbot() {
  echo "Installing Certbot and dependencies..."
  apt install -y certbot python3-certbot-nginx
}

# Function to extract the directory name from the domain
function get_directory_name() {
  local domain_name="$1"
  IFS='.' read -r -a domain_parts <<< "$domain_name"
  if [[ ${#domain_parts[@]} -gt 2 ]]; then
    echo "${domain_parts[1]}"
  else
    echo "${domain_parts[0]}"
  fi
}

# Function to configure nginx initially
function configure_nginx_initial() {
  local domain_name="$1"
  local dir_name
  dir_name=$(get_directory_name "$domain_name")

  echo "Creating necessary directories..."
  mkdir -p /var/www/$dir_name
  mkdir -p /var/www/$dir_name/.well-known/acme-challenge/

  echo "Removing existing nginx configuration if it exists..."
  rm -f /etc/nginx/conf.d/nostr_relay.conf

  echo "Configuring nginx..."
  cat <<EOL > /etc/nginx/conf.d/nostr_relay.conf
map \$http_upgrade \$connection_upgrade {
    default upgrade;
    '' close;
}

upstream websocket {
    server 127.0.0.1:8080;
}

# $domain_name
server {
    listen 80;
    listen [::]:80;
    server_name $domain_name;

    location /.well-known/acme-challenge/ {
        root /var/www/$dir_name;
        allow all;
    }

    location / {
        proxy_pass http://websocket;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;
        proxy_set_header Host \$host;
        proxy_set_header X-Forwarded-For \$remote_addr;
    }
}
EOL

  echo "Reloading nginx to apply the configuration..."
  systemctl reload nginx
}

# Function to configure nginx with SSL
function configure_nginx_ssl() {
  local domain_name="$1"
  local dir_name
  dir_name=$(get_directory_name "$domain_name")

  echo "Removing existing nginx configuration if it exists..."
  rm -f /etc/nginx/conf.d/nostr_relay.conf

  echo "Updating nginx configuration for SSL..."
  cat <<EOL > /etc/nginx/conf.d/nostr_relay.conf
map \$http_upgrade \$connection_upgrade {
    default upgrade;
    '' close;
}

upstream websocket {
    server 127.0.0.1:8080;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name $domain_name;

    location / {
        proxy_pass http://websocket;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;
        proxy_set_header Host \$host;
        proxy_set_header X-Forwarded-For \$remote_addr;
    }

    #### SSL Configuration ####
    ssl_certificate /etc/letsencrypt/live/$domain_name/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$domain_name/privkey.pem;

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
EOL

  echo "Reloading nginx to apply the SSL configuration..."
  systemctl reload nginx
}

# Function to reload nginx
function reload_nginx() {
  echo "Reloading nginx..."
  systemctl reload nginx
}

# Function to start and enable nginx
function start_nginx() {
  echo "Starting nginx..."
  systemctl start nginx
  echo "Enabling nginx to start on boot..."
  systemctl enable nginx
}

# Function to test nginx configuration
function test_nginx() {
  echo "Testing nginx configuration..."
  nginx -t
}

# Function to configure firewall
function configure_firewall() {
  echo "Configuring firewall for nginx..."
  ufw allow 'Nginx Full'
}

# Function to install and configure nostr relay
function install_nostr_relay() {
  echo "Installing dependencies for nostr relay..."
  apt install -y build-essential cmake protobuf-compiler pkg-config libssl-dev git

  if [ -f /usr/local/bin/nostr-rs-relay ]; then
    echo "nostr-rs-relay executable already exists. Skipping compilation and installation."
  else
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    source $HOME/.cargo/env

    echo "Cloning and building nostr-rs-relay..."
    cd /usr/local/src
    git clone https://git.sr.ht/~gheartsfield/nostr-rs-relay
    cd nostr-rs-relay
    cargo build --release

    echo "Installing nostr-rs-relay..."
    install target/release/nostr-rs-relay /usr/local/bin
  fi

  echo "Creating necessary directories for nostr relay..."
  mkdir -p /var/lib/nostr-rs-relay/data
}

# Function to create nostr relay config
function create_nostr_config() {
  if [ -f /etc/nostr-rs-relay/config.toml ]; then
    echo "Configuration file already exists. Skipping creation."
    return
  fi

  echo "Creating configuration directory for nostr relay..."
  mkdir -p /etc/nostr-rs-relay

  echo "Prompting for configuration variables..."
  echo "Enter the relay URL (e.g., wss://example.com):"
  read relay_url
  echo "Enter the relay name:"
  read relay_name
  echo "Enter the relay description:"
  read relay_description
  echo "Enter the administrative contact pubkey (32-byte hex, not npub):"
  read relay_pubkey

  echo "Creating config.toml file..."
  cat <<EOL > /etc/nostr-rs-relay/config.toml
[info]
# The advertised URL for the Nostr websocket.
relay_url = "$relay_url"

# Relay information for clients. Put your unique server name here.
name = "$relay_name"

# Description
description = "$relay_description"

# Administrative contact pubkey (32-byte hex, not npub)
pubkey = "$relay_pubkey"

[database]
# Database engine to use.
engine = "sqlite"

# Directory to store the database in.
data_directory = "/var/lib/nostr-rs-relay/data"

[network]
# Bind to this network address
address = "127.0.0.1"

# Listen on this port
port = 8080
EOL
}

# Function to create nostr relay service
function create_nostr_service() {
  echo "Creating nostr user..."
  adduser --disabled-login --gecos "" nostr

  echo "Setting permissions for /var/lib/nostr-rs-relay..."
  chown -R nostr:nostr /var/lib/nostr-rs-relay

  echo "Creating nostr-relay.service file..."
  cat <<EOL > /etc/systemd/system/nostr-relay.service
[Unit]
Description=Nostr Relay
After=network.target

[Service]
Type=simple
User=nostr
WorkingDirectory=/home/nostr
Environment=RUST_LOG=info,nostr_rs_relay=info
ExecStart=/usr/local/bin/nostr-rs-relay --config /etc/nostr-rs-relay/config.toml
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOL

  echo "Reloading systemd daemon..."
  systemctl daemon-reload

  echo "Enabling and starting nostr-relay service..."
  systemctl enable nostr-relay
  systemctl start nostr-relay

  echo "Checking nostr-relay service status..."
  systemctl status nostr-relay
}

# Main script execution
echo "This script will install and configure nginx for a nostr relay on a Debian server."

# Prompt for domain name
echo "Enter the domain name for the nostr relay site (e.g., example.com):"
read domain_name

# Prompt for email
echo "Enter your email address for SSL certificate registration:"
read email

# Install nginx
install_nginx

# Configure nginx initially
configure_nginx_initial "$domain_name"

# Configure firewall
configure_firewall

# Start and enable nginx
start_nginx

# Test nginx configuration
test_nginx

# Install Certbot and dependencies
install_certbot

# Generate SSL certificate if not already present
local dir_name
dir_name=$(get_directory_name "$domain_name")

if [ -f /etc/letsencrypt/live/$domain_name/fullchain.pem ] && [ -f /etc/letsencrypt/live/$domain_name/privkey.pem ]; then
  echo "SSL certificate already exists. Skipping certificate generation."
else
  echo "Generating SSL certificate with Certbot..."
  certbot certonly --webroot -w /var/www/$dir_name -d $domain_name --email $email --agree-tos --no-eff-email

  if [ $? -ne 0 ]; then
    echo "Certbot failed to obtain the certificate. Exiting."
    exit 1
  fi
fi

# Update nginx configuration with SSL
configure_nginx_ssl "$domain_name"

# Reload nginx to apply the new configuration
reload_nginx

# Test nginx configuration again
test_nginx

# Install and configure nostr relay
install_nostr_relay

# Create nostr relay config
create_nostr_config

# Create nostr relay service
create_nostr_service

echo "nginx and nostr relay installation and configuration completed."
