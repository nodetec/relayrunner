# Upgrade

To upgrade the WoT Relay navigate to the WoT Relay repository, e.g.,

```bash
cd $HOME/nostr/relays/wot-relay
```

Pull the changes:

```bash
git pull
```

Build the WoT Relay:

```bash
go build -ldflags "-X main.version=$(git describe --tags --always)"
```

Stop the current WoT Relay service:

```bash
systemctl stop wot-relay.service
```

Install the WoT Relay:

```bash
install -v -m 0755 -o root -g root -t /usr/local/bin wot-relay
```

Start the WoT Relay service:

```bash
systemctl start wot-relay.service
```

Check the status of the service using:

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
