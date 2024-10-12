# Upgrade

To upgrade strfry navigate to the strfry repository, e.g.,

```bash
cd $HOME/strfry
```

Update the submodules:

```bash
make update-submodules
```

Now, run:

```bash
make -j4
```

Install strfry:

```bash
install -v -m 0755 -o root -g root -t /usr/local/bin strfry
```
