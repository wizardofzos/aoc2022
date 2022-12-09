with open('input/d07t') as f:
    lines = f.read()

paths = []
folders = {}

commands_and_output = lines.split('$ ')
for co in commands_and_output[1:]:
    cout = co.splitlines()
    if len(cout) == 1:
        # This is a command. Process it ;)
        ca = cout[0].split(' ')
        print(ca)
        if ca[0] == 'cd':
            print(f'Process cd into --> {ca[1]}')
            if ca[1] == '..':
                paths.pop()
            else:
                paths.append(f"{ca[1].replace('/','')}/")
                if ''.join(paths) not in folders:
                    folders[''.join(paths)] = 0
    if len(cout) > 1:
        if cout[0] == 'ls':
            size = 0
            print(f'Process ls output -> {cout[1:]}')
            for output in cout[1:]:
                d = output.split(' ')
                if d[0].isdigit():
                    print(f"{d[1]} in {paths} is {d[0]}")
                    size += int(d[0])
            folders[''.join(paths)] = size

for folder in folders:
    addto  = folder.split('/')
    addto.pop()

    print(folder, f">>{'/'.join(addto)}<<")
