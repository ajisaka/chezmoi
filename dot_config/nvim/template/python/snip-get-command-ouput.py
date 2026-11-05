import subprocess

child = subprocess.run(['cal'], input='FOO'.encode('UTF-8'), stdout=subprocess.PIPE)
print(child.stdout.decode('UTF-8'))
