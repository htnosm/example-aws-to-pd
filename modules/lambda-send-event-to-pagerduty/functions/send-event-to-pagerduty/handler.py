#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import http.client
import logging
import json
import re
logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    logger.info(f"{event=}")
    function_name = os.environ.get('AWS_LAMBDA_FUNCTION_NAME')

    for record in event.get('Records', []):
        sns_event = record.get('Sns', {})
        topic_arn = sns_event.get('TopicArn', '')
        topic_name = re.sub('^.*:', '', topic_arn)
        summary = f"{function_name}[{topic_name}]" if len(topic_name) > 0 else function_name
        message_id = sns_event.get('MessageId', '')

        try:
            details = json.loads(sns_event['Message'])
            if 'detail-type' in details:
                summary = f"{function_name}[{topic_name}] {details['detail-type']}"
        except json.JSONDecodeError as e:
            logger.warn(f'JSON decode error: {e}')
            details = sns_event

        payload = {
            'payload': {
                'summary': summary,
                'severity': 'error',
                'source': topic_arn,
                'custom_details': details,
            },
            'routing_key': os.environ['INTEGRATION_KEY'],
            'event_action': 'trigger',
            'dedup_key': f"{function_name}:{message_id}",
        }
        logger.info(f"{payload=}")
        headers = {
            'Content-Type': "application/json"
        }

        try:
            conn = http.client.HTTPSConnection("events.pagerduty.com")
            conn.request("POST", "/v2/enqueue", json.dumps(payload), headers)
            res = conn.getresponse()
            data = res.read()
            logger.info(data.decode("utf-8"))
        except Exception as e:
            logger.error(e)
