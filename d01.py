# Open input

with open('input/d01') as f:
    data = f.read().splitlines()

# Now data is list. LIne per item, empty lines are empty entries :)

elves = []
sum = 0
for i in data:
    if i != '':
        sum += int(i)
    else:
        elves.append(sum)
        sum = 0

elves = sorted(elves, reverse=True)

print(f"Part one answer: {elves[0]}")
print(f"Part two answer: {elves[0] + elves[1] + elves[2]}")


    