# Configuration

```bash
mkdir /etc/nostr-rs-relay
cd /etc/nostr-rs-relay
wget https://raw.githubusercontent.com/scsibug/nostr-rs-relay/master/config.toml
```

Here are some important settings:

- `relay_url` - The URL of your relay. This should be the domain name of your server e.g. `relay.relayrunner.xyz`;

- `name` - The name of your relay.

- `description` - A description of your relay.

- `pubkey` - Your nostr public key so people know who to send their complaints to.

- `contact` - Your email address.

- `favicon` - The path to your relay's favicon relative to the current directory. Set to `favicon.ico` by default. You can generate a favicon here: [favicon.io](https://favicon.io/)

- `relay_icon` - URL to your relay's icon. For example, `https://example.com/icon.png`.

- `data_directory` - The directory where your relay will store data. We'll set this to `/var/lib/nostr-rs-relay/data`.

- `max_conn` - Maximum number of SQLite reader connections. Recommend setting this to approx the number of CPU cores.

- `address` - The address your relay will listen on. We'll set this to `127.0.0.1`.

- `remote_ip_header` - The header that contains the client's IP address. We'll set this to `x-forwarded-for`.

- `pubkey_whitelist` - A list of public keys that are allowed to post to your relay. If you are running a server just for yourself or a small group you can uncomment this line and add the whitelisted public keys to the list.
