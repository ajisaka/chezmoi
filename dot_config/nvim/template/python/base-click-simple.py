from pathlib import Path
from typing import Optional

import click


TypePath = click.types.Path(path_type=Path)


@click.group(context_settings={"show_default": True})
@click.pass_context
def main(ctx: click.Context) -> None:
    # ctx.obj = App()
    pass


@main.command(name='foo')
@click.argument('source', type=TypePath, required=True)
@click.option('--dest', type=TypePath, required=False, help='The person to greet.')
def command_foo(source: Path, dest: Optional[Path]) -> None:
    print(type(source), source)
    print(type(dest), dest)


if __name__ == '__main__':
    main()
