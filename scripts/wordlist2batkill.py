from hashlib import md5
with open('dumpik.txt', 'w') as f:
	for line in open('1000000-password-seclists.txt', 'r'):
		result = md5(line.encode()).hexdigest()
		print(f'{result[:4]}:{line}', end ="", file=f)
        