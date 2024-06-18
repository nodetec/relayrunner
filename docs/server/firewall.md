# Firewall

You should allow traffic on port 80 and 443.

Check the status of the firewall:

```bash
ufw status
```

If only SSH is allowed you can allow HTTP and HTTPS traffic by running the following commands:

```bash
ufw allow 'Nginx Full'
```

![ufw status](../images/ufw-status.png)

