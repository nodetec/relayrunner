# Configuration

We're now going to discuss the nostr-rs-relay config file including how to set some of the settings as well as how to copy the file to a config directory owned by the `nostr` user we previously created. We're also going to discuss how to create the data directory which will be owned by the `nostr` user.

## Config File

The nostr-rs-relay config file is located in the nostr-rs-relay repository we cloned and is named `config.toml`. In our case the file is located in the following directory `$HOME/nostr/relays/nostr-rs-relay`.

To view the settings you can open the file:

```bash
nano $HOME/nostr/relays/nostr-rs-relay/config.toml
```

## Config Directory

We're going to create a config directory for the nostr-rs-relay in the `/etc` directory:

```bash
mkdir /etc/nostr-rs-relay
```

We can now copy the config file to the config directory:

```bash
cp $HOME/nostr/relays/nostr-rs-relay/config.toml /etc/nostr-rs-relay
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

- `relay_url` - The URL for the Nostr WebSocket of your relay. This should be the domain name of your server prefixed by `wss` if you set up an SSL/TLS certificate or `ws` if you didn't set up a certificate, e.g., `"wss://relay.relayrunner.xyz/"`.

- `name` - The name of your relay which will be shared with Nostr clients. Should be less than 30 characters. We'll set this to `"Relay Runner's nostr-rs-relay"`.

- `description` - A description of your relay. We'll set this to `"This is a Relay Runner nostr-rs-relay."`.

- `pubkey` - Your Nostr public key (32-byte hex, not npub) used for administrative requests, e.g., `"3bcbb0f7dea9da9f5b2659ca5da89d5e576215de3885e51bd2474dd1b0c44b16"`.

- `contact` - Alternative contact used for administrative requests. Can be an email or website and should be a URI using schemes like `mailto` or `https`. We'll set this to `"mailto:devs@node-tec.com"`.

- `favicon` - The path to your relay's favicon relative to the current directory and assumes the file format is ICO. You can generate a favicon here: [Favicon.io](https://favicon.io "Favicon.io").

- `relay_icon` - URL to your relay's icon, e.g., `"https://example.com/your-relay-icon.png"`. It's recommended to be in squared shape.

- `data_directory` - The directory where your relay will store data. The default value is set to the current directory. We'll set this to `"/var/lib/nostr-rs-relay/db"`.

- `max_conn` - Maximum number of SQLite reader connections. It's recommended to set this to approximate number of CPU cores.

- `address` - The address your relay will bind to. The default value is `"0.0.0.0"` which is what we're using.

- `port` - The port your relay will use for the WebSocket connection. The default value is `8080` which is what we're using.

- `remote_ip_header` - Used to specify the HTTP header for logging client IP addresses. We'll set this to `"x-forwarded-for"`.

- `pubkey_whitelist` - An array of public keys that are allowed to post to your relay. Only valid events from the specified public keys will be accepted if this variable is set. If you are running a server just for yourself or a small group, you can uncomment this line and add the whitelisted public keys to the array.
