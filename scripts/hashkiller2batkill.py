wordlist = 'my-wordlist.txt'

with open('dumpik.txt', 'w') as f:
	for line in open(wordlist, 'r'):
		hash, word = line.split(':')
		print(f'{hash[:4]}:{word}', end ="", file=f)
        