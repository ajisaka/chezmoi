TypePath = click.types.Path(path_type=Path)

@click.option('--dest', type=TypePath, required=False, help='The person to greet.')
