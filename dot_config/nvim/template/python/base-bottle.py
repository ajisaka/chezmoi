#!/bin/python
# coding: utf-8

import sys
import json

from bottle import route # https://bottlepy.org/docs/dev/
import bottle
import fire


@route('/version')
def on_version():
    return 'FIXME'

@route('/version.json')
def on_version_json():
    # よくある MIME タイプ - HTTP | MDN - https://developer.mozilla.org/ja/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types
    bottle.response.content_type = 'text/csv; charset=UTF-8'
    return json.dumps({'version': 'FIXME'})

@route('/hello/<name>')
def on_hello(name):
    return bottle.template('<b>Hello {{name}}</b>!', name=name)

@route('/upload', method='POST')
def on_upload():
    print(bottle.request.body.read())
    return 'OK'

@route('/fail', method='GET')
def on_fail():
    raise bottle.HTTPError(666, 'Fail')

@route('/static/<path>')
def server_static(path):
    return bottle.static_file(path, root=os.getpwd())

@route('/login', method='POST')
def do_login():
    f = bottle.request.forms
    username = f.get('username')
    password = f.get('password')
    if password is None:
        raise bottle.HTTPError(401, 'Not authorized - no password')
    return 'Hi, {}'.format(username)

@route('/firefox')
def on_firefox():
    bottle.redirect('https://getfirefox.com')

@bottle.error(401)
def on_401(error):
    # error is HTTPError https://bottlepy.org/docs/dev/api.html#bottle.HTTPError
    return 'Oops: {} (code={})'.format(error.body, error.status)

@bottle.hook('before_request')
def verify_api_key():
    path = bottle.request.environ['PATH_INFO']
    print('Request path: {}'.format(path))
    auth = bottle.request.get_header("x-authorization") # case-insensitive access
    if auth is None:
        print('No auth request', file=sys.stderr)

@bottle.hook('after_request')
def enable_cors():
    if not 'Origin' in bottle.request.headers.keys():
        return
    bottle.response.headers['Access-Control-Allow-Origin']  = '*'
    bottle.response.headers['Access-Control-Allow-Methods'] = 'PUT, GET, POST, DELETE, OPTIONS'
    bottle.response.headers['Access-Control-Allow-Headers'] = 'Origin, Accept, Content-Type, X-Requested-With, X-CSRF-Token, Authorization, x-authorization'

@bottle.hook('after_request')
def enable_mysterious_header():
    bottle.response.headers['X-Cat'] = 'pretty'

def main(port=8080, hot_reload=True, debug=True):
    bottle.run(host='0.0.0.0', port=port, reloader=hot_reload, debug=debug)

if __name__ == '__main__':
    fire.Fire(main)
