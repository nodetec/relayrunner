# Service

A service is a long-running process that can be started and stopped manually as well as set to automatically start when the system boots. It can be used to run background tasks, handle network requests, and interact with the system.

## Create Unit File

We're going to create a [systemd](https://systemd.io "systemd") service for the nostr-rs-relay which will allow us to automatically start the nostr-rs-relay on boot.

To do this we're going to create and open the following systemd unit file:

```bash
nano /etc/systemd/system/nostr-rs-relay.service
```

## Edit Unit File

We're now going to add the following lines to the `nostr-rs-relay.service` unit file:

```ini
[Unit]
Description=nostr-rs-relay Service
After=network.target

[Service]
Type=simple
User=nostr
Group=nostr
WorkingDirectory=/home/nostr
Environment=RUST_LOG=info,nostr_rs_relay=info
ExecStart=/usr/local/bin/nostr-rs-relay --config /etc/nostr-rs-relay/config.toml --db /var/lib/nostr-rs-relay/db
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

This service tells systemd to start nostr-rs-relay as the `nostr` user after the network has been properly configured using our specified config file and data directory and to attempt to restart the service if it fails.

## Reload systemd

To apply the newly created nostr-rs-relay service we're going to reload systemd:

```bash
systemctl daemon-reload
```

## Enable Service

We can enable the nostr-rs-relay service to automatically start on boot:

```bash
systemctl enable nostr-rs-relay.service
```

## Start Service

To start the nostr-rs-relay service:

```bash
systemctl start nostr-rs-relay.service
```

## Check Status

The relay service should now be running and set to automatically start on boot.

You can check the status of the service using:

```bash
systemctl status nostr-rs-relay.service
```

If the service is running, you should see the following in the output:

```bash
Active: active (running)
```

If the service is enabled to automatically start on boot, you should see the following in the output:

```bash
Loaded: loaded (/etc/systemd/system/nostr-rs-relay.service; enabled; preset: enabled)
```
