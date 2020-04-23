from sys import argv
from hashlib import md5
print(md5(argv[1].encode()).hexdigest())
