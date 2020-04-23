wordlist = 'my-wordlist.txt'

from hashlib import md5
with open('dumpik.txt', 'w') as f:
	for line in open(wordlist, 'r'):
		result = md5(line.encode()).hexdigest()
		print(f'{result[:4]}:{line}', end ="", file=f)
        