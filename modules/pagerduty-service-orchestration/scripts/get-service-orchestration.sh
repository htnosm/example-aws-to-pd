#!/bin/bash

# Exit if any of the intermediate steps fail
set -ex

# Extract "foo" and "baz" arguments from the input into
# FOO and BAZ shell variables.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
eval "$(jq -r '@sh "pagerduty_token=\(.pagerduty_token) id=\(.id)"')"

# Placeholder for whatever data-fetching logic your script implements
#FOOBAZ="$FOO $BAZ"

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
#jq -n --arg foobaz "$FOOBAZ" '{"foobaz":$foobaz}'

# [API Reference \| PagerDuty Developer Documentation](https://developer.pagerduty.com/api-reference/b3A6MzU3MDU0NDI-get-the-service-orchestration-for-a-service)

RES=$(curl -sSf --request GET \
  --url https://api.pagerduty.com/event_orchestrations/services/${id} \
  --header 'Accept: application/vnd.pagerduty+json;version=2' \
  --header 'Authorization: Token token='${pagerduty_token}'' \
  --header 'Content-Type: application/json')

echo "${RES}" | jq '.orchestration_path | {
    parent: .parent | tostring,
    self: .self,
    sets: .sets | tostring,
    catch_all: .catch_all | tostring
}'
