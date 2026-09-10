from pathlib import Path


root = Path('/tmp/xmosh')
for it in root.glob('**/*.*'):
    print(it)
