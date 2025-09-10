# Common
## Startup & Shutdown
1. Rename **.env.sample** to **.evn** and c
2. Update the value of parameters in .env
3. Startup container with following command
```sh
docker compose up -d
```
4. Shutdown container with following command
```sh
# normally
docker compose down
# delete elder container & volumes
docker compose down -v
```

# Mysql
## backup
Run the following script to backup DB manually
```sh
docker-compose run backup
```

## reset
```sh
rm -rf ./volumes/phpmyadmin/sessions \
./volumes/mysql/backup \
./volumes/mysql/data \
./volumes/mysql/logs
```

## initial SQL
Just run once when there is no data.
path: volumes/postgresql/pgsql

# PostgreSQL
## backup
Run the following script to backup DB manually
```sh
docker-compose run backup
```

## reset
```sh
rm -rf ./volumes/pgadmin \
./volumes/postgresql/backup \
./volumes/postgresql/data \
./volumes/postgresql/logs
```

## initial SQL
Just run once when there is no data.
path: volumes/postgresql/pgsql


# Redis