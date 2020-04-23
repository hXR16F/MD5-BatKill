with open('dumpik.txt', 'w') as f:
	for line in open('360707.txt', 'r'):
		hash, word = line.split(':')
		print(f'{hash[:4]}:{word}', end ="", file=f)
        