from dataclasses import dataclass
from os import environ as E

from daacla import Daacla, table


@dataclass
@table(key='term')
class Definitions:
    id: int
    term: str
    definition: str
    text: str
    source: str


app_db = Daacla(path=E['FOO_DATABASE'])
