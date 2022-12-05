with open('input/d05') as f:
    data = f.read().splitlines()

layout = ''
towers = []

# grab initial layout and moves
for line, text  in enumerate(data):
    if text == '':
        break

layout = data[:line]
moves  = data[line+1:]
print(layout)
# Number of stacks in last line of layout. then those stacks are at static
# offset..
stackLine = layout[len(layout)-1]
stacks = {}
for i in stackLine:
    if i.isdigit():
        stacks[int(i)] = []

# Now we have stacks. Parse layout again.. to form the stacks
for l in layout[:-1]:
    for s in range(len(stacks)):
        stacks[s+1].append(l[(s*4)+1])

# stacks are now mentallay in wrong order and have empties. Fix
okstack = {}
# make extra one for part 2 as otherwise reference pain
# I don't wanna solve ;)
okstack2 = {}    
for s in stacks:
    okstack[s] = [x for x in list(reversed(stacks[s])) if x != ' ']
    okstack2[s] = [x for x in list(reversed(stacks[s])) if x != ' ']

stacks = dict(okstack)
otherstacks = dict(okstack2)

for m in moves:
    parsed = m.split(' ')
    print(m)
    howmany = int(parsed[1])
    src = int(parsed[3])
    target = int(parsed[5])
    tomove = []
    for i in range(howmany):
        item = stacks[src].pop()
        item2 = otherstacks[src].pop()
        stacks[target].append(item)
        tomove.append(item2)
    for o in reversed(tomove):
        otherstacks[target].append(o)

p1 = ''
for s in stacks:
    p1 += stacks[s].pop()

print(f"Part1: {p1}")

p2 = ''
for s in otherstacks:
    p2 += otherstacks[s].pop()
print(f"Part2: {p2}")   