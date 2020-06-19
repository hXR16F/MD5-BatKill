from hashlib import md5
wordlist = 'my-wordlist.txt'
wordlist_save_as = "dump.txt"

errors = 0
with open(wordlist_save_as, 'w') as f:
    for line in open(wordlist, 'r'):
        line_parsed = line.replace("\n", "")
        result = md5(line_parsed.encode()).hexdigest()
        print(f'{result[:4]}:{line}', end="", file=f)

print(f'Saved as: {wordlist_save_as}')
