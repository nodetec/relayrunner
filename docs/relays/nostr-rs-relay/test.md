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
  "id": "89a20a4624b9992c2a36ec88b1688b4ce067ef2a5dcc10b8b8d73c6ca5da0103",
  "pubkey": "79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798",
  "created_at": 1718724431,
  "tags": [],
  "content": "testing relay",
  "sig": "74132c07997795a2b8ffcbb50a04157f7d40b33208f2f1f8f935cd688a97c5526a6ebae9116b1065c2fb6360818a51cad2f4679806d6b32d1f5718e9e22a3ff0"
}
```
