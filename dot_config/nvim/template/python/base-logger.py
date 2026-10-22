from math import floor
from timeit import default_timer as timer
from typing import Any, TypeVar


def _keywords(kwargs: dict[str, Any]) -> str:
    if len(kwargs) == 0:
        return ''
    result = []
    for k, v in kwargs.items():
        result.append('{}={}'.format(k, v))
    return ': ' + ' '.join(result)


T = TypeVar('T')


Indent = '    '


class Logger():
    def __init__(self, level: int = 0) -> None:
        self.silent = False
        self.level = 0

    def _print(self, line: str) -> None:
        if self.silent:
            return
        print(line)

    def error(self, _name: str, **kwargs: Any) -> None:
        line = (Indent * self.level) + '→NG ' + _name + _keywords(kwargs)
        self._print(line)

    def exception(self, e: Exception) -> None:
        self._print(f'Exception: {e}')

    def phase(self, _name: str, **kwargs: Any) -> None:
        line = (Indent * self.level) + _name + _keywords(kwargs)
        self._print(line)

    def progress(self, _name: str, **kwargs: Any) -> None:
        line = (Indent * (self.level + 1)) + '⏲ ' + _name + _keywords(kwargs)
        self._print(line)

    def result(self, _name: str, **kwargs: Any) -> None:
        line = (Indent * self.level) + '→ ' + _name + _keywords(kwargs)
        self._print(line)

    def silence(self) -> 'SilentBlock':
        return SilentBlock(self)

    def stopwatch(self, _name: str = 'stopwatch', **kwargs: Any) -> 'StopwatchBlock':
        return StopwatchBlock(self, name=_name, parameters=kwargs)

    def __enter__(self) -> None:
        self.level += 1

    def __exit__(self, *_: Any) -> None:
        self.level -= 1


class SilentBlock:
    def __init__(self, logger: Logger) -> None:
        self.logger = logger

    def __enter__(self) -> None:
        self.logger.silent = True

    def __exit__(self, *_: Any) -> None:
        self.logger.silent = False


class StopwatchBlock:
    def __init__(self, logger: Logger, name: str, parameters: dict[str, Any]) -> None:
        self.logger = logger
        self.name = name
        self.parameters = parameters

    def __enter__(self) -> None:
        self.at_start = timer()

    def __exit__(self, *_: Any) -> None:
        at_end = timer()
        seconds = floor((at_end - self.at_start) * 10.0) / 10.0
        self.logger.result(self.name, seconds=seconds, **self.parameters)


Default = Logger()
