# Configuration

We're now going to discuss the strfry config file including how to set some of the settings as well as how to move the file to a config directory owned by the `nostr` user we previously created. We're also going to discuss how to create the data directory which will be owned by the `nostr` user.

## Config File

The strfry config file is located in the strfry repository we cloned and is named `strfry.conf`. In our case the file is located in the following directory `$HOME/strfry`.

To view the settings you can open the file:

```bash
nano $HOME/strfry/strfry.conf
```

## Config Directory

We're going to create a config directory for strfry in the `/etc` directory:

```bash
mkdir /etc/strfry
```

We can now copy the config file to the config directory:

```bash
cp $HOME/strfry/strfry.conf /etc/strfry
```

We can change the permissions of the config directory and all of its content, i.e., the files and subdirectories inside of it:

```bash
chmod 0755 -R /etc/strfry
```

We can then change the ownership of the config directory to use the `nostr` user:

```bash
chown -R nostr:nostr /etc/strfry
```

## Data Directory

We're going to create a data directory for strfry in the `/var/lib` directory:

```bash
mkdir -p /var/lib/strfry/db
```

We can change the permissions of the data directory and all of its content, i.e., the files and subdirectories inside of it:

```bash
chmod 0755 -R /var/lib/strfry
```

We can then change the ownership of the data directory to use the `nostr` user:

```bash
chown -R nostr:nostr /var/lib/strfry
```

## Edit Config File

To change the relay settings you can open the file and edit the settings you want to change:

```bash
nano /etc/strfry/strfry.conf
```

Here are some of the settings you may want to change in the config file:

- `db` - The directory where your relay will store the LMDB database. The default value is set to `./strfry-db`. We'll set this to `/var/lib/strfry/db`. Restart required after updating.

- `bind` - The address your relay will listen on. The default value is `127.0.0.1`. To listen on all interfaces set this to `0.0.0.0`. Restart required after updating.

- `port` - The port your relay will use for the WebSocket connection. The default value is `7777`. Restart required after updating.

- `nofiles` - Sets the OS limit on the maximum number of open files/sockets. If set to `0`, strfry won't attempt to set this value. The default value is `1000000`. We'll set this to `0`. Restart required after updating.

- `realIpHeader` - Used to specify the HTTP header that contains the client's real IP before reverse proxying. The default value is `""`, and the input must be lowercase. We'll set this to `x-forwarded-for`.

- `name` - The name of your relay which will be shared with Nostr clients. Must be less than 30 characters. The default value is `strfry default`. We'll set this to `Relay Runner's strfry Relay`.

- `description` - A description of your relay. The default value is `This is a strfry instance.`. We'll set this to `This is a Relay Runner strfry instance`.

- `pubkey` - Your Nostr public key (32-byte hex, not npub) used for administrative requests. The default value is `""`. We'll set this to `3bcbb0f7dea9da9f5b2659ca5da89d5e576215de3885e51bd2474dd1b0c44b16`.

- `contact` - Alternative contact used for administrative requests. Can be an email or website and should be a URI using schemes like `mailto` or `https`. The default value is `""`. We'll set this to `mailto:devs@node-tec.com`.

- `icon` - URL to your relay's icon, e.g., `https://example.com/your-relay-icon.png`. It's recommended to be in squared shape.

- `nips` - List of NIPs supported by the relay. The value should be a JSON array, e.g., `[1,2]` or an empty string. The default value is `""`.
