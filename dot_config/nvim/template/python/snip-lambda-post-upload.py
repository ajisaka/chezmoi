import base64
from PIL import Image


    for_dump = {**event}
    if 'body' in for_dump:
        for_dump['body'] = f'DUMMY: {len(for_dump)} bytes'
    print('Received event: ' + json.dumps(for_dump, indent=2))

    body = base64.b64decode(event['body'])
    img = Image.open(BytesIO(body))
