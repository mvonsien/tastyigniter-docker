#!/bin/bash
set -e

cd /var/www/html

# Fix permissions for storage and public directories
chown -R www-data:www-data /var/www/html/storage
chown -R www-data:www-data /var/www/html/public
chmod -R 775 /var/www/html/storage
chmod -R 775 /var/www/html/public

# Create .env file if it doesn't exist
if [ ! -f '/var/www/html/.env' ]; then
	if [ -f '/var/www/html/.env.example' ]; then
		cp /var/www/html/.env.example /var/www/html/.env
	else
		# Create minimal .env file with actual environment values
		cat > /var/www/html/.env << EOF
APP_NAME=TastyIgniter
APP_ENV=production
APP_KEY=
APP_DEBUG=false
APP_URL=${APP_URL:-http://localhost}

DB_CONNECTION=${DB_CONNECTION:-mysql}
DB_HOST=${DB_HOST:-tastyigniter-database}
DB_PORT=${DB_PORT:-3306}
DB_DATABASE=${DB_DATABASE:-tastyigniter}
DB_USERNAME=${DB_USERNAME:-tastyigniter}
DB_PASSWORD=${DB_PASSWORD:-tastyigniter}

CACHE_DRIVER=${CACHE_DRIVER:-file}
SESSION_DRIVER=file
QUEUE_CONNECTION=sync

REDIS_HOST=${REDIS_HOST:-127.0.0.1}
REDIS_PASSWORD=null
REDIS_PORT=6379
EOF
	fi
	
	chown www-data:www-data /var/www/html/.env
fi

# Check if already installed by looking for APP_KEY in .env
if grep -q "^APP_KEY=$" /var/www/html/.env 2>/dev/null; then
	# Generate application key
	php artisan key:generate --force
	
	# Wait for database to be ready
	echo "Waiting for database..."
	sleep 5
	
	# Run TastyIgniter installation
	php artisan igniter:install --no-interaction
	
	# set permissions after installation for newly created files
	chown -R www-data:www-data /var/www/html/storage
	chown -R www-data:www-data /var/www/html/public
	chmod -R 775 /var/www/html/storage
	chmod -R 775 /var/www/html/public
fi

# Ensure correct permissions on every container start
chown -R www-data:www-data /var/www/html/storage
chown -R www-data:www-data /var/www/html/public
chmod -R 775 /var/www/html/storage
chmod -R 775 /var/www/html/public

exec "$@"
