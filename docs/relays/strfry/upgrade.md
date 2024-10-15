# Upgrade

To upgrade strfry navigate to the strfry repository, e.g.,

```bash
cd $HOME/strfry
```

Pull the changes:

```bash
git pull
```

Update the submodules:

```bash
make update-submodules
```

Now, run:

```bash
make -j4
```

Stop the current strfry service:

```bash
systemctl stop strfry.service
```

Install strfry:

```bash
install -v -m 0755 -o root -g root -t /usr/local/bin strfry
```

Start the strfry service:

```bash
systemctl start strfry.service
```

Check the status of the service using:

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
