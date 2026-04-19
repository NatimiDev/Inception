# User Documentation — Inception

## What is this project?

This project runs a complete WordPress website accessible at:
```
https://nmikuka.42.fr
```

---

## Accessing the Website

Open your browser and go to:
```
https://nmikuka.42.fr
```

> You will see a security warning because the SSL certificate is self-signed. Click "Advanced" and "Accept the risk" to proceed — this is expected.

---

## Accessing the Administration Panel

Go to:
```
https://nmikuka.42.fr/wp-admin
```

Log in with the admin credentials from your `.env` file.

---

## Credentials

All credentials are stored in:
```
~/Inception/srcs/.env
```

| Variable | Description |
|----------|-------------|
| `WP_ADMIN` | WordPress admin username |
| `WP_ADMIN_PASSWORD` | WordPress admin password |
| `WP_ADMIN_EMAIL` | WordPress admin email |
| `WP_USER` | WordPress regular user username |
| `WP_USER_PASSWORD` | WordPress regular user password |
| `WP_USER_EMAIL` | WordPress regular user email |

> **Important:** Never share or commit this file. It is excluded from git via `.gitignore`.

---

## Checking That the Website Is Running

Open your browser and visit:
```
https://nmikuka.42.fr
```

If the site loads, everything is working. If not, contact your administrator or refer to the DEV_DOC.md for technical troubleshooting.
