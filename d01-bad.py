# Open input

with open('input/d01') as f:
    data = f.read().splitlines()

# Now data is list. LIne per item, empty lines are empty entries :)

elves = []
sum = 0

for line,val in enumerate(data):
    if val != '':
        sum += int(val)
        data[line] = ''
    else:
        data[line] = sum
        sum = 0

print(f"Part one: {sorted([x for x in data if x],reverse=True)[0]}")
print(f"Part two: {sorted([x for x in data if x],reverse=True)[0] + sorted([x for x in data if x],reverse=True)[1] + sorted([x for x in data if x],reverse=True)[2]}")

    