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
## Backup
Run the following script to backup DB manually
```sh
docker-compose run backup
```

## Reset
```sh
rm -rf ./volumes/phpmyadmin/sessions \
./volumes/mysql/backup \
./volumes/mysql/data \
./volumes/mysql/logs
```

## Initial SQL
Just run once during initialization.(path: volumes/mysql/sql)


# PostgreSQL
## Backup
Run the following script to backup DB manually
```sh
docker-compose run backup
```

## Reset
```sh
rm -rf ./volumes/pgadmin \
./volumes/postgresql/backup \
./volumes/postgresql/data \
./volumes/postgresql/logs
```

## Initial SQL
Just run once during initialization.(path: volumes/postgresql/pgsql)


# Redis