# Nostr User

For security reasons we're going to create a separate user to use with our relay. This user will have ownership of various relay directories including the data directory, config directory, templates directory, etc.

Note that every relay implementation may not have all of those directories, but each relay directory will be owned by the user we're about to create.

## Create nostr User

We’re going to use the username `nostr` for the new user, and this user will have login disabled. Since we're using the `nostr` user as a service account for Nostr related services, the user doesn't require the ability to login. By setting the login to be disabled, no password is set for the user and login attempts are blocked.

To create the `nostr` user we can run:

```bash
adduser --disabled-login --gecos "" nostr
```

This command also creates a group with the same name as the provided username, i.e., `nostr` and adds the `nostr` user to the `nostr` group.

A home directory is also created for the user, i.e., `/home/nostr`.

The `--gecos` option is set to `""` which means we're leaving the contact information associated with the user empty.

If you prefer you can use a different user for each relay implementation you set up on your server, but we'll be using the `nostr` user for each of the relay implementations.
