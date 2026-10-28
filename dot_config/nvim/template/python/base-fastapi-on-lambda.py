#!/bin/python

# FastAPI - https://fastapi.tiangolo.com/

from typing import Any, Dict, Optional

from fastapi import FastAPI, Query, Path, Body
from pydantic import BaseModel

app = FastAPI()


class UploadData(BaseModel):
    name: str
    title: Optional[str] = None
    content: str


@app.get('/')
async def index() -> Dict[str, str]:
    return {'text': 'Hello world!'}


@app.get('/greet/{username}')
async def greet(username: str, text: str='Konchiwa') -> Dict[str, str]:
    return {'text': '{}, {}'.format(text, username)}


@app.get('/user/{username}/file/{number}')
async def user_file(username: str, number: int) -> Dict[str, str]:
    return {'content': '{}\'s file #{}'.format(username, number)}


@app.get('/validator/username')
async def validate_username(value: str = Query(..., min_length=2, regex=r'''\A[a-zA-Z]{2,}\Z''')) -> Dict[str, str]:
    return {'result': 'OK'}


@app.get('/complex/{michi}', description='The Complex API')
async def complex_api(
        michi: str = Path(
            ...,
            description='パス',
            min_length=2,
            regex=r'''\A[a-zA-Z]{2,}\Z'''),
        n: Optional[int] = Query(
            10,
            title='n',
            description='Number of somethings',
        ),
        m: Optional[int] = None) -> Dict[str, Any]:
    return {'michi': michi, 'n': n, 'm': m}


@app.post('/upload')
async def upload(data: UploadData = Body(...)) -> Any:
    return data


if __name__ == '__main__':
    pass
else:
    import os
    if os.environ.get('AWS_EXECUTION_ENV') is None:
        pass
    else:
        from mangum import Mangum
        lambda_handler = Mangum(app, enable_lifespan=False)
