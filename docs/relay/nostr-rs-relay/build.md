# Build

We're now going to discuss how to build [nostr-rs-relay](https://github.com/scsibug/nostr-rs-relay "nostr-rs-relay").

## Dependencies

It's recommended to install the following packages before building the binary:

```bash
apt install build-essential cmake protobuf-compiler pkg-config libssl-dev
```

We also need to install Git to be able to clone the nostr-rs-relay repository:

```bash
apt install git
```

Lastly, we need to install Rust and Cargo to build the binary:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

After running the above command, you'll be asked if you want to proceed with the standard installation or if you want to customize the installation. We're going to use the standard installation, so when prompted just press enter.

To configure your current shell after installing Rust, you need to source the corresponding `env` file under `$HOME/.cargo`.

This can be accomplished for `sh`, `bash`, `zsh`, `ash`, `dash`, and `pdksh` using:

```bash
. "$HOME/.cargo/env"
```

To check Rust is installed and in your path:

```bash
rustc --version
```

To check cargo is installed and in your path:

```bash
cargo --version
```

## Clone the Repository

We'll be downloading the repository to the `/tmp` directory which is cleared when the system reboots. We’ll be downloading files associated with the installation of nostr-rs-relay here because we won’t need these files after the installation process is completed.

Here’s how to navigate to the `/tmp` directory:

```bash
cd /tmp
```

If you want to keep the nostr-rs-relay repository on your relay, then you can download the repository in a persistent directory, e.g., the `/root` directory.

We're now ready to clone the nostr-rs-relay repository:

```bash
git clone https://git.sr.ht/\~gheartsfield/nostr-rs-relay
```

After cloning the repository, navigate to the `nostr-rs-relay` directory:

```bash
cd nostr-rs-relay
```

## Build nostr-rs-relay

We're now ready to build a release version of nostr-rs-relay:

```bash
cargo build --release
```

The compilation could take a while depending on your server's specs, so be patient while the binary is being built.

When the compilation is finished the binary will be located in the `target/release` directory.

To navigate to that directory run the following:

```bash
cd target/release
```

You can list out the contents of that directory to see the binary:

```bash
ls
```

You should see the binary file which should be named `nostr-rs-relay`.

## Check Version

Here's how to check which version of nostr-rs-relay you've installed:

```bash
nostr-rs-relay --version
```

At the time of writing, the latest version of nostr-rs-relay is `0.9.0` which is what the rest of the guide is currently based on.

## Run Binary

You can now run the binary with logging enabled:

```bash
RUST_LOG=warn,nostr_rs_relay=info ./nostr-rs-relay
```

The nostr-rs-relay should now be listening on `0.0.0.0:8080`.

To stop the relay press `Ctrl+C`.
