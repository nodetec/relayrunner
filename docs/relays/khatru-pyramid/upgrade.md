# Upgrade

To upgrade Khatru Pyramid navigate to the Khatru Pyramid repository, e.g.,

```bash
cd $HOME/nostr/relays/khatru-pyramid
```

Pull the changes:

```bash
git pull
```

Build Khatru Pyramid:

```bash
go build
```

Stop the current Khatru Pyramid service:

```bash
systemctl stop khatru-pyramid.service
```

Install Khatru Pyramid:

```bash
install -v -m 0755 -o root -g root -t /usr/local/bin khatru-pyramid
```

Start the Khatru Pyramid service:

```bash
systemctl start khatru-pyramid.service
```

Check the status of the service using:

```bash
systemctl status khatru-pyramid.service
```

If the service is running, you should see the following in the output:

```bash
Active: active (running)
```

If the service is enabled to automatically start on boot, you should see the following in the output:

```bash
Loaded: loaded (/etc/systemd/system/khatru-pyramid.service; enabled; preset: enabled)
```
