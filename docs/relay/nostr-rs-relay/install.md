# Install

We'll be using [nostr-rs-relay](https://github.com/scsibug/nostr-rs-relay/tree/master) for our relay.

## Prerequisites

The repository recommends installing the following dependencies:

```bash
apt install build-essential cmake protobuf-compiler pkg-config libssl-dev
```

We'll also need to install `git` and `rust` to clone and compile the repository.

Install git by running:

```bash
apt install git
```

Install rust by running:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

When asked, select option 1 to install the stable toolchain.

To configure your current shell after installing rust, run the following command (note you won't need to do this when logging in next time):

```bash
source $HOME/.cargo/env
```

## Clone the repository

Clone the repository and compile the relay:

```bash
cd /usr/local/src
git clone https://git.sr.ht/\~gheartsfield/nostr-rs-relay
cd nostr-rs-relay
cargo build --release
```

The compilation could take a while depending on your server's specs.

When finished the executable will be located at `target/release/nostr-rs-relay`.

## Install relay executable

You can use the install command to move the executable to a directory in your path to make it easier to run:

```bash
install target/release/nostr-rs-relay /usr/local/bin
```

## Create data directory

Create a directory to store the relay's data:

```bash
mkdir -p /var/lib/nostr-rs-relay/data
```
