# Upgrade

To upgrade Khatru29 navigate to the `groups.fiatjaf.com` directory in the relay29 repository, e.g.,

```bash
cd $HOME/nostr/relays/relay29/examples/groups.fiatjaf.com
```

Pull the changes:

```bash
git pull
```

Build the `groups.fiatjaf.com` example:

```bash
go build
```

Rename the `groups.fiatjaf.com` binary to `khatru29`:

```bash
mv groups.fiatjaf.com khatru29
```

Stop the current Khatru29 service:

```bash
systemctl stop khatru29.service
```

Install Khatru29:

```bash
install -v -m 0755 -o root -g root -t /usr/local/bin khatru29
```

Start the Khatru29 service:

```bash
systemctl start khatru29.service
```

Check the status of the service using:

```bash
systemctl status khatru29.service
```

If the service is running, you should see the following in the output:

```bash
Active: active (running)
```

If the service is enabled to automatically start on boot, you should see the following in the output:

```bash
Loaded: loaded (/etc/systemd/system/khatru29.service; enabled; preset: enabled)
```
