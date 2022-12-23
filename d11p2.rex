/* REXX */
x = bpxwunix('cat input/d11',,file.,se.)


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

/* get our common reduce thinggy */
r = 1
do rr = 1 to monkeytest.0
  r = r * monkeytest.rr
end 

/* need to set numeric digits to length of r * 2 */
say time()" reduction digits: "length(r)" so setting DIGITS to "length(r)*2
NUMERIC DIGITS (length(r)*2) 


say time()" monkey business started"
maxlen = 0
/* So the game begins... */
do round = 1 to 10000
  if round // 1000 = 0 then
    say time()" round "round" ("actions()" acts of monkey business)"
  do i = 1 to monkeyitems.0
    do j = 1 to words(monkeyitems.i)
      old = word(monkeyitems.i, j)
      monkeyinspects.i = monkeyinspects.i + 1   
      interpret(monkeyoperation.i)
      divable = divisible(new,monkeytest.i)
      if divable = "yes" then
        to = word(monkeyaction.i,1) 
      else
        to = word(monkeyaction.i,2)
      /* actually throw the item */
      to = to + 1 /* as we don't start at 0 in our stem */
      /* reduce this mofo by mod prod all divisors */
      new = new // r
      monkeyitems.to = monkeyitems.to || " " || new
    end
    monkeyitems.i = ""
  end
end


tosort = ""
do i = 1 to monkeyitems.0
  /* say "Monkey "i-1" : "monkeyinspects.i */
  tosort = tosort || " " || monkeyinspects.i 
end
/* Get our sort trick from day one ;) */
cmd = 'echo "'tosort'" | tr " " "\n" | sort -n | tr "\n" " ";echo'
x = bpxwunix(cmd,,sorted., se.)
cnt = words(sorted.1)
part2 = word(sorted.1, cnt) * word(sorted.1, cnt-1)
say "Part two: "part2

exit

actions:
  res = 0
  do aa = 1 to monkeyitems.0
    res = res + monkeyinspects.aa
  end
  return res

divisible: procedure
  arg int, value
  c = int // value
  if c = 0 then return "yes"
  else return "no"













