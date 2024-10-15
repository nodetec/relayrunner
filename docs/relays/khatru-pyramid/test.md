# Test your Relay

We'll use the CLI tool `nak` to test our relay. You can test the relay from the relay itself or from a separate device, e.g., your laptop.

If you don't have `nak` installed, you can do so by running:

```bash
go install github.com/fiatjaf/nak@latest
```

If you don't have Go installed on the device you want to test the relay from, you can download the latest release and learn how to install it on your preferred device from the [Download and install](https://go.dev/doc/install "Download and install") page.

## Test Event

Since Khatru Pyramid uses an invite hierarchy, to test the relay we need to use the secret key of one of the public keys you have added to the `users.json` file. Initially, the file will contain the public key set in the `khatru-pyramid.env` file, so you can use that public key's secret key when testing your relay.

Be sure to sign the event securely, i.e., don't let anyone, any camera, etc. see your secret key, clear your clipboard if you're copying and pasting the value, turn off your terminal history, etc.

If you're using `bash`, you can temporarily turn off the history for the current shell session by running:

```bash
set +o history
```

If you're using `zsh`, you can turn off the history by running:

```bash
unset HISTFILE
```

Then send an event to the relay:

```bash
nak --sec <your-secret-key> event -c 'testing relay' relay.relayrunner.xyz
```

Be sure to replace `<your-secret-key>` with your secret key. The secret key can be passed as a hex, nsec, or ncryptsec. Also, be sure to replace `relay.relayrunner.xyz` with the domain you set up with your relay.

Check if the event was received by the relay:

```bash
nak req -k 1 -l 1 relay.relayrunner.xyz
```

You should see an event with the content `testing relay`:

```json
{
  "kind": 1,
  "id": "4571b153344adb8cd77a605ca99d0cd26c33d17eeb2ee4112d1dd5afc5bb8189",
  "pubkey": "df8cb2c6d7fbdf57bd08854efa1c1291c9355730512ef0573a844fb88b869a36",
  "created_at": 1728690813,
  "tags": [],
  "content": "testing relay",
  "sig": "9206e5538d16bb7a05d898a22104f44c3c9cfe9ef5fceb852b058bf93dd021bbfd28c22f5b67b2ce9e721f982d54671e6038ba6635835bbff367ba9e878228ba"
}
```

If you were able to successfully send an event to your relay and you're using `bash`, you can turn on the history for the current shell session by running:

```bash
set -o history
```

If you're using `zsh` you can exit the current shell session where the history is disabled by running:

```bash
exit
```
