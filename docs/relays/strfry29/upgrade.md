# Upgrade

To upgrade strfry29 navigate to the `strfry29` directory in the relay29 repository, e.g.,

```bash
cd $HOME/nostr/relays/relay29/strfry29
```

Pull the changes:

```bash
git pull
```

Build strfry29:

```bash
go build
```

Stop the current strfry29 service:

```bash
systemctl stop strfry29.service
```

Install strfry29:

```bash
install -v -m 0755 -o root -g root -t /usr/local/bin strfry29
```

Start the strfry29 service:

```bash
systemctl start strfry29.service
```

Check the status of the service using:

```bash
systemctl status strfry29.service
```

If the service is running, you should see the following in the output:

```bash
Active: active (running)
```

If the service is enabled to automatically start on boot, you should see the following in the output:

```bash
Loaded: loaded (/etc/systemd/system/strfry29.service; enabled; preset: enabled)
```
