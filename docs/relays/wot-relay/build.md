# Build

We're now going to discuss how to build the [WoT Relay](https://github.com/bitvora/wot-relay "WoT Relay").

## Dependencies

Before building the binary, we need to install Go, Git, and build-essential.

To install build-essential run:

```bash
apt install build-essential
```

We need to install Git to be able to clone the WoT Relay repository:

```bash
apt install git
```

We're now going to discuss how to install Go on your relay.

First, you need to determine which version of Go you want to install which you can do by going to the [All releases](https://go.dev/dl "All releases") page on the Go website.

Make sure to choose the appropriate download file for your relay's operating system (OS) and architecture. Since we're using Debian with an AMD processor, we're going to download the `linux-amd64` file.

At the time of writing the current version of Go is `1.23.2`, so we'll be downloading the `go1.23.2.linux-amd64.tar.gz` file.

We'll be downloading the file to the `/tmp` directory which is cleared when the system reboots. We’ll be downloading the file here because we won’t need this file after the installation process is completed.

Since we're using a headless server, we can use the `wget` command to download Go:

```bash
wget -P /tmp https://go.dev/dl/go1.23.2.linux-amd64.tar.gz
```

Be sure to replace `go1.23.2.linux-amd64.tar.gz` with whatever version of Go you're downloading and with whatever architecture you're using.

Before extracting the contents of the file, be sure to first remove any previously installed version of Go:

```bash
rm -rf /usr/local/go
```

You can now extract the contents of the file into the `/usr/local` directory:

```bash
tar -C /usr/local -xzf /tmp/go1.23.2.linux-amd64.tar.gz
```

Be sure to not extract the contents into an already existing `/usr/local/go` directory since this can break the Go installation.

After successfully extracting the contents, you should see a `go` directory in the `/usr/local` directory:

```bash
ls /usr/local
```

You can now add `/usr/local/go/bin` to the `PATH` environment variable by adding `export PATH=$PATH:/usr/local/go/bin` to your `$HOME/.bashrc` file.

First open the file with a text editor of your choice, e.g., `nano`:

```bash
nano $HOME/.bashrc
```

Then add the following to the end of the file:

```bash
export PATH=$PATH:/usr/local/go/bin
```

Save the changes made to the `.bashrc` file and exit the editor.

The changes may not take effect until after you log back into the server.

To apply the changes immediately run:

```bash
source $HOME/.bashrc
```

Verify the installation was successful by running:

```bash
go version
```

The command should output:

```bash
go version go1.23.2 linux/amd64
```

## Clone the Repository

We'll be downloading the repository to the `$HOME` directory.

Navigate to the `$HOME` directory:

```bash
cd $HOME
```

We're now ready to clone the WoT Relay repository:

```bash
git clone https://github.com/bitvora/wot-relay.git
```

After cloning the repository, navigate to the `wot-relay` directory:

```bash
cd wot-relay
```

You can use the repository to update the WoT Relay, so we're going to keep the repository on the relay.

## Build WoT Relay

We're now ready to build the WoT Relay:

```bash
go build -ldflags "-X main.version=$(git describe --tags --always)"
```

The compilation could take a while depending on your server's specs, so be patient while the binary is being built.

When the compilation is finished the binary will be located in the `wot-relay` directory.

You can list out the contents of that directory to see the binary:

```bash
ls
```

You should see the binary file which should be named `wot-relay`.

## Version

At the time of writing, the latest version of the WoT Relay is `v0.1.13` which is what the rest of the guide is currently based on.

## Run Binary

You can now run the binary:

```bash
RELAY_NAME="Relay Runner's WoT Relay" RELAY_PUBKEY="3bcbb0f7dea9da9f5b2659ca5da89d5e576215de3885e51bd2474dd1b0c44b16" RELAY_DESCRIPTION="Only notes in relayrunner WoT" RELAY_URL="wss://relay.relayrunner.xyz" DB_PATH="db" INDEX_PATH="templates/index.html" STATIC_PATH="templates/static" ARCHIVAL_SYNC="FALSE" ARCHIVE_REACTIONS="FALSE" ./wot-relay
```

Be sure to replace the values of the following:

- `RELAY_NAME` with the name you're going to use with your relay

- `RELAY_PUBKEY` with the pubkey you're using with your relay

- `RELAY_DESCRIPTION` with the description you're going to use with your relay

- `RELAY_URL` with the domain name of your server prefixed by `wss` if you set up an SSL/TLS certificate or `ws` if you didn't set up a certificate

The Wot Relay should now be listening on `localhost:3334`. A relay database will be created in your current directory called `db`.

To stop the relay press `Ctrl+C`.
