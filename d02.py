# Open input

import itertools

with open('input/d02') as f:
    data = f.read().splitlines()

# Now data is list. LIne per item, empty lines are empty entries :)



# rock = 1
# paper = 2
# scissors = 3




# A / X = rock
# B / Y = paper
# C / Z = scissors
points = {}
points['X'] = 1
points['Y'] = 2
points['Z'] = 3

mywins = [['A','Y'], ['B','Z'], ['C', 'X']]
nowins = [['A','Z'], ['B','X'], ['C', 'Y']]





score = 0
for d in data:
    his, mine = d.split(' ')
    if (his == 'A' and mine == 'X') or (his == 'B' and mine =='Y') or (his == 'C' and mine == 'Z'):
        score +=  3 + points[mine]
    elif [his, mine] in mywins:
        score +=  6 + points[mine]
    else:
        score += points[mine]

print(f"Part 1: {score}")
        
# ugly repeat for p2 

states = {}
states['X'] = 'loose'
states['Y'] = 'draw'
states['Z'] = 'win'

score = 0
for d in data:
    his, result = d.split(' ')
    if states[result] == 'win':
        for wins in mywins:
            if wins[0] == his:
                mine = wins[1]
        score += 6 + points[mine]
    if states[result] == 'loose':
        for lost in nowins:
            if lost[0] == his:
                mine = lost[1]
        score += points[mine]
    if states[result] == 'draw':
        if his == 'A':
            mine = 'X'
        if his == 'B':
            mine = 'Y'
        if his == 'C':
            mine = 'Z'
        score += 3 + points[mine]

print(f"Part 2: {score}")
    
