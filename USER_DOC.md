# User Documentation — Inception

## What is this project?

This project runs a complete WordPress website using three services:

| Service | Role |
|---------|------|
| **Nginx** | Web server — the only entry point, handles secure HTTPS connections |
| **WordPress** | The website and content management system (CMS) |
| **MariaDB** | The database that stores all WordPress content |

All services run inside Docker containers on a virtual machine.

---

## Starting and Stopping the Project

### Start the project
```bash
cd ~/Inception
make
```
This will build and start all three services. Wait until you see all containers running.

### Stop the project
```bash
make down
```
This stops all containers. Your data is preserved.

### Restart fresh
```bash
make re
```
This stops everything, removes volumes, and starts again from scratch. **Warning: this will delete all WordPress content and database data. !!!COULD TAKE SOME MINUTES!!!**

---

## Accessing the Website

### From inside the VM
Open a browser and go to:
```
https://nmikuka.42.fr
```

### From your host machine (Mac)
First add the domain to your hosts file:
```bash
sudo nano /etc/hosts
```
Add:
```
192.168.64.x    nmikuka.42.fr
```
Then visit:
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

Log in with the admin credentials from your `.env` file (see below).

---

## Credentials

All credentials are stored in the `.env` file located at:
```
~/Inception/srcs/.env
```

| Variable | Description |
|----------|-------------|
| `MYSQL_DATABASE` | WordPress database name |
| `MYSQL_USER` | Database user for WordPress |
| `MYSQL_PASSWORD` | Database user password |
| `MYSQL_ROOT_PASSWORD` | MariaDB root password |
| `WP_ADMIN` | WordPress admin username |
| `WP_ADMIN_PASSWORD` | WordPress admin password |
| `WP_ADMIN_EMAIL` | WordPress admin email |
| `WP_USER` | WordPress regular user username |
| `WP_USER_PASSWORD` | WordPress regular user password |
| `WP_USER_EMAIL` | WordPress regular user email |

> **Important:** Never share or commit this file. It is excluded from git via `.gitignore`.

---

## Checking That Services Are Running

### Check all containers are up
```bash
docker ps
```
You should see three containers running:
- `srcs-nginx-1`
- `srcs-wordpress-1`
- `srcs-mariadb-1`

### Check logs for a specific service
```bash
docker logs srcs-nginx-1
docker logs srcs-wordpress-1
docker logs srcs-mariadb-1
```

### Check MariaDB is working
```bash
docker exec -it srcs-mariadb-1 mysql -u root -p
```
Enter your root password, then:
```sql
SHOW DATABASES;
SELECT user, host FROM mysql.user;
```

### Check WordPress files are present
```bash
ls /home/nmikuka/data/wordpress
```

### Check MariaDB data is present
```bash
ls /home/nmikuka/data/mariadb
```
