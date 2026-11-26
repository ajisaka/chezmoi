import os
import sys

import percache

Cache = percache.Cache(os.path.join(sys.path[0], '.percache'), livesync=True)
