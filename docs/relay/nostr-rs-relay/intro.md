# Intro

The [nostr-rs-relay](https://github.com/scsibug/nostr-rs-relay "nostr-rs-relay") is written in Rust, and at the time of writing it supports most of the relay protocol. The relay data is persisted using SQLite, and there is experimental support for PostgreSQL.

The repository is available on [sourcehut](https://sr.ht/~gheartsfield/nostr-rs-relay "sourcehut"), and is mirrored on [GitHub](https://github.com/scsibug/nostr-rs-relay "GitHub").

## Features

[NIPs](https://github.com/nostr-protocol/nips "NIPs") with a relay-specific implementation are listed here.

- [x] NIP-01: [Basic protocol flow description](https://github.com/nostr-protocol/nips/blob/master/01.md "Basic protocol flow description")

  - Core event model
  - Hide old metadata events
  - Id/Author prefix search

- [x] NIP-02: [Follow List](https://github.com/nostr-protocol/nips/blob/master/02.md "Follow List")

- [ ] NIP-03: [OpenTimestamps Attestations for Events](https://github.com/nostr-protocol/nips/blob/master/03.md "OpenTimestamps Attestations for Events")

- [x] NIP-05: [Mapping Nostr keys to DNS-based internet identifiers](https://github.com/nostr-protocol/nips/blob/master/05.md "Mapping Nostr keys to DNS-based internet identifiers")

- [x] NIP-09: [Event Deletion Request](https://github.com/nostr-protocol/nips/blob/master/09.md "Event Deletion Request")

- [x] NIP-11: [Relay Information Document](https://github.com/nostr-protocol/nips/blob/master/11.md "Relay Information Document")

- [x] NIP-12: [Generic Tag Queries](https://github.com/nostr-protocol/nips/blob/master/12.md "Generic Tag Queries")

- [x] NIP-15: [Nostr Marketplace](https://github.com/nostr-protocol/nips/blob/master/15.md "Nostr Marketplace")

- [x] NIP-16: [Event Treatment](https://github.com/nostr-protocol/nips/blob/master/16.md "Event Treatment")

- [x] NIP-20: [Command Results](https://github.com/nostr-protocol/nips/blob/master/20.md "Command Results")

- [x] NIP-22: [Event `created_at` limits](https://github.com/nostr-protocol/nips/blob/master/22.md "Event `created_at` limits") (_future-dated events only_)

- [ ] NIP-26: [Delegated Event Signing](https://github.com/nostr-protocol/nips/blob/master/26.md "Delegated Event Signing") (_implemented, but currently disabled_)

- [x] NIP-28: [Public Chat](https://github.com/nostr-protocol/nips/blob/master/28.md "Public Chat")

- [x] NIP-33: [Parameterized Replaceable Events](https://github.com/nostr-protocol/nips/blob/master/33.md "Parameterized Replaceable Events")

- [x] NIP-40: [Expiration Timestamp](https://github.com/nostr-protocol/nips/blob/master/40.md "Expiration Timestamp")

- [x] NIP-42: [Authentication of clients to relays](https://github.com/nostr-protocol/nips/blob/master/42.md "Authentication of clients to relays")
