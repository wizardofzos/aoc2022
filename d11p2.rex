/* REXX */
x = bpxwunix('cat input/d11',,file.,se.)

digits = 31
NUMERIC DIGITS digits

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


maxlen = 0
/* So the game begins... */
do round = 1 to 10000
  if round // 10 = 0 then
    say time()" round "round "(DIGITS="DIGITS")"
  do i = 1 to monkeyitems.0
    do j = 1 to words(monkeyitems.i)
      old = word(monkeyitems.i, j)
      monkeyinspects.i = monkeyinspects.i + 1   
      interpret(monkeyoperation.i)
      /*
      new = trunc(new / 3)  
      */
      if length(new) > maxlen then do
        maxlen = length(new)
        if maxlen > DIGITS then NUMERIC DIGITS maxlen + 20
      end

     
      divable = divisible(new,monkeytest.i)

    

      if divable = "yes" then
        to = word(monkeyaction.i,1) 
      else
        to = word(monkeyaction.i,2)
      /* actually throw the item */
      to = to + 1 /* as we don't start at 0 in our stem */
      /* reduce this mofo by mod prod all divisors */
      new = new // (23*19*13*17*3*5*7*11*2)
      monkeyitems.to = monkeyitems.to || " " || new
    end
    monkeyitems.i = ""
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
part2 = word(sorted.1, cnt) * word(sorted.1, cnt-1)
say "Part two: "part2

exit

reduce: procedure
  arg int, value
  damax = 21
  if length(int) > damax then do 
    if value = 23 then do
      do while length(int) > damax
        lastdigit = substr(int,length(int))
        rest      = substr(int,1,length(int)-1)
        int       = (7 * lastdigit ) + rest
      end
    end

    if value = 19 then do
      do while length(int) > damax
        lastdigit = substr(int,length(int))
        rest      = substr(int,1,length(int)-1)
        int       = (2 * lastdigit ) + rest      
      end
    end

    if value = 13 then do
      do while length(int) > damax
        lastdigit = substr(int,length(int))
        rest      = substr(int,1,length(int)-1)
        int       = (4 * lastdigit ) + rest      
      end
    end

    if value = 17 then do
      do while length(int) > damax
        lastdigit = substr(int,length(int))
        rest      = substr(int,1,length(int)-1)
        int       = rest - (5 * lastdigit )
      end
    end

  end
  
  return int

divisible: procedure
  arg int, value
  
  int = reduce(int,value)

  c = int // value
  if c = 0 then return "yes"
  else return "no"













