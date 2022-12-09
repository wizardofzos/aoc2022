with open('input/d08') as f:
    lines = f.read().splitlines()


rows = {}
cols = {}
for c in range(len(lines[0])):
    cols[c] = []

for l,line in enumerate(lines):
    rows[l] = [int(x) for x in line]
    for i in range(len(line)):
        cols[i].append(int(line[i]))

see = 0
nosee = 0 

for r in rows:
    for c in cols:
        print(f"Checking ({r},{c}) with {rows[r][c]} height")
        # can we be seen horizontally?
        leftofme  = rows[r][:c] or [-1]
        rightofme = rows[r][c+1:] or [-1]
        # or up & down
        aboveme   = cols[c][0:r] or [-1]
        belowme   = cols[c][r+1:] or [-1]
        print(f"left: {leftofme}, right: {rightofme}, top: {aboveme}, bottom: {belowme}")
        # do max min on lists
        if max(leftofme) < rows[r][c] or max(rightofme) < rows[r][c]:
            print(f"{r},{c} can be seen")
            see += 1
            continue
        if  max(aboveme) < rows[r][c] or max(belowme) < rows[r][c]:
            print(f"{r},{c} can be seen")
            see += 1
            continue
        nosee += 1






print(f"Part 1: {see}")
part2 = 0
for r in rows:
    for c in cols:
        print(r,c)
        h = rows[r][c]
        su = sl = sr = sd = s = 0
        leftofme  = rows[r][:c] or [-1]
        rightofme = rows[r][c+1:] or [-1]
        # or up & down
        aboveme   = cols[c][0:r] or [-1]
        belowme   = cols[c][r+1:] or [-1]
        print(f"left: {leftofme}, right: {rightofme}, top: {aboveme}, bottom: {belowme}")
        if leftofme == [-1] or rightofme == [-1] or aboveme == [-1] or belowme == [-1]:
            continue
        for u in reversed(aboveme):
            su += 1
            if u >= h:
                break
        for d in belowme:
            sd += 1
            if d >= h:
                break
        for l in reversed(leftofme):
            sl += 1
            if l >= h:
                break
        for rr in rightofme:
            sr += 1
            if rr >= h:
                break
        s = su * sl * sr * sd
        print(f"su {su}, sd {sd} sr {sr} sl {sl}")
        print(f"score : {s}")
        if s > part2:
            part2 = s

print(f"Part 2: {part2}")