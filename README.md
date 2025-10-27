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

## Reset

```sh
rm -rf ./volumes/redis/data \
./volumes/redis/logs
```

# Localstack

## Startup

Need to run the following commands after run **_docker compose up_**

```
sh ./setup-localstack.sh
```

This is just a demo (creating an SQS for now); it should be extended based on actual requirements.

### verify

1. **Send event to EventBridge**  
   Send an event which detail-type is "target" to custom-event-bus:

```bash
aws events --endpoint-url http://localhost:4566 put-events --region us-east-1 --entries '[{"Source": "test","DetailType": "target","Detail": "{\"foo\":\"bar\"}","EventBusName": "custom-event-bus"}]' | jq '.'
```

2. **Check if the SQS queue has received messages**  
   Pull messages from the custom-sqs queue.

```bash
aws sqs --endpoint-url http://localhost:4566 receive-message --region us-east-1 --queue-url "http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/custom-sqs" | jq '.'
```

## Reset

```sh
rm -rf ./volumes/localstack
```
