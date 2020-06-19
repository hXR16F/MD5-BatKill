wordlist = 'my-wordlist.txt'
wordlist_save_as = "dump.txt"

errors = 0
with open(wordlist_save_as, 'w') as f:
    for line in open(wordlist, 'r'):
        try:
            hash, word = line.split(':')
            print(f'{hash[:4]}:{word}', end="", file=f)
        except ValueError:
            errors += 1

print(f'Saved as: {wordlist_save_as}')
print(f'Total errors: {errors}')
