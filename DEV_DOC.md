# Developer Documentation — Inception

## Prerequisites

- UTM or VirtualBox
- Debian 12 Bookworm VM (20GB disk, 2GB RAM)
- Docker CE & Docker Compose V2
- make
- git

Install all at once:
```bash
sudo apt install openssh-server git make -y
```

For Docker CE installation see README.md.

---

## Environment Setup

### 1. Clone the repository
```bash
git clone git@github.com:NatimiDev/Inception.git
cd Inception
```

### 2. Create the .env file
The `.env` file is not included in the repository (excluded via `.gitignore`). You must create it manually:
```bash
nano srcs/.env
```
```env
MYSQL_DATABASE=wordpress
MYSQL_USER=youruser
MYSQL_PASSWORD=yourpassword
MYSQL_ROOT_PASSWORD=yourrootpassword

DOMAIN_NAME=nmikuka.42.fr

WP_ADMIN=youradmin
WP_ADMIN_PASSWORD=youradminpassword
WP_ADMIN_EMAIL=youradmin@student.42.fr

WP_USER=youruser2
WP_USER_PASSWORD=youruserpassword
WP_USER_EMAIL=youruser2@student.42.fr
```

> **Note:** `WP_ADMIN` must not contain `admin`, `Admin`, `administrator` or `Administrator`.

### 3. Add domain to hosts
```bash
sudo nano /etc/hosts
```
Add:
```
192.168.64.x    nmikuka.42.fr
```

---

## Building and Launching

### Using the Makefile

| Command | Description |
|---------|-------------|
| `make` or `make all` | Build images and start all containers in background |
| `make dev` | Build and start with live logs in terminal |
| `make down` | Stop and remove containers |
| `make re` | Full restart — cleans everything and rebuilds |
| `make clean` | Remove containers and images |
| `make fclean` | Remove everything including data directories |

> `make all` automatically creates `/home/nmikuka/data/mariadb` and `/home/nmikuka/data/wordpress` if they don't exist.

### Using Docker Compose directly
```bash
# Build and start in background
docker compose -f srcs/docker-compose.yml up --build -d

# Start with logs
docker compose -f srcs/docker-compose.yml up --build

# Stop
docker compose -f srcs/docker-compose.yml down

# Stop and remove volumes
docker compose -f srcs/docker-compose.yml down -v
```

---

## Managing Containers

### List running containers
```bash
docker ps
```

### Enter a container shell
```bash
docker exec -it srcs-nginx-1 bash
docker exec -it srcs-wordpress-1 bash
docker exec -it srcs-mariadb-1 bash
```

### View container logs
```bash
docker logs srcs-nginx-1
docker logs srcs-wordpress-1
docker logs srcs-mariadb-1
```

### Follow logs in real time
```bash
docker compose -f srcs/docker-compose.yml logs -f
```

### Rebuild a single service
```bash
docker compose -f srcs/docker-compose.yml up --build nginx
docker compose -f srcs/docker-compose.yml up --build wordpress
docker compose -f srcs/docker-compose.yml up --build mariadb
```

---

## Managing Volumes

### List all volumes
```bash
docker volume ls
```

### Inspect a volume
```bash
docker volume inspect srcs_mariadb
docker volume inspect srcs_wordpress
```

### Remove all unused volumes
```bash
docker volume prune -f
```

---

## Data Persistence

All project data is stored on the VM at:

| Data | Path |
|------|------|
| MariaDB database files | `/home/nmikuka/data/mariadb` |
| WordPress files | `/home/nmikuka/data/wordpress` |

These are **bind mounts** — Docker maps these host directories directly into the containers. Data survives container restarts and rebuilds as long as these directories are not deleted.

To fully reset all data:
```bash
make fclean
make
```

---

## Project Structure

```
inception/
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
└── srcs/
    ├── docker-compose.yml
    ├── .env                  ← not in git, create manually
    └── requirements/
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/
        │       └── nginx.conf
        ├── mariadb/
        │   ├── Dockerfile
        │   ├── conf/
        │   │   └── 50-server.cnf
        │   └── tools/
        │       └── init.sh
        └── wordpress/
            ├── Dockerfile
            ├── conf/
            │   └── www.conf
            └── tools/
                └── setup.sh
```

### Key configuration files

| File | Purpose |
|------|---------|
| `srcs/docker-compose.yml` | Defines all services, networks, and volumes |
| `srcs/.env` | All credentials and environment variables |
| `nginx/conf/nginx.conf` | Nginx server config — TLS, PHP-FPM proxy |
| `mariadb/conf/50-server.cnf` | MariaDB server config — port, bind address |
| `mariadb/tools/init.sh` | Initializes database, user, and passwords on first run |
| `wordpress/conf/www.conf` | PHP-FPM pool config — listens on port 9000 |
| `wordpress/tools/setup.sh` | Downloads WordPress, configures and installs it via WP-CLI |

---

## Troubleshooting

### Containers not starting
```bash
docker compose -f srcs/docker-compose.yml logs
```

### MariaDB access denied (error 1045)
Happens when old data exists with different credentials. Full reset:
```bash
make fclean
make
```

### Port 443 already in use
```bash
sudo lsof -i :443
```
Kill the process using it or stop any other web server running on the host.

### WordPress shows PHP source code instead of rendering
The PHP location block in `nginx.conf` is commented out. Uncomment it and rebuild nginx.

### Cannot connect to MariaDB from WordPress
Check that both containers are on the same network:
```bash
docker network inspect srcs_inception
```
