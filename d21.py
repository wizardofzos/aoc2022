with open('input/d21') as f:
    lines = f.read().splitlines()


say = {}
do = {}
def noteval(a,b,c):
    a = int(a)

    c = int(c)
    if b == '+':
        return a + c
    if b == '-':
        return a - c
    if b == '/':
        return a / c 
    if b == '*':
        return a * c 


def formula(monkey):
    if monkey in do:
        return [do[monkey]]
    else:
        


def solve(monkey):


    if monkey in say:
        return say[monkey]
    
    action = do[monkey].split(' ')
    arg1 = action[0]
    op = action[1]
    arg2 = action[2]

    print(action,arg1,op,arg2)


    if arg1 in say and arg2 in say: 
        say[monkey] = noteval(say[arg1],op,say[arg2]) 
        return say[monkey]


    if arg1 not in say and arg2 in say:
        s1 = solve(arg1)
        say[arg1] = s1
        val = noteval(s1,op,say[arg2])
        say[monkey] = val
        return say[monkey]

    if arg1 in say and arg2 not in say:
        s1 = solve(arg2)
        say[arg2] = s1
        say[monkey] = noteval(say[arg1],op,say[arg2])
        return say[monkey]


   
    
    
    if arg1 not in say and arg2 not in say:
        a2solver = do[arg2].split(' ')
        vl = solve(a2solver[0])
        vr = solve(a2solver[2])
        say[arg2] = noteval(vl,a2solver[1],vr)

        a1solver = do[arg1].split(' ')
        vl = solve(a1solver[0])
        vr = solve(a1solver[2])
        say[arg1] = noteval(vl,a1solver[1],vr)

        say[monkey] = noteval(say[arg1],op,say[arg2])
        return say[monkey]


        


for line in lines:
    p = line.split(':')
    monkey = p[0]
    does = p[1].strip()

    if does.isdigit():
        say[monkey] = does
    else:
        do[monkey] = does

print(solve('root'))


    