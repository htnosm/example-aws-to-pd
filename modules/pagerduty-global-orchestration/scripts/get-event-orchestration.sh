#!/bin/bash

# Exit if any of the intermediate steps fail
set -ex

# Extract "foo" and "baz" arguments from the input into
# FOO and BAZ shell variables.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
eval "$(jq -r '@sh "pagerduty_token=\(.pagerduty_token) name=\(.name)"')"

# Placeholder for whatever data-fetching logic your script implements
#FOOBAZ="$FOO $BAZ"

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
#jq -n --arg foobaz "$FOOBAZ" '{"foobaz":$foobaz}'

# Get html_url
RES=$(curl -sSf --request GET \
  --url https://api.pagerduty.com/services \
  --header 'Accept: application/vnd.pagerduty+json;version=2' \
  --header 'Authorization: Token token='${pagerduty_token}'' \
  --header 'Content-Type: application/json')
HTML_URL="$(echo "${RES}" | jq -r '.services[0].html_url | sub("service-directory/.*"; "")')event-orchestration/"

# [API Reference \| PagerDuty Developer Documentation](https://developer.pagerduty.com/api-reference/b3A6MzU3MDU0MzM-list-event-orchestrations)
RES=$(curl -sSf --request GET \
  --url https://api.pagerduty.com/event_orchestrations \
  --header 'Accept: application/vnd.pagerduty+json;version=2' \
  --header 'Authorization: Token token='${pagerduty_token}'' \
  --header 'Content-Type: application/json')
ID=$(echo "${RES}" | jq -r '.orchestrations[] | select(.name=="'${name}'").id')

RES=$(curl -sSf --request GET \
  --url https://api.pagerduty.com/event_orchestrations/${ID} \
  --header 'Accept: application/vnd.pagerduty+json;version=2' \
  --header 'Authorization: Token token='${pagerduty_token}'' \
  --header 'Content-Type: application/json')

echo "${RES}" | jq '.orchestration | {
    id: .id,
    name: .name,
    self: .self,
    description: .description,
    routes: .routes | tostring,
    integration_key: .integrations[0].parameters.routing_key,
    html_url: ("'${HTML_URL}'" + .id)
}'
