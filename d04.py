
with open('input/d04') as f:
    data = f.read().splitlines()


def overlap(a,b,c,d):
    if a <= c <= d <= b or c <= a <= b <= d:
        return "FULL"
    if a <= c <= b <= d or c <= a <= d <= b:
        return "PARTIAL"
    return "NO"


p1 =0
p2 =0
for line in data:
    p = line.split(',')
    e1 = p[0].split('-')
    e2 = p[1].split('-')
    if overlap(int(e1[0]), int(e1[1]), int(e2[0]), int(e2[1])) == "FULL":
        p1 += 1
        p2 += 1
    if overlap(int(e1[0]), int(e1[1]), int(e2[0]), int(e2[1])) == "PARTIAL":
        p2 += 1

print(f"Part one: {p1}")
print(f"Part two: {p2}")