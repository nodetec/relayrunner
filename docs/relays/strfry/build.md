# Build

We're now going to discuss how to build [strfry](https://github.com/hoytech/strfry "strfry").

## Dependencies

Before building the binary, we need to install the following dependencies

```bash
apt install git g++ make libssl-dev zlib1g-dev liblmdb-dev libflatbuffers-dev libsecp256k1-dev libzstd-dev
```

## Clone the Repository

Before cloning the strfry repository, we're going to first create the following directories in the `$HOME` directory:

```bash
mkdir -p $HOME/nostr/relays
```

We can now navigate to the `relays` directory:

```bash
cd $HOME/nostr/relays
```

We're now ready to clone the strfry repository:

```bash
git clone https://github.com/hoytech/strfry.git
```

After cloning the repository, navigate to the `strfry` directory:

```bash
cd strfry
```

You can use the repository to update strfry, so we're going to keep the repository on the relay.

## Build strfry

We're now ready to build strfry.

First, initialize and update the git submodule:

```bash
git submodule update --init
```

Now, we're going to run:

```bash
make setup-golpe
```

Finally, run:

```bash
make -j4
```

The compilation could take a while depending on your server's specs, so be patient while the binary is being built.

When the compilation is finished the binary will be located in the `strfry` directory.

You can list out the contents of that directory to see the binary:

```bash
ls
```

You should see the binary file which should be named `strfry`.

## Version

At the time of writing, the latest version of strfy is `v1.0.1` which is what the rest of the guide is currently based on.

## Run Binary

You can now run the binary:

```bash
./strfry relay
```

strfry should now be listening on `127.0.0.1:7777` and by default only accepts connections from localhost. The relay uses the database in your current directory called `strfry-db` along with a config file called `strfry.conf` which is also located in your current directory.

To stop the relay press `Ctrl+C`.

### Troubleshooting

If you get the following error when running the binary:

```bash
strfry error: Unable to set NOFILES limit to 1000000, exceeds max of 524288
```

Open the strfry config file:

```bash
nano $HOME/nostr/relays/strfry/strfry.conf
```

Navigate to the line that says:

```bash
nofiles = 1000000
```

Set the `nofiles` setting to `0` which prevents strfry from attempting to set the value:

```bash
nofiles = 0
```

Save and exit the file.

You should now be able to run the binary.
