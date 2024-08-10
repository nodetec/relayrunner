# Relay Runner

Become a relay runner, help decentralize nostr, and take control of your data.

## For Contributors

This site use [mkdocs material](https://squidfunk.github.io/mkdocs-material/).

To get started, fork and clone the repository then run the following commands:

- Enter the project directory

```bash
cd relayrunner
```

- Create a virtual environment

```bash
python3 -m venv env
```

- Active the virtual environment

```bash
source env/bin/activate
```

- Install the `cairo` package (MacOS)

```bash
brew install cairo
```

- Install python dependencies

```bash
pip install -r requirements.txt
```

To run the site locally, run the following command:

```bash
mkdocs serve
```

The documentation is written in markdown and can be found in the `docs` directory.

You will also need to edit the `mkdocs.yml` file to add new pages to the site.
