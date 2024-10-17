# Build

We're now going to discuss how to build the [strfry29](https://github.com/fiatjaf/relay29/tree/master/strfry29 "strfry29") plugin.

## Dependencies

Before building the binary, we need to install the dependencies.

### strfry

Since strfry29 is a plugin for strfry, you need to first make sure you have properly installed and configured strfry before continuing.

You can follow along with the [strfry guide](/relays/strfry/intro/ "strfry guide") to install and configure strfry.

### Go

After setting up strfry, we need to now install Go. The strfry29 plugin we're using is written in Go, so we need to install Go to be able to build the binary.

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

Before cloning the relay29 repository, we're going to first create the following directories in the `$HOME` directory:

```bash
mkdir -p $HOME/nostr/relays
```

We can now navigate to the `relays` directory:

```bash
cd $HOME/nostr/relays
```

We're now ready to clone the relay29 repository:

```bash
git clone https://github.com/fiatjaf/relay29.git
```

After cloning the repository, navigate to the `relay29/strfry29` directory:

```bash
cd relay29/strfry29
```

You can use the repository to update strfry29, so we're going to keep the repository on the relay.

## Build strfry29

We're now ready to build the `strfry29` example:

```bash
go build
```

The compilation could take a while depending on your server's specs, so be patient while the binary is being built.

When the compilation is finished the binary will be located in the `relay29/strfry29` directory.

You can list out the contents of that directory to see the binary:

```bash
ls
```

You should see the binary file which should be named `strfry29`.

## Version

At the time of writing, the latest version of the relay29 library is `v0.4.0` which is what the rest of the guide is currently based on.

## Run Binary

Before we can run the strfry binary which uses the strfry config file, the strfry29 binary, and the `strfry29.json` file located in the `$HOME/relay29/strfry29` directory, we need to first create the strfry data directory specified in the strfry config file, i.e., `strfry-db`.

To create the strfry data directory run:

```bash
mkdir strfry-db
```

You can now run the binary:

```bash
strfry relay
```

strfry should now be listening on `127.0.0.1:52929` and by default only accepts connections from localhost.

To stop the relay press `Ctrl+C`.
