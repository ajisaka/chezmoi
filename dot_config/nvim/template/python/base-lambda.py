from typing import Any
import json


def main() -> Any:
    return {'message': 'TEST'}


def lambda_handler(event: Any, context: Any) -> Any:
    print('Received event: ' + json.dumps(event, indent=2))

    body = main()

    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json'
        },
        'body': json.dumps(body)
    }
