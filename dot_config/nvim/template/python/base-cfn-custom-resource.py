import json
import boto3

import cfnresponse

def on_create(props):
    return

def on_delete(props):
    return

def on_update(old_props, new_props):
    return

def lambda_handler(event, context):
    print(event)

    rt = event['RequestType']
    if rt == 'Create':
        on_create(event['ResourceProperties'])
    elif rt == 'Update':
        on_update(event['OldResourceProperties'], event['ResourceProperties'])
    elif rt == 'Delete':
        on_delete(event['ResourceProperties'])

    cfnresponse.send(event, context, cfnresponse.SUCCESS, {})
