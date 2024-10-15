# Build

We're now going to discuss how to build the binary for the [groups.fiatjaf.com](https://github.com/fiatjaf/relay29/tree/master/examples/groups.fiatjaf.com "groups.fiatjaf.com") example provided by the relay29 repository which uses the [Khatru29](https://pkg.go.dev/github.com/fiatjaf/relay29/khatru29 "Khatru29") wrapper.

## Dependencies

Before building the binary, we need to install Go and Git.

We need to install Git to be able to clone the relay29 repository:

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

We'll be downloading the repository to the `/tmp` directory since it's cleared when the system reboots, and we don't need the files associated with the relay29 repository after the installation process is completed.

Navigate to the `/tmp` directory:

```bash
cd /tmp
```

If you want to keep the relay29 repository on your relay, then you can download the repository in a persistent directory, e.g., your `$HOME` directory.

We're now ready to clone the relay29 repository:

```bash
git clone https://github.com/fiatjaf/relay29.git
```

After cloning the repository, navigate to the `relay29/examples/groups.fiatjaf.com` directory:

```bash
cd relay29/examples/groups.fiatjaf.com
```

## Build Khatru29 Example

We're now ready to build the `groups.fiatjaf.com` example which uses the Khatru29 wrapper:

```bash
go build
```

The compilation could take a while depending on your server's specs, so be patient while the binary is being built.

When the compilation is finished the binary will be located in the `relay29/examples/groups.fiatjaf.com` directory.

You can list out the contents of that directory to see the binary:

```bash
ls
```

You should see the binary file which should be named `groups.fiatjaf.com`.

We're going to use a more general name for the binary by renaming it to `khatru29`:

```bash
mv groups.fiatjaf.com khatru29
```

## Version

At the time of writing, the latest version of the relay29 library is `v0.4.0` which is what the rest of the guide is currently based on.

## Run Binary

To run Khatru29 you need to provide a secret key which will be used as the relay's private key.

Be sure to input your secret key securely, i.e., don't let anyone, any camera, etc. see your secret key, clear your clipboard if you're copying and pasting the value, turn off your terminal history on your server, etc.

The server terminal is using `bash`, so you can temporarily turn off the history for the current shell session by running:

```bash
set +o history
```

You can now run the binary:

```bash
DOMAIN="relay.relayrunner.xyz" RELAY_NAME="Relay Runner's Khatru29 Relay" RELAY_PRIVKEY="<your-secret-key>" ./khatru29
```

Be sure to replace `<your-secret-key>` with your secret key. The secret key can be passed as a 32-byte hex. Also, be sure to replace `relay.relayrunner.xyz` with the domain you set up with your relay.

Khatru29 should now be listening on `0.0.0.0:5577`. A relay database will also be created in your current directory called `db`.

To stop the relay press `Ctrl+C`.

If you were able to successfully run the binary, you can turn on the history for the current shell session by running:

```bash
set -o history
```
