def debug(message: str, **kwargs) -> None:
    with open('/tmp/xmosh/debug.log', 'a') as f:
        print(message, file=f, end=': ')
        print(', '.join([f'{k}={v}' for k, v in kwargs.items()]), file=f)
