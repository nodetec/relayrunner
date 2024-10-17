# Service

A service is a long-running process that can be started and stopped manually as well as set to automatically start when the system boots. It can be used to run background tasks, handle network requests, and interact with the system.

## Create Unit File

We're going to create a [systemd](https://systemd.io "systemd") service for the WoT Relay which will allow us to automatically start the relay on boot.

To do this we're going to create and open the following systemd unit file:

```bash
nano /etc/systemd/system/wot-relay.service
```

## Edit Unit File

We're now going to add the following lines to the `wot-relay.service` unit file:

```ini
[Unit]
Description=WoT Relay Service
After=network.target

[Service]
Type=simple
User=nostr
Group=nostr
WorkingDirectory=/home/nostr
EnvironmentFile=/etc/systemd/system/wot-relay.env
ExecStart=/usr/local/bin/wot-relay
Restart=on-failure
MemoryMax=2G

[Install]
WantedBy=multi-user.target
```

This service tells systemd to start the WoT Relay as the `nostr` user after the network has been properly configured using our specified environment file with a hard limit on the maximum memory usage to 2GB and to attempt to restart the service if it fails.

## Reload systemd

To apply the newly created WoT Relay service we're going to reload systemd:

```bash
systemctl daemon-reload
```

## Enable Service

We can enable the WoT Relay service to automatically start on boot:

```bash
systemctl enable wot-relay.service
```

## Start Service

To start the WoT Relay service:

```bash
systemctl start wot-relay.service
```

## Check Status

The relay service should now be running and set to automatically start on boot.

You can check the status of the service using:

```bash
systemctl status wot-relay.service
```

If the service is running, you should see the following in the output:

```bash
Active: active (running)
```

If the service is enabled to automatically start on boot, you should see the following in the output:

```bash
Loaded: loaded (/etc/systemd/system/wot-relay.service; enabled; preset: enabled)
```
