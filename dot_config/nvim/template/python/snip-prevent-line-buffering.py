sys.stdout = os.fdopen(sys.stdout.fileno(), 'w', buffering=1)
sys.stderr = os.fdopen(sys.stderr.fileno(), 'w', buffering=1)
sys.stdin = os.fdopen(sys.stdin.fileno(), 'r', buffering=1)
