# Configuration

We're now going to discuss how to configure the Khatru29 example relay environment file which allows us to set various relay settings. We're also going to discuss how to create the data directory which will be owned by the `nostr` user.

## Environment File

We're going to create the Khatru29 example relay environment file in the `/etc/systemd/system` directory:

```bash
touch /etc/systemd/system/khatru29.env
```

## Data Directory

We're going to create a data directory for the Khatru29 example relay in the `/var/lib` directory:

```bash
mkdir -p /var/lib/khatru29
```

We can change the permissions of the data directory and all of its content, i.e., the files and subdirectories inside of it:

```bash
chmod 0755 -R /var/lib/khatru29
```

We can then change the ownership of the data directory to use the `nostr` user:

```bash
chown -R nostr:nostr /var/lib/khatru29
```

## Edit Environment File

To change the relay settings you can open the `khatru29.env` file:

```bash
nano /etc/systemd/system/khatru29.env
```

We're now going to add the following lines to the environment file:

```ini
DOMAIN="relay.relayrunner.xyz"
PORT="5577"
DATABASE_PATH="/var/lib/khatru29/db"
RELAY_NAME="Relay Runner's Khatru29 Relay"
RELAY_PRIVKEY="<your-secret-key>"
RELAY_DESCRIPTION="Khatru29 Nostr Relay"
RELAY_CONTACT="your-email@example.com"
RELAY_ICON="https://example.com/your-relay-icon.png"
```

Here's a description of the relay settings:

- `DOMAIN` - The domain name of your server, e.g., `"relay.relayrunner.xyz"`.

- `PORT` - The port your relay will run on. This setting is optional and the default value is `"5577"`.

- `DATABASE_PATH` - The directory where your relay will store data. This setting is optional and the default value is set to `"./db"`. We'll set this to `"/var/lib/khatru29/db"`.

- `RELAY_NAME` - The name of your relay, e.g., `"Relay Runner's Khatru29 Relay"`.

- `RELAY_PRIVKEY` - Your Nostr private key (32-byte hex, not nsec) that you're using as the relay's private key. Be sure to input your secret key securely, i.e., don't let anyone, any camera, etc. see your secret key, clear your clipboard if you're copying and pasting the value, etc. Be sure to replace `"<your-secret-key>"` with your secret key.

- `RELAY_DESCRIPTION` - A description of your relay. This setting is optional and the default value is set to `""`. We'll set this to `"Khatru29 Nostr Relay"`.

- `RELAY_CONTACT` - Your email address used for administrative requests, e.g., `"your-email@example.com"`. This setting is optional and the default value is `""`.

- `RELAY_ICON` - URL to your relay's icon, e.g., `"https://example.com/your-relay-icon.png"`. This setting is optional and the default value is `""`.
