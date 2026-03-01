*This project has been created as part of the 42 curriculum by [nmikuka].*

---

# Inception

## Description

Inception is a system administration project from the 42 curriculum. The goal is to set up a small but complete web infrastructure using **Docker** and **Docker Compose**, running entirely inside a virtual machine.

The infrastructure consists of three services, each running in its own dedicated Docker container built from scratch using **Debian Bookworm**:

- **Nginx** — the only entry point, handles HTTPS with TLS 1.2/1.3
- **WordPress** — the CMS, running with PHP-FPM
- **MariaDB** — the database backend for WordPress

All containers communicate through a custom Docker bridge network. Data is persisted using bind mounts mapped to `/home/nmikuka/data/` on the host filesystem.

### Design Choices

#### Virtual Machines vs Docker
A **Virtual Machine** emulates an entire operating system with its own kernel and hardware abstraction. It is isolated at the hardware level but heavy in terms of resources and startup time.

**Docker** containers share the host kernel and isolate only the application layer using Linux namespaces and cgroups. Containers are lightweight, start in seconds, and are highly portable. For this project, Docker is the right tool because each service is isolated, reproducible, and easy to manage without the overhead of running multiple full VMs.

#### Secrets vs Environment Variables
**Environment variables** are simple key-value pairs passed to containers at runtime. They are easy to use but can be exposed via `docker inspect` or logs.

**Docker Secrets** are encrypted and only accessible to authorized services — the recommended approach for production.

For this project, environment variables via a `.env` file are used as required by the subject. The `.env` file is excluded from version control via `.gitignore`.

#### Docker Network vs Host Network
With **host network** mode, the container shares the host's network stack directly — no isolation, fastest performance, but a security risk.

With **Docker bridge network** (used in this project), each container gets its own virtual network interface and communicates through a private internal network. Only Nginx exposes port 443 to the outside world, providing proper isolation.

#### Docker Volumes vs Bind Mounts
**Docker volumes** are managed by Docker and stored in Docker's own directory — more portable and better for production.

**Bind mounts** map a specific host path directly into the container — simple and easy to inspect. This project uses bind mounts as required by the subject, with data stored at `/home/nmikuka/data/`.

---

## Instructions

For detailed setup and usage instructions, refer to the dedicated documentation files:

- **[USER_DOC.md](USER_DOC.md)** — How to start, stop, access the website, manage credentials, and check service health
- **[DEV_DOC.md](DEV_DOC.md)** — How to set up the environment, build the project, manage containers and volumes, and understand the project structure

### Quick Start
```bash
git clone https://github.com/nmikuka/inception.git
cd inception
cp srcs/.env.example srcs/.env  # fill in your credentials
mkdir -p /home/nmikuka/data/mariadb /home/nmikuka/data/wordpress
make
```

---

## Resources

### Documentation
- [Docker official documentation](https://docs.docker.com/)
- [Docker Compose documentation](https://docs.docker.com/compose/)
- [Nginx documentation](https://nginx.org/en/docs/)
- [MariaDB documentation](https://mariadb.com/kb/en/)
- [WordPress CLI documentation](https://wp-cli.org/)
- [PHP-FPM documentation](https://www.php.net/manual/en/install.fpm.php)
- [OpenSSL documentation](https://www.openssl.org/docs/)
- [Debian documentation](https://www.debian.org/doc/)

### Articles & Tutorials
- [Understanding Docker networking](https://docs.docker.com/network/)
- [Docker volumes vs bind mounts](https://docs.docker.com/storage/)
- [TLS/SSL explained](https://www.cloudflare.com/learning/ssl/what-is-ssl/)
- [PHP-FPM and Nginx setup](https://www.digitalocean.com/community/tutorials/understanding-and-implementing-fastcgi-proxying-in-nginx)
- [WordPress WP-CLI guide](https://make.wordpress.org/cli/handbook/)

### AI Usage
**Claude (Anthropic)** was used throughout this project for:
- Setting up the VM and configuring Debian from scratch
- Writing and debugging Dockerfiles for all three services
- Writing and debugging shell scripts for MariaDB and WordPress setup
- Configuring Nginx with TLS and PHP-FPM
- Writing the docker-compose.yml and understanding networking concepts
- Understanding design choices (VMs vs Docker, secrets vs env vars, networks, volumes)
- Writing this README and the documentation files

AI was used as a learning and debugging assistant. All code was reviewed, understood, and adapted by the student.
