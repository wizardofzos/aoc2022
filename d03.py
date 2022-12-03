# Open input

import itertools

with open('input/d03') as f:
    rucksacks = f.read().splitlines()

import string

def itemval(item):
    vals = string.ascii_lowercase + string.ascii_uppercase
    return vals.find(item) + 1

def choprucksack(inventory):
    c1, c2 = rucksack[:len(rucksack)//2], rucksack[len(rucksack)//2:]
    return c1,c2

p1 = 0
p2 = 0
group = []
for rucksack in rucksacks:
    c1,c2 = choprucksack(rucksack)
    common = list(set(c1) & set(c2))[0]
    p1 += itemval(common)
    group.append(rucksack)
    if len(group) == 3:
        common = list(set(group[0]) & set(group[1]) & set(group[2]))[0]
        p2 += itemval(common)
        group = []
    

print(f"Part one: {p1}")
print(f"Part two: {p2}")