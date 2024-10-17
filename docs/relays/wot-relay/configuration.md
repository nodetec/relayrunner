# Configuration

We're now going to discuss how to configure the WoT Relay environment file which allows us to set various relay settings. We're also going to discuss how to create the data directory which will be owned by the `nostr` user.

Along with the WoT Relay environment file, we also need to set up an `index.html` file which is used for the relay's HTML page and a `static` directory which is used to store static assets for the relay's HTML page.

The wot-relay repository comes with a default `index.html` file as well as a default `static` directory containing some default static assets which we'll be copying to a directory owned by the `nostr` user we previously created.

## Environment File

We're going to create the WoT Relay environment file in the `/etc/systemd/system` directory:

```bash
touch /etc/systemd/system/wot-relay.env
```

## Data Directory

We're going to create a data directory for the WoT Relay in the `/var/lib` directory:

```bash
mkdir -p /var/lib/wot-relay/db
```

We can change the permissions of the data directory and all of its content, i.e., the files and subdirectories inside of it:

```bash
chmod 0755 -R /var/lib/wot-relay
```

We can then change the ownership of the data directory to use the `nostr` user:

```bash
chown -R nostr:nostr /var/lib/wot-relay
```

## index.html File

We're going to create directories for the WoT Relay in the `/etc` directory:

```bash
mkdir -p /etc/wot-relay/templates
```

We can now copy the `index.html` file to the `templates` directory:

```bash
cp $HOME/wot-relay/templates/index.html /etc/wot-relay/templates
```

Feel free to update the `index.html` file as you see fit.

## static Directory

We can now copy the `static` directory and all of its content to the `templates` directory:

```bash
cp -R $HOME/wot-relay/templates/static /etc/wot-relay/templates
```

## /etc/wot-relay Permissions and Ownership

We can change the permissions of the `/etc/wot-relay` directory and all of its content, i.e., the files and subdirectories inside of it:

```bash
chmod 0755 -R /etc/wot-relay
```

We can then change the ownership of the `/etc/wot-relay` directory to use the `nostr` user:

```bash
chown -R nostr:nostr /etc/wot-relay
```

## Edit Environment File

To change the relay settings you can open the `wot-relay.env` file:

```bash
nano /etc/systemd/system/wot-relay.env
```

We're now going to add the following lines to the environment file:

```ini
RELAY_NAME="Relay Runner's WoT Relay"
RELAY_PUBKEY="3bcbb0f7dea9da9f5b2659ca5da89d5e576215de3885e51bd2474dd1b0c44b16"
RELAY_DESCRIPTION="Only notes in relayrunner WoT"
RELAY_URL="wss://relay.relayrunner.xyz"
RELAY_ICON="https://example.com/your-relay-icon.png"
RELAY_CONTACT="mailto:your-email@example.com"
DB_PATH="/var/lib/wot-relay/db"
INDEX_PATH="/etc/wot-relay/templates/index.html"
STATIC_PATH="/etc/wot-relay/templates/static"
REFRESH_INTERVAL_HOURS=3
MINIMUM_FOLLOWERS=1
ARCHIVAL_SYNC="FALSE"
ARCHIVE_REACTIONS="FALSE"
MAX_AGE_DAYS=0
```

Here's a description of the relay settings:

- `RELAY_NAME` - The name of your relay which will be shared with Nostr clients. Must be less than 30 characters. We'll set this to `"Relay Runner's WoT Relay"`.

- `RELAY_PUBKEY` - Your Nostr public key (32-byte hex, not npub) used for administrative requests. We'll set this to `"3bcbb0f7dea9da9f5b2659ca5da89d5e576215de3885e51bd2474dd1b0c44b16"`.

- `RELAY_DESCRIPTION` - A description of your relay. We'll set this to `"Only notes in relayrunner WoT"`.

- `RELAY_URL` - The URL for the Nostr WebSocket of your relay. This should be the domain name of your server prefixed by `wss` if you set up an SSL/TLS certificate or `ws` if you didn't set up a certificate, e.g., `"wss://relay.relayrunner.xyz"`.

- `RELAY_ICON` - URL to your relay's icon, e.g., `"https://example.com/your-relay-icon.png"`. The default value is `"https://pfp.nostr.build/56306a93a88d4c657d8a3dfa57b55a4ed65b709eee927b5dafaab4d5330db21f.png"`.

- `RELAY_CONTACT` - Alternative contact used for administrative requests. Can be an email or website and should be a URI using schemes like `mailto` or `https`. The default value is the value you set for `RELAY_PUBKEY`. We'll set this to `"mailto:devs@node-tec.com"`.

- `DB_PATH` - The path to the directory where your relay will store the database. We'll set this to `"/var/lib/wot-relay/db"`.

- `INDEX_PATH` - The path to the relay's `index.html` page. We'll set this to `"/etc/wot-relay/templates/index.html"`.

- `STATIC_PATH` - The path to the relay's `static` directory. We'll set this to `"/etc/wot-relay/templates/static"`

- `REFRESH_INTERVAL_HOURS` - Used to set how often the relay's view of the Web of Trust should be refreshed in hours. The default value is `3` which is the value we're using.

- `MINIMUM_FOLLOWERS` - Used to set how many followers before someone is allowed in your Web of Trust. The default value is `1` which is the value we're using.

- `ARCHIVAL_SYNC` - Used to specify if you want to archive all notes from everyone in your Web of Trust. This can be data intensive, so it's not recommended. The default value is `"TRUE"`. We'll set this to `"FALSE"`.

- `ARCHIVE_REACTIONS` - Used to specify if you want to archive all reactions from everyone in your Web of Trust. This can be data intensive, so it's not recommended. The default value is `"TRUE"`. We'll set this to `"FALSE"`.

- `MAX_AGE_DAYS` - Used to set the number of days to keep certain note kinds before deleting them. The default value is `0` which is the value we're using. A value of `0` means the relay won't automatically delete the notes.
