/* REXX */
x = bpxwunix('cat input/d11',,file.,se.)
part1 = 0
part2 = 0

monkeyitems. = 0
monkeyoperation. = 0
monkeytest. = 0
monkeyaction. = 0
monkeyinspects. = 0

/* Parse the input */
do i = 1 to file.0 by 7
  newmonkey = monkeyitems.0 + 1
  /* parse items */
  l = i + 1
  p = pos(':', file.l)
  items = strip(translate(substr(file.l, p+1),' ',','))
  ni = ''
  do w = 1 to words(items)
    ni = ni || " " || word(items,w)
  end
  monkeyitems.newmonkey = strip(ni)
  /* parse operation */
  l = l + 1
  p = pos(':', file.l)
  monkeyoperation.newmonkey = strip(substr(file.l,p+1))
  /* parse test */
  l = l + 1
  p = pos('by', file.l)
  monkeytest.newmonkey = strip(substr(file.l,p+2))
  /* parse action on true/false*/
  l = l + 1
  tm = word(file.l, words(file.l))
  l = l + 1
  fm = word(file.l, words(file.l))
  monkeyaction.newmonkey = strip(tm)" "strip(fm)
  /* update indexes for stems */
  monkeyoperation.0 = newmonkey
  monkeyitems.0 = newmonkey
  monkeytest.0 = newmonkey
  monkeyaction.0 = newmonkey
end

/* So the game begins... */
do round = 1 to 20
  do i = 1 to monkeyitems.0
    say "Monkey "i-1
    do j = 1 to words(monkeyitems.i)
      old = word(monkeyitems.i, j)
      say "Inspect "old
      monkeyinspects.i = monkeyinspects.i + 1
      interpret(monkeyoperation.i)
      new = trunc(new / 3)
      val = new / monkeytest.i 
      if val = trunc(val) then
        to = word(monkeyaction.i,1) 
      else
        to = word(monkeyaction.i,2)
      say "throw to "to
      /* actually throw the item */
      to = to + 1 /* as we don't start at 0 in our stem */
      monkeyitems.to = monkeyitems.to || " " || new
    end
    monkeyitems.i = ""
    
    say "Items: "monkeyitems.i
    say "Oper: "monkeyoperation.i
    say "Test: "monkeytest.i 
    say "True/False: "monkeyaction.i 
  end
end


tosort = ""
do i = 1 to monkeyitems.0
  say "Monkey "i-1" : "monkeyinspects.i
  tosort = tosort || " " || monkeyinspects.i 
end
/* Get our sort trick from day one ;) */
cmd = 'echo "'tosort'" | tr " " "\n" | sort -n | tr "\n" " ";echo'
x = bpxwunix(cmd,,sorted., se.)
cnt = words(sorted.1)
part1 = word(sorted.1, cnt) * word(sorted.1, cnt-1)
say "Part one: "part1

say "Part two: "












