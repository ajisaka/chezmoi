
import os

root = '/tmp/xmosh/foo'
for parent, dirs, files in os.walk(root):
    for f in files:
        print(os.path.join(parent, f))
