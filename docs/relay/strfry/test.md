# Test your Relay

We'll use the CLI tool `nak` to test our relay. You can test the relay from the relay itself or from a separate device, e.g., your laptop.

If you don't have `nak` installed, you can do so by running:

```bash
go install github.com/fiatjaf/nak@latest
```

If you don't have Go installed on the device you want to test the relay from, you can download the latest release and learn how to install it on your preferred device from the [Download and install](https://go.dev/doc/install "Download and install") page.

## Test Event

First, we'll send an event to the relay:

```bash
nak event -c 'testing relay' relay.relayrunner.xyz
```

Be sure to replace `relay.relayrunner.xyz` with the domain you set up with your relay.

Now we'll check if the event was received by the relay:

```bash
nak req -k 1 -l 1 relay.relayrunner.xyz
```

You should see an event with the content `testing relay`.

```json
{
  "kind": 1,
  "id": "d75f6835bb59c481458b6ca1ffb8b92df15f3869797fd2ca64c1af898e9bdc47",
  "pubkey": "79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798",
  "created_at": 1728765020,
  "tags": [],
  "content": "testing relay",
  "sig": "78f2ed8998e16b2316854bbbebba76b2da43db6b56a71e6218a9d235b4903ca170b62f5a39e1a111074e509c24ba831d90e271684ca0c1c0ea1d4d665f9340b7"
}
```
