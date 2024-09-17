<div align="center"><p>
    <h1>Relay Runner 📡</h1>
    <a href="https://github.com/nodetec/relayrunner/pulse">
      <img alt="Last commit" src="https://img.shields.io/github/last-commit/nodetec/relayrunner?style=for-the-badge&logo=starship&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/nodetec/relayrunner/stargazers">
      <img alt="Stars" src="https://img.shields.io/github/stars/nodetec/relayrunner?style=for-the-badge&logo=starship&color=c69ff5&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/nodetec/relayrunner/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/nodetec/relayrunner?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/nodetec/relayrunner">
      <img alt="Repo size" src="https://img.shields.io/github/repo-size/nodetec/relayrunner?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" />
    </a>
</div>

Become a relay runner, help decentralize [Nostr](https://nostr.com/ "Nostr"), and take control of your data.

[Relay Runner](https://relayrunner.org "Relay Runner") will guide you through the process of setting up various relay implementations from scratch.

You'll learn how to:

- Get a server

- Get a domain name

- Set up remote access using SSH

- Configure nginx

- Set up a firewall

- Obtain and set up an SSL/TLS certificate

- Build the relay software

- Install the relay software

- Configure your relay

- Set up a systemd service for your relay

## Contribute

This site use [MKDocs Material](https://squidfunk.github.io/mkdocs-material/ "MKDocs Material").

To get started, fork and clone the repository, then run the following commands:

Enter the project directory:

```bash
cd relayrunner
```

Create a virtual environment:

```bash
python3 -m venv env
```

Active the virtual environment:

```bash
source env/bin/activate
```

Install the `cairo` package (macOS):

```bash
brew install cairo
```

Install python dependencies:

```bash
pip install -r requirements.txt
```

To run the site locally, run the following command:

```bash
mkdocs serve
```

The documentation is written in markdown and can be found in the `docs` directory.

You will also need to edit the `mkdocs.yml` file to add new pages to the site.
