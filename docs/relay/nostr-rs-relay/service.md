# Service

A service is a long-running process that can be started and stopped. It can be used to run background tasks, handle network requests, or interact with the system.

## Create User

Create a new user called `nostr` to run the relay service:

```bash
sudo adduser --disabled-login nostr
```

Creating a new user is a good practice to isolate the service from the rest of the system.

## Change ownership for data directory

Change ownership of the relay data directory:

```bash
chown -R nostr:nostr /var/lib/nostr-rs-relay
```

## Run script

Create a new file at `/etc/systemd/system/nostr-relay.service` with the following content:

```ini
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
```

This script tells [systemd](https://systemd.io/) to start the relay service as the `nostr` user and restart it if it fails.

## Start service

Start the service using the following commands:

```bash
systemctl daemon-reload
systemctl enable nostr-relay
systemctl start nostr-relay
```

The relay service should now be running. You can check the status of the service using the following command:

```bash
systemctl status nostr-relay
```
