Headers = {
    'Access-Control-Allow-Origin': 'https://rpp.snca.net',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'POST'
}


# For AWS Lambda Function URL
def lambda_handler(event: Any, context: Any) -> Any:
    method = event['requestContext']['http']['method']
    if method == 'OPTIONS':
        return {
            'statusCode': 200,
            'headers': Headers
        }

    body = True

    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            **Headers,
        },
        'body': json.dumps(body)
    }
