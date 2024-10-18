# Intrusion Detection

To further increase the security of the SSH login, we can use an Intrusion Detection System (IDS) which is an application that monitors a network or systems for malicious activity or policy violations. We'll use [Fail2Ban](https://github.com/fail2ban/fail2ban "Fail2Ban GitHub") which is a free and open source IDS for our relay.

Fail2Ban monitors system logs for automated attacks on servers, e.g., repeated login failures. When a possible attack is identified using default parameters or parameters we set, it will block the IP address of the attacker for a set amount of time or permanently.

Fail2Ban is primarily focused on SSH attacks, but it can be configured to work with any service susceptible to an automated network attack that uses log files.

## Install Fail2Ban

To install UFW run:

```bash
apt install fail2ban
```

## Status

To check the status of Fail2Ban run:

```bash
systemctl status fail2ban
```

If you see output similar to: `Active: failed (Result: exit-code)` instead of `Active: active (running)`, an error occurred that we need to resolve before we can activate Fail2Ban.

Take a look at the [Resolve Error(s)](/server/intrusion-detection/#resolve-errors "Resolve Error(s)") section to determine how to view the full error(s) and how to resolve common errors.

## Enable

Fail2Ban should already be enabled to start automatically on boot, but if it isn’t run:

```bash
systemctl enable fail2ban
```

## Start

Fail2Ban should have started after the installation, but if it didn't run:

```bash
systemctl start fail2ban
```

## View Jails

Fail2Ban jails describe how various services, e.g., SSH, HTTP, FTP, etc. are handled by specifying whether they’re enabled or disabled as well as by setting combinations of filters and actions. Fail2Ban comes with 1 jail rule for SSH by default.

To view the jails run:

```bash
fail2ban-client status
```

Output:

```bash
Status
|- Number of jail:	1
`- Jail list:	sshd
```

## Default Jail Configuration

The default Fail2Ban jail configuration is located in `/etc/fail2ban/jail.conf`.

To view the jail configuration you can open the file:

```bash
nano /etc/fail2ban/jail.conf
```

## Edit Jail Configuration

To edit the jail configuration, create new configuration files in the `/etc/fail2ban/jail.d` directory using a `.local` file extension.

### sshd

Before creating a new SSH jail configuration we're going to first delete the `defaults-debian.conf` file which contains a basic sshd jail configuration:

```bash
rm /etc/fail2ban/jail.d/defaults-debian.conf
```

You can now create and edit a new SSH jail configuration called `sshd.local` in the `/etc/fail2ban/jail.d` directory:

```bash
nano /etc/fail2ban/jail.d/sshd.local
```

Add the following to the file:

```bash
[sshd]
enabled = true
port = 22
findtime = 5m
bantime = 2h
maxentry = 3
ignoreip = 127.0.0.1/8 ::1
```

Save and exit the file.

Here's a description of the settings:

- `enabled` - Enables the sshd jail.

- `port` - The port to listen for SSH connections on which by default is `22`. If you set a custom SSH port, be sure to update the value to correctly filter traffic.

- `findtime` - Sets the time duration for the number of failures before a ban is enacted. The default value is `10m`. We'll set this to `5m`, i.e., 5 minutes.

- `bantime` - Sets the time duration of the ban placed on an IP address. The default value is `10m`. We'll set this to `2h`, i.e., 2 hours.

- `maxretry` - Sets the number of failures before an IP address is banned. The default value is `5`. We'll set this to `3`.

- `ignoreip` - Sets IP addresses that will not get banned by whitelisting them. The value `127.0.0.1/8 ::1` corresponds to the IPv4 and IPv6 loopback address, i.e., the IP addresses the device uses to refer to itself. You can also add your public IP address(es) to avoid being locked out of the device.

If you had to resolve the missing log file for sshd jail error after installing Fail2Ban, be sure to include the `backend = systemd` setting in the file as well.

To apply the changes restart Fail2Ban:

```bash
systemctl restart fail2ban
```

Verify the sshd jail configuration:

```bash
fail2ban-client status sshd
```

Ouput:

```bash
Status for the jail: sshd
|- Filter
|  |- Currently failed:	0
|  |- Total failed:	0
|  `- Journal matches:	_SYSTEMD_UNIT=sshd.service + _COMM=sshd
`- Actions
   |- Currently banned:	0
   |- Total banned:	0
   `- Banned IP list:
```

Be sure to not lock yourself out of the relay by attempting too many incorrect login attempts within the `findtime` limit. If you do, try accessing the relay using a different IP address using the correct login credentials or wait for the `bantime` to expire.

## Resolve Error(s)

If you’re seeing `Active: failed (Result: exit-code)` when checking the status of Fail2Ban, and you’re unable to view the full error message run:

```bash
systemctl status fail2ban | less
```

You can now navigate through the output of the `status` command by using the arrow keys. Press `q` to quit viewing the output.

### Missing Log File for sshd Jail

If you see the following errors, the async configuration of the server failed since no log file for the sshd jail was found:

```bash
ERROR   Failed during configuration: Have not found any log file for sshd jail
ERROR   Async configuration of server failed
```

To resolve this we’re going to change the backend value for the sshd jail in a `sshd.local` file which we're going to create in the `/etc/fail2ban/jail.d` directory.

To create and open the `sshd.local` file run:

```bash
nano /etc/fail2ban/jail.d/sshd.local
```

Add the following to the file:

```bash
[sshd]
enabled = true
backend = systemd
```

Now save and exit the file.

Restart Fail2Ban to apply the changes:

```bash
systemctl restart fail2ban
```

Check the status:

```bash
systemctl status fail2ban
```

If you see `Active: active (running)`, the error has been resolved.
