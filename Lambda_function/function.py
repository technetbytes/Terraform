import json

def lambda_handler(event, context):
    # Simple response to the event
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
