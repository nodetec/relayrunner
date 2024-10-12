# Intro

[strfry](https://github.com/hoytech/strfry "strfry") is a relay implementation written in C++ that supports multiple NIPs and has numerous features.

## Features

strfry features include:

- Support for most applicable [NIPs](https://github.com/nostr-protocol/nips "NIPs"): 1, 2, 4, 9, 11, 22, 28, 40, 70, 77

- No external database required: All data is stored locally on the filesystem in a Lightning Memory-Mapped Database (LMDB)

- Hot reloading of config file: No server restart needed for many config param changes

- Zero downtime restarts, for upgrading binary without impacting users

- WebSocket compression using `permessage-deflate` with optional sliding window, when supported by clients. Optional on-disk compression using zstd dictionaries.

- Durable writes: The relay never returns an `OK` until an event has been confirmed as committed to the DB

- Built-in support for real-time streaming (up/down/both) events from remote relays, and bulk import/export of events from/to jsonl files

- [negentropy](https://github.com/hoytech/negentropy "negentropy") based set reconciliation for efficient syncing with clients or between relays, accurate counting of events between relays, and more
