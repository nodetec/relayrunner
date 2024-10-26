# Configuration

We're now going to discuss the strfry config file that we'll be using with strfry29. We'll go over how to set some of the settings as well as how to copy the file to a config directory owned by the `nostr` user we previously created. We're also going to discuss how to create the data directory which will be owned by the `nostr` user.

Along with the strfry config file, we also have a `strfry29.json` file. This file contains settings specific to strfry29. We'll go over how to set the settings as well as how to copy the file to the `/usr/local/bin` directory which is where the strfry29 binary is located. Currently, the strfry29 binary expects the `strfry29.json` file to be located in the same directory which is why we're moving it to the `/usr/local/bin` directory.

## Config File

The strfry config file is located in the relay29 repository we cloned and is named `strfry.conf`. In our case the file is located in the following directory `$HOME/nostr/relays/relay29/strfry29`.

To view the settings you can open the file:

```bash
nano $HOME/nostr/relays/relay29/strfry29/strfry.conf
```

## Config Directory

We're going to create a config directory for strfry29 in the `/etc` directory:

```bash
mkdir /etc/strfry29
```

We can now copy the config file to the config directory:

```bash
cp $HOME/nostr/relays/relay29/strfry29/strfry.conf /etc/strfry29
```

We can change the permissions of the config directory and all of its content, i.e., the files and subdirectories inside of it:

```bash
chmod 0755 -R /etc/strfry29
```

We can then change the ownership of the config directory to use the `nostr` user:

```bash
chown -R nostr:nostr /etc/strfry29
```

## Data Directory

We're going to create a data directory for strfry29 in the `/var/lib` directory:

```bash
mkdir -p /var/lib/strfry29/db
```

We can change the permissions of the data directory and all of its content, i.e., the files and subdirectories inside of it:

```bash
chmod 0755 -R /var/lib/strfry29
```

We can then change the ownership of the data directory to use the `nostr` user:

```bash
chown -R nostr:nostr /var/lib/strfry29
```

## strfry29.json File

The `strfry29.json` file is located in the relay29 repository we cloned. In our case the file is located in the following directory `$HOME/nostr/relays/relay29/strfry29`.

To view the settings you can open the file:

```bash
nano $HOME/nostr/relays/relay29/strfry29/strfry29.json
```

We can now copy the `strfry29.json` file to the `/usr/local/bin` directory:

```bash
cp $HOME/nostr/relays/relay29/strfry29/strfry29.json /usr/local/bin
```

## Edit Config File

To change the strfry settings you can open the file and edit the settings you want to change:

```bash
nano /etc/strfry29/strfry.conf
```

Here are some of the settings you may want to change in the config file:

- `db` - The directory where your relay will store the LMDB database. The default value is set to `"strfry-db/"`. We'll set this to `"/var/lib/strfry29/db"`. Restart required after updating.

- `bind` - The address your relay will listen on. The default value is `"127.0.0.1"`. To listen on all interfaces set this to `"0.0.0.0"`. Restart required after updating.

- `port` - The port your relay will use for the WebSocket connection. The default value is `52929`. Restart required after updating.

- `nofiles` - Sets the OS limit on the maximum number of open files/sockets. If set to `0`, strfry won't attempt to set this value. The default value is `0`. Restart required after updating.

- `realIpHeader` - Used to specify the HTTP header that contains the client's real IP before reverse proxying. The default value is `""`, and the input must be lowercase. We'll set this to `"x-forwarded-for"`.

- `name` - The name of your relay which will be shared with Nostr clients. Must be less than 30 characters. The default value is `"strfry29"`. We'll set this to `"Relay Runner's strfry29 Relay"`.

- `description` - A description of your relay. The default value is `"this is an strfry instance that only works with nip29 groups"`. We'll set this to `"This is a Relay Runner strfry29 instance that only works with NIP-29 groups."`.

- `pubkey` - Your Nostr public key (32-byte hex, not npub) used for administrative requests. The default value is `""`. We'll set this to `"3bcbb0f7dea9da9f5b2659ca5da89d5e576215de3885e51bd2474dd1b0c44b16"`.

- `contact` - Alternative contact used for administrative requests. Can be an email or website and should be a URI using schemes like `mailto` or `https`. The default value is `""`. We'll set this to `"mailto:devs@node-tec.com"`.

- `icon` - URL to your relay's icon, e.g., `https://example.com/your-relay-icon.png`. It's recommended to be in squared shape.

- `writePolicy` - If the value is non-empty, i.e., isn't set to `""`, the writePolicy plugin logic is determined by the provided path to an executable script. The default value is `plugin = "./strfry29"`. We'll set this to `plugin = "/usr/local/bin/strfry29"`.

## Edit strfry29.json File

To change the `strfry29.json` settings you can open the file and edit the settings you want to change:

```bash
nano /usr/local/bin/strfry29.json
```

Here are the settings you'll want to change in the file:

- `domain` - The domain name of your server. The default value is `example.com`. Be sure to replace the value with the domain you're using for your relay. We'll be using `relay.relayrunner.xyz`.

- `relay_secret_key` - Your Nostr private key (32-byte hex, not nsec) that you're using as the relay's private key. Be sure to input your secret key securely, i.e., don't let anyone, any camera, etc. see your secret key, clear your clipboard if you're copying and pasting the value, etc. Be sure to replace the default value with your secret key.

- `strfry_config_path` - The path to the strfry config file you're using with strfry29. The default value is `strfry.conf`. We'll set this to `/etc/strfry29/strfry.conf`.

- `strfry_executable_path` - The path to the strfry binary you're using with strfry29. The default value is `/usr/local/bin/strfry`.
