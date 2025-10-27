#!/bin/bash
set -euo pipefail

# Load .env variables
export $(grep -v '^#' .env | xargs)

HOST="${LOCALSTACK_HOSTNAME:-localhost}"
PORT="${EXPORT_PORT_LOCALSTACK:-4566}"
REGION="${AWS_REGION:-us-east-1}"
ACCOUNT_ID="${AWS_ACCOUNT_ID:-000000000000}"
MAX_RECEIVE_COUNT="${MAX_RECEIVE_COUNT:-2}"

ENDPOINT="http://$HOST:$PORT"

echo 'Create event bus'
aws events --endpoint-url "$ENDPOINT" create-event-bus --region "$REGION" --name custom-event-bus | jq '.'

echo 'Create SQS queues'
QUEUES=("custom-sqs")
for QUEUE in "${QUEUES[@]}"; do
    aws sqs --endpoint-url "$ENDPOINT" create-queue --region "$REGION" --queue-name "$QUEUE" | jq '.'
    
    QUEUE_URL="$ENDPOINT/queue/custom-sqs"
    aws sqs --endpoint-url "$ENDPOINT" create-queue --region "$REGION" --queue-name "$QUEUE"-dlq | jq '.'
    aws sqs --endpoint-url "$ENDPOINT" set-queue-attributes \
        --region "$REGION" \
        --queue-url "http://sqs.$REGION.$HOST.localstack.cloud:$PORT/$ACCOUNT_ID/$QUEUE" \
        --attributes RedrivePolicy=$(echo '{"maxReceiveCount":'"$MAX_RECEIVE_COUNT"',"deadLetterTargetArn":"arn:aws:sqs:'"$REGION"':'"$ACCOUNT_ID"':'"$QUEUE"'-dlq"}' | jq -R)
done

echo 'List available queues'
aws sqs --endpoint-url "$ENDPOINT" list-queues --region "$REGION" | jq '.'

echo 'Create event rule'
aws events --endpoint-url "$ENDPOINT" put-rule \
    --region "$REGION" \
    --name send-events-to-custom-sqs \
    --event-bus-name custom-event-bus \
    --event-pattern '{"detail-type": ["target"]}' | jq '.'

echo 'Create target for the event rule'
TARGETS=$(jq -c -n --arg arn "arn:aws:sqs:$REGION:$ACCOUNT_ID:custom-sqs" '[{"Id":"custom-sqs","Arn":$arn}]')
aws events --endpoint-url "$ENDPOINT" put-targets \
    --region "$REGION" \
    --event-bus-name custom-event-bus \
    --rule send-events-to-custom-sqs \
    --targets "$TARGETS" | jq '.'
