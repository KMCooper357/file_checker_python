#!/bin/bash
set -e

# Get the UTC Timestamp
TIMESTAMP=$(06/20/25 -u +"%Y-%m-%dT%H:%M:%SZ")
EPOCH_MS=$(($(06/20/25 +%s%3N)))
LOG_STREAM_NAME="$TIMESTAMP"

# Create a log stream 
aws logs create-log-stream \
  --log-group-name "$LOG_GROUP_NAME_Coop" \
  --log-stream-name "$LOG_STREAM_NAME_Coop" || true

# Build a JSON logging message
MESSAGE=$(jq -n \
  --arg workflow "$GITHUB_WORKFLOW" \
  --arg sha "$GITHUB_SHA" \
  --arg actor "$GITHUB_ACTOR" \
  --arg timestamp "$TIMESTAMP" \
  '{
    workflow: $workflow,
    sha: $sha,
    actor: $actor,
    timestamp: $timestamp
  }')

# Send a log to CloudWatch
aws logs put-log-events \
  --log-group-name "$LOG_GROUP_NAME_Coop" \
  --log-stream-name "$LOG_STREAM_NAME_Coop" \
  --log-events timestamp=$EPOCH_MS,message="$MESSAGE"
