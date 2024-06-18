# Remote Access

You will need to access your server remotely to install software, update the server, and manage the relay. This guide will show you how to access your server using SSH.

## Login to your server

You will need to login to your server using SSH. You can do this by running the following command:

```bash
ssh root@relayrunner.xyz # replace with your domain name
```

![SSH into server](../images/ssh-into-server.png)

You will be prompted to enter your password. You can find the password in your server details.

![Server Password](../images/server-password.png)

### [Optional] Login with ssh key

If you have a ssh key you can use that instead of a password. You can add your ssh key to your server by running the following command:

```bash
ssh-copy-id root@relayrunner.xyz # replace with your domain name
```

![SSH copy id](../images/ssh-copy-id.png)

Now you can login to your server without a password.

If you'd like to disable password login you can do so by editing the sshd config file:

```bash
nano /etc/ssh/sshd_config
```

Find the line that says `#PasswordAuthentication yes` uncomment it and change it to `PasswordAuthentication no`. 

Find the line that says `UsePAM yes` and change it to `UsePAM no`.

Then reload the ssh service:

```bash
systemctl reload sshd
```
