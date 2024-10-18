# Configuration

We're now going to discuss how to configure the Khatru Pyramid environment file which allows us to set various relay settings. We're also going to discuss how to create the data directory which will be owned by the `nostr` user.

## Environment File

We're going to create the Khatru Pyramid environment file in the `/etc/systemd/system` directory:

```bash
touch /etc/systemd/system/khatru-pyramid.env
```

## Data Directory

We're going to create a data directory for Khatru Pyramid in the `/var/lib` directory:

```bash
mkdir -p /var/lib/khatru-pyramid
```

We can change the permissions of the data directory and all of its content, i.e., the files and subdirectories inside of it:

```bash
chmod 0755 -R /var/lib/khatru-pyramid
```

We can then change the ownership of the data directory to use the `nostr` user:

```bash
chown -R nostr:nostr /var/lib/khatru-pyramid
```

## Edit Environment File

To change the relay settings you can open the `khatru-pyramid.env` file:

```bash
nano /etc/systemd/system/khatru-pyramid.env
```

We're now going to add the following lines to the environment file:

```ini
DOMAIN="relay.relayrunner.xyz"
PORT="3335"
DATABASE_PATH="/var/lib/khatru-pyramid/db"
USERDATA_PATH="/var/lib/khatru-pyramid/users.json"
MAX_INVITES_PER_PERSON="3"
RELAY_NAME="Relay Runner's Pyramid Relay"
RELAY_PUBKEY="3bcbb0f7dea9da9f5b2659ca5da89d5e576215de3885e51bd2474dd1b0c44b16"
RELAY_DESCRIPTION="This is a Relay Runner Khatru Pyramid relay."
RELAY_CONTACT="your-email@example.com"
RELAY_ICON="https://example.com/your-relay-icon.png"
```

Here's a description of the relay settings:

- `DOMAIN` - The domain name of your server, e.g., `"relay.relayrunner.xyz"`.

- `PORT` - The port your relay will use for the WebSocket connection. This setting is optional and the default value is `"3334"`. We'll set this to `"3335"`.

- `DATABASE_PATH` - The directory where your relay will store data. This setting is optional and the default value is set to `"./db"`. We'll set this to `"/var/lib/khatru-pyramid/db"`.

- `USERDATA_PATH` - The file where your relay will store user data. This setting is optional and the default value is set to `"./users.json"`. We'll set this to `"/var/lib/khatru-pyramid/users.json"`.

- `MAX_INVITES_PER_PERSON` - The maximum number of invites each person can make for the relay. This setting is optional and the default value is set to `"3"` which is what we're using.

- `RELAY_NAME` - The name of your relay which will be shared with Nostr clients. Should be less than 30 characters. We'll set this to `"Relay Runner's Pyramid Relay"`.

- `RELAY_PUBKEY` - Your Nostr public key (32-byte hex, not npub), e.g., `"3bcbb0f7dea9da9f5b2659ca5da89d5e576215de3885e51bd2474dd1b0c44b16"`.

- `RELAY_DESCRIPTION` - A description of your relay. This setting is optional and the default value is set to `""`. We'll set this to `"This is a Relay Runner Khatru Pyramid relay."`.

- `RELAY_CONTACT` - Alternative contact used for administrative requests. Can be an email or website and should be a URI using schemes like `mailto` or `https`. This setting is optional and the default value is `""`. We'll set this to `"mailto:devs@node-tec.com"`.

- `RELAY_ICON` - URL to your relay's icon, e.g., `"https://example.com/your-relay-icon.png"`. It's recommended to be in squared shape. This setting is optional and the default value is `""`.
