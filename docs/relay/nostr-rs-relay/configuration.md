# Configuration

We're now going to discuss the nostr-rs-relay config file including how to set some of the settings as well as how to move the file to a config directory owned by the `nostr` user we previously created. We're also going to discuss how to create the data directory which will be owned by the `nostr` user.

## Config File

The nostr-rs-relay config file is located in the nostr-rs-relay repository we cloned and is named `config.toml`. In our case the file is located in the following directory `/tmp/nostr-rs-relay`.

To view the settings you can open the file:

```bash
nano /tmp/nostr-rs-relay/config.toml
```

## Config Directory

We're going to create a config directory for the nostr-rs-relay in the `/etc` directory:

```bash
mkdir /etc/nostr-rs-relay
```

We can now copy the config file to the config directory:

```bash
cp /tmp/nostr-rs-relay/config.toml /etc/nostr-rs-relay
```

We can change the permissions of the config directory and all of its content, i.e., the files and subdirectories inside of it:

```bash
chmod 0755 -R /etc/nostr-rs-relay
```

We can then change the ownership of the config directory to use the `nostr` user:

```bash
chown -R nostr:nostr /etc/nostr-rs-relay
```

## Data Directory

We're going to create a data directory for the nostr-rs-relay in the `/var/lib` directory:

```bash
mkdir -p /var/lib/nostr-rs-relay/db
```

We can change the permissions of the data directory and all of its content, i.e., the files and subdirectories inside of it:

```bash
chmod 0777 -R /var/lib/nostr-rs-relay
```

We can then change the ownership of the data directory to use the `nostr` user:

```bash
chown -R nostr:nostr /var/lib/nostr-rs-relay
```

## Database Dependencies

The default database used by nostr-rs-relay is SQLite which can be installed by running:

```bash
apt install sqlite3 libsqlite3-dev
```

## Edit Config File

To change the relay settings you can open the file and edit the settings you want to change:

```bash
nano /etc/nostr-rs-relay/config.toml
```

Here are some of the important settings you'll want to change in the config file:

- `relay_url` - The URL for the Nostr WebSocket of your relay. This should be the domain name of your server prefixed by `wss` if you set up an SSL/TLS certificate or `ws` if you didn't set up a certificate, e.g., `wss://relay.relayrunner.xyz`.

- `name` - The name of your relay which will be shared with Nostr clients, e.g., `Relay Runner's nostr-rs-relay`.

- `description` - A description of your relay.

- `pubkey` - Your Nostr public key (32-byte hex, not npub) used for administrative requests.

- `contact` - Your email address used for administrative requests.

- `favicon` - The path to your relay's favicon relative to the current directory. Set to `favicon.ico` by default and assumes the file format is ICO. You can generate a favicon here: [Favicon.io](https://favicon.io "Favicon.io").

- `relay_icon` - URL to your relay's icon, e.g., `https://example.com/your-relay-icon.png`.

- `data_directory` - The directory where your relay will store data. The default value is set to the current directory. We'll set this to `/var/lib/nostr-rs-relay/db`.

- `max_conn` - Maximum number of SQLite reader connections. It's recommended to set this to the approximate number of CPU cores.

- `address` - The address your relay will listen on. We'll set this to `127.0.0.1`.

- `remote_ip_header` - Used to specify the HTTP header for logging client IP addresses. We'll set this to `x-forwarded-for`.

- `pubkey_whitelist` - A list of public keys that are allowed to post to your relay. Only valid events from the specified public keys will be accepted. If you are running a server just for yourself or a small group you can uncomment this line and add the whitelisted public keys to the list.
