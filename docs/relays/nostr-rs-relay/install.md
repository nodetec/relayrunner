# Install

After building the binary, we're now going to "install" nostr-rs-relay by using the `install` command.

We’re actually not installing nostr-rs-relay though since the `install` command isn’t used to install software packages despite its name.

The `install` command is a way to copy files to a target location similar to the copy command, i.e., `cp`, but it gives us more control by allowing us to use advanced features when copying the files.

Some of these advanced features include the abilities to adjust permission modes like when using the `chmod` command, adjust ownership permissions like when using the `chown` command, to make backups of the files, and to preserve the metadata of the files, e.g., the access and modifications times of the files.

We're going to be "installing" the `nostr-rs-relay` binary to the `/usr/local/bin` directory which allows us to run the binary from any directory. This makes running the binary easier since we don't have to navigate to or specify the path to the `nostr-rs-relay` binary every time we want to run it.

First, navigate to the directory where you installed the binary, e.g.,

```bash
cd $HOME/nostr/relays/nostr-rs-relay/target/release
```

To "install" nostr-rs-relay we can run:

```bash
install -v -m 0755 -o root -g root -t /usr/local/bin nostr-rs-relay
```

Here’s an explanation of the options we passed to the `install` command:

`-v`: This option specifies that we would like to see the verbose output which means we’ll be displayed with the details of the process.

`-m`: This option specifies the file permissions in octal notation for the files we’re copying, i.e., `0755`.

`-o`: This option allows us to set the owner for the files we’re copying, i.e., `root`.

`-g`: This option allows us to set the group for the files we’re copying, i.e., `root`.

`-t`: This option specifies the target directory that we want to copy the specified files into, i.e., `/usr/local/bin`.

## Clean Compilation Artifacts

Once the binary has been successfully compiled and installed, you can reclaim disk space by cleaning up the compilation artifacts produced when building the binary.

To reclaim the disk space, first navigate to the directory where you downloaded the nostr-rs-relay repository, e.g.,

```bash
cd $HOME/nostr/relays/nostr-rs-relay
```

You can now clean the compilation artifacts by running:

```bash
cargo clean
```

## Uninstall Compiler Tools

You can reclaim more disk space by removing the `.rustup` directory located in the `$HOME` directory:

```bash
rm -rf $HOME/.rustup
```
