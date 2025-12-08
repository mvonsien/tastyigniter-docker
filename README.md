# TastyIgniter Docker

[![Docker](https://img.shields.io/badge/Docker-Ready-blue?logo=docker)](https://www.docker.com/)
[![TastyIgniter](https://img.shields.io/badge/TastyIgniter-v4.x-orange)](https://tastyigniter.com/)
[![PHP](https://img.shields.io/badge/PHP-8.3-purple?logo=php)](https://www.php.net/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

Docker configuration for [TastyIgniter](https://tastyigniter.com/) - A powerful open-source restaurant online ordering system.

## Features

- 🐳 **Docker Ready** - Easy deployment with Docker Compose
- 🚀 **TastyIgniter** - Configurable version (default: latest stable)
- 🐘 **PHP 8.3** - Modern PHP runtime with Apache
- 🗄️ **MariaDB 10.7** - Reliable database backend
- ⚡ **Redis 7** - High-performance caching
- 🔧 **Auto Installation** - Automated setup on first run

## Quick Start

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed
- [Docker Compose](https://docs.docker.com/compose/install/) installed

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/zscontributor/tastyigniter-docker.git
   cd tastyigniter-docker
   ```

2. **Start the containers**
   ```bash
   docker-compose up -d
   ```

3. **Wait for installation** (about 1-2 minutes for first run)
   ```bash
   docker-compose logs -f tastyigniter-app
   ```

4. **Access TastyIgniter**
   - **Frontend**: http://localhost:8001
   - **Admin Panel**: http://localhost:8001/admin

5. **Set admin password**
   ```bash
   docker-compose exec tastyigniter-app php artisan igniter:passwd admin
   ```

## Configuration

### Environment Variables

You can customize the following environment variables in `docker-compose.yml`:

| Variable | Default | Description |
|----------|---------|-------------|
| `APP_URL` | `http://localhost:8001` | Application URL |
| `DB_HOST` | `tastyigniter-database` | Database host |
| `DB_DATABASE` | `tastyigniter` | Database name |
| `DB_USERNAME` | `tastyigniter` | Database username |
| `DB_PASSWORD` | `tastyigniter` | Database password |
| `CACHE_DRIVER` | `redis` | Cache driver |
| `REDIS_HOST` | `tastyigniter-redis` | Redis host |

### Ports

| Service | Port |
|---------|------|
| TastyIgniter | 8001 |
| MariaDB | 3306 (internal) |
| Redis | 6379 (internal) |

### TastyIgniter Version

To change the TastyIgniter version, edit the `TASTYIGNITER_VERSION` in `Dockerfile`:

```dockerfile
ENV TASTYIGNITER_VERSION 4.0.4
```

Then rebuild the image:
```bash
docker-compose build --no-cache
docker-compose up -d
```

## Project Structure

```
tastyigniter-docker/
├── Dockerfile              # PHP 8.3 + Apache image configuration
├── docker-compose.yml      # Multi-container orchestration
├── docker-entrypoint.sh    # Container startup script
├── .htaccess               # Apache rewrite rules
└── README.md               # This file
```

## Building from Source

To build the Docker image locally:

```bash
docker-compose build --no-cache
docker-compose up -d
```

## Useful Commands

```bash
# View logs
docker-compose logs -f tastyigniter-app

# Access container shell
docker-compose exec tastyigniter-app bash

# Clear cache
docker-compose exec tastyigniter-app php artisan cache:clear

# Run artisan commands
docker-compose exec tastyigniter-app php artisan <command>

# Stop containers
docker-compose down

# Stop and remove volumes (reset database)
docker-compose down -v
```

## Troubleshooting

### Permission Issues
If you encounter permission errors, run:
```bash
docker-compose exec tastyigniter-app chown -R www-data:www-data /var/www/html/storage
docker-compose exec tastyigniter-app chmod -R 775 /var/www/html/storage
```

### Database Connection Refused
Wait a few seconds for MariaDB to fully start, then restart the app container:
```bash
docker-compose restart tastyigniter-app
```

### Clear All and Reinstall
```bash
docker-compose down -v
docker-compose up -d
```

## Author

**Z-SOFT CO., LTD**

- 🌐 Website: [https://z-soft.com.vn](https://z-soft.com.vn)
- 📧 Email: contact@z-soft.com.vn
- 🐙 GitHub: [https://github.com/zscontributor](https://github.com/zscontributor)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Made with ❤️ by <a href="https://z-soft.com.vn">Z-SOFT CO., LTD</a>
</p>
