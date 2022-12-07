with open('input/d07') as f:
    lines = f.read().splitlines()


cwd = ''
fs  = {}
cmd = ''
STATE = 'INPUT'
cwd = ''
for line in lines:
    parts = line.split()
    if STATE == 'ls':
        print(f"Should add {line} to {cwd}")
        lsp = line.split(' ')
        if lsp[0] == 'dir':
            if cwd not in fs:
                fs[cwd] = {}
                fs[cwd]['folders'] = [lsp[1]]
                fs[cwd]['files'] = {}
            else:
                fs[cwd]['folders'].append(lsp[1])
        if lsp[0].isdigit():
            if cwd not in fs:
                fs[cwd] = {}
                fs[cwd]['folders'] = []
                fs[cwd]['files'] = {}
                fs[cwd]['files'][lsp[1]] = lsp[0] 
            else:
                if 'files' not in fs[cwd]:
                    fs[cwd]['files'] = {}
                fs[cwd]['files'][lsp[1]] = lsp[0]
    if parts[0] == '$' and parts[1] == 'cd':
        if parts[2] == '/':
            cwd = '/'
        elif parts[2] == '..':
            cparts = cwd.split('/')
            cwd = '/'.join(cparts[0:-1])
        else:
            cwd = f"{cwd}/{parts[2]}"
        cwd = f"{cwd.replace('//', '/')}"
        if cwd == '':
            cwd = '/'
        print(f"cwd = {cwd}")
        STATE = 'cd'
    if parts[0] == '$' and parts[1] == 'ls':
        STATE = 'ls'
    

def foldersize(f):
    size = 0
    for i in fs[f]['files']:
        size += int(fs[f]['files'][i])
    for j in fs[f]['folders']:
        size += foldersize(f"{f}/{j}".replace('//','/'))
    return size

part1 = 0
for d in fs:
    if d != '/':
        size = foldersize(d)
        if size <= 100000:
            part1 += size




print(f"Part 1: {part1}")
size = 0
for d in fs['/']['folders']:
    size += foldersize(f"/{d}")
for f in fs['/']['files']:
    size += int(fs['/']['files'][f])

unused  = 70000000 - size
todelete = 30000000 - unused

part2 = 0
p2candidates = []
for f in fs:
    if f != '/':
        if foldersize(f) >= todelete:
            p2candidates.append([f,foldersize(f)])

smallest = ['', 70000000000000000]
for c in p2candidates:
    if c[1] < smallest[1]:
        smallest[0] = c[0]
        smallest[1] = c[1]

print(f"Part 2: {smallest[1]}")