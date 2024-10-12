# Service

A service is a long-running process that can be started and stopped manually as well as set to automatically start when the system boots. It can be used to run background tasks, handle network requests, and interact with the system.

## Create Unit File

We're going to create a [systemd](https://systemd.io "systemd") service for strfry which will allow us to automatically start the strfry relay on boot.

To do this we're going to create and open the following systemd unit file:

```bash
nano /etc/systemd/system/strfry.service
```

## Edit Unit File

We're now going to add the following lines to the `strfry.service` unit file:

```ini
[Unit]
Description=strfry Service
After=network.target

[Service]
Type=simple
User=nostr
Group=nostr
ExecStart=/usr/local/bin/strfry --config=/etc/strfry/strfry.conf relay
Restart=on-failure
RestartSec=5
ProtectHome=yes
NoNewPrivileges=yes
ProtectSystem=full
LimitCORE=1000000000

[Install]
WantedBy=multi-user.target
```

This service tells systemd to start strfry as the `nostr` user after the network has been properly configured using our specified config file and to attempt to restart the service after waiting 5 seconds if it fails.

## Reload systemd

To apply the newly created strfry service we're going to reload systemd:

```bash
systemctl daemon-reload
```

## Enable Service

We can enable the strfry service to automatically start on boot:

```bash
systemctl enable strfry.service
```

## Start Service

To start the strfry service:

```bash
systemctl start strfry.service
```

## Check Status

The relay service should now be running and set to automatically start on boot.

You can check the status of the service using:

```bash
systemctl status strfry.service
```

If the service is running, you should see the following in the output:

```bash
Active: active (running)
```

If the service is enabled to automatically start on boot, you should see the following in the output:

```bash
Loaded: loaded (/etc/systemd/system/strfry.service; enabled; preset: enabled)
```
