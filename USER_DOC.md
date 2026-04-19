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

> You will see a security warning because the SSL certificate is self-signed. Click **"Advanced"** and **"Accept the risk"** to proceed — this is expected behavior.

You should see the WordPress homepage.

---

## Accessing the Administration Panel

Go to:
```
https://nmikuka.42.fr/wp-admin
```

Log in with your admin credentials (see Credentials section below).

From the admin panel you can:
- Create, edit, and delete posts and pages
- Manage users
- Install themes and plugins
- Configure site settings

---

## Credentials

All credentials are stored in:
```
~/Inception/srcs/.env
```

### WordPress credentials

| Variable | Description |
|----------|-------------|
| `WP_ADMIN` | Admin username — use to log in at `/wp-admin` |
| `WP_ADMIN_PASSWORD` | Admin password |
| `WP_ADMIN_EMAIL` | Admin email |
| `WP_USER` | Regular author username |
| `WP_USER_PASSWORD` | Regular author password |
| `WP_USER_EMAIL` | Regular author email |

### Database credentials (for reference)

| Variable | Description |
|----------|-------------|
| `MYSQL_DATABASE` | WordPress database name |
| `MYSQL_USER` | Database user |
| `MYSQL_PASSWORD` | Database user password |
| `MYSQL_ROOT_PASSWORD` | MariaDB root password |

> **Important:** Never share or commit this file. It is excluded from git via `.gitignore`.

---

## Basic Checks

### Is the website up?
Open your browser and visit:
```
https://nmikuka.42.fr
```
If the WordPress homepage loads — everything is working.

### Is the admin panel accessible?
Visit:
```
https://nmikuka.42.fr/wp-admin
```
If you can log in — WordPress and the database are both working correctly.

### Are the containers running?
```bash
docker ps
```
You should see three containers:
- `srcs-nginx-1`
- `srcs-wordpress-1`
- `srcs-mariadb-1`

### Check logs for a specific service
```bash
docker logs srcs-nginx-1
docker logs srcs-wordpress-1
docker logs srcs-mariadb-1
```

If something is not working, refer to **DEV_DOC.md** for technical troubleshooting.
