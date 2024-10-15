# Introduction

The repository [relay29](https://github.com/fiatjaf/relay29 "relay29") is a library for creating [NIP-29](https://github.com/nostr-protocol/nips/blob/master/29.md "NIP-29") relay-based groups. Since NIP-29 requires relays to have more of an active role in making the groups work with the rules, the relay29 library can be used to handle these requirements.

The relay29 library currently supports [Khatru](https://github.com/fiatjaf/khatru "Khatru") using the [Khatru29](https://pkg.go.dev/github.com/fiatjaf/relay29/khatru29 "Khatru29") wrapper, [strfry](https://github.com/hoytech/strfry "strfry") using the [strfry29](https://github.com/fiatjaf/relay29/tree/master/strfry29 "strfry29") plugin, and [relayer](https://github.com/fiatjaf/relayer "relayer") using [relayer29](https://github.com/fiatjaf/relay29/blob/master/relayer29 "relayer29").

In this guide we'll be demonstrating how to use the strfry29 plugin to set up a strfry relay with support for relay-based groups. We'll specifically be implementing the `strfry29` example provided by the relay29 repository. The steps provided here should work for other strfry29 examples as well.