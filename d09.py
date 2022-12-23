with open('input/d09') as f:
    lines = f.read().splitlines()


def distance(x1, y1, x2, y2):
    dist = abs(x1 - x2) + abs(y1 - y2)
    if x1 == x2 and dist >= 2:
        return (x2, y1 - 1 if y1 > y2 else y1 + 1)
    if y1 == y2 and dist >= 2:
        return (x1 - 1 if x1 > x2 else x1 + 1, y2)
    if dist > 2:
        if x1 > x2:
            return (x2 + 1, y2 + 1 if y1 > y2 else y2 - 1)
        if x1 < x2:
            return (x2 - 1, y2 + 1 if y1 > y2 else y2 - 1)
    return (x2, y2)


costs = {"U": 1, "D": -1, "R": 1, "L": -1}
spots = {i: [(0, 0)] for i in range(10)}

for rd, line in enumerate(lines):
    d, n = line.split()[0], int(line.split()[1])
    for i in range(n):
        hx, hy = spots[0][-1]
        if d in ["R", "L"]:
         hx += costs[d]
        if d in ["U", "D"]:
            hy += costs[d] 
        spots[0].append((hx, hy))
        for j in range(1, 10):
            spots[j].append(distance(*spots[j-1][-1], *spots[j][-1]))
            
print(f"Part 1: {len(set(spots[1]))}")
print(f"Part 2: {len(set(spots[9]))}")