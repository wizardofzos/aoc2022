with open('input/d06') as f:
    line = f.readline()


def day6(line, chunk_length):
    for i, char_ in enumerate(line):
        if i < chunk_length - 1: continue

        chunk = line[i:i+chunk_length]
        if len(set(chunk)) == chunk_length:
            return i + chunk_length




print(f"Part 1: {day6(line, 4)}")
print(f"Part 2: {day6(line, 14)}")