/* REXX */

signal on syntax name badmonkey

signal on failure name badmonkey

x = bpxwunix('cat input/d21',,f.,se.)

NUMERIC DIGITS 164
/* Dont run this code.... dont even look at it 

it terrible :)

*/

msay. = '?'
mdo.  = '?' 

monkeys = ''
badmonkeys = ''

goodmonkeys = 0




starttime = time()

do i = 1 to f.0                  
  /* we get a list of monkey-say, monkey-do
  aaaa = x (monkey say)
  bbbb = aaaa ? cccc (monkey does arithmic operator ? on aaaa and cccc
  

  PART2 MADNESS :) humn is unknown, and root oper is equality tst...
  find out what humn value makes TRUE :)

  gonna run..... change values to get rough brute force limits then go
                                                      
              0  -->  110431559298583.71        !=    49160133593649
  49160133593649  --> -747763915721974.54        !=    49160133593649
                  ...so factor ten less..and half...
  2458006679682      67521785547563.65           
  looks like humn has zero effect on arg2...

  also weird fractions on non multiples of 5?
  */
  

  parse var f.i monkey":" does
  monkeys = monkeys monkey /* dunno if we need to keep track? */

  if monkey = 'humn' then do
    humancode = f.i
    iterate
  end
  if monkey = 'root' then do
    rootcode = f.i 
    iterate
  end 

  if words(does) = 1 then do
    msay.monkey = does
    action = 'stored value'
  end
  else do
    mdo.monkey = does
    action = 'stored action'
    badmonkeys = badmonkeys monkey
    end
  /*        
  say time() "Processed "monkey "->" action
  */ 
end

/* PART 2 we can still try and figure out, but not if
root or humn is an arg */
stopitnow = 0
do while words(badmonkeys) > 0 & stopitnow = 0
  say time() "Still" words(badmonkeys) "to solve..."
  newbad = ''
  newstopval = stopval
  do i = 1 to words(badmonkeys)
    m = word(badmonkeys,i)
    parse var mdo.m arg1 op arg2 
    /* check for best case */
    if arg1 ='humn' | arg2 = 'humn' then iterate /* gotta keep it*/
    if msay.arg1 /= '?' & msay.arg2 /= '?' then do
      /* we've (finally?) got these two execute and store*/
      cmd = "val =" msay.arg1 op msay.arg2
      interpret(cmd)
      msay.m = val
      mdo.m = '?' /* as it now says */
      cmd = m "=" val
      interpret(cmd) 
      action = 'stored value  ' val '('m'='val')'
    end
    else do
      newbad = newbad m
      action = 'could not solve'
    end

    say time() "   " i "Tried" m "and" action
    
  end
  if words(newbad) = words(badmonkeys) then do
    say time() "Cannot do anymore" words(badmonkeys) "to go.."
    stopitnow = 1
  end
  else
    badmonkeys = newbad
end




parse var rootcode a": " arg1 op arg2 

say arg1 msay.arg1 arg2 msay.arg2

say time() "We need to solve "arg1 "=" msay.arg2


leftside = translate(arg1)

do i = 1 to words(badmonkeys)
  m = word(badmonkeys,i)
  say m "=" mdo.m 
  if m = arg1 then do 
    solve1 = m "=" mdo.m 
  end
end
say time() solve1 "to start..."

/* we know it's the arg1 that needs solved. as the arg2 resolves to nmbr
   so lets see if we can express arg1 as a function of humn 
   this comments makes no sense out of AoC :)   */

goon = 'yes'
do kkkk = 1 to words(badmonkeys) 
  if goon = 'no' then iterate /* lame stop */
  changed = 0
  do i = 1 to words(badmonkeys)
    m = word(badmonkeys,i)
    does = mdo.m
    parse var does a1 op a2 
    if msay.a1 /= ? & msay.a2 /= ? then do
      cmd = "val="a1 op a2 
      say "CMD ======= "cmd
      interpret(cmd)
      say "Hey, we can solve for" m"=" does "to" val
      mdo.m = '?'
      
      cmd = m "=" val
      interpret(cmd)
      msay.m = val
      changed = changed + 1
    end
    else do
      if msay.a1 /= '?' & msay.a2 = '?' then do 
        say "first arg known" msay.a1 "store wwwbetter"
        mdo.m = msay.a1 op "("strip(mdo.a2)")"
        say "mdo."m mdo.m
        say time() "Added " mdo.m = msay.a1 op "("mdo.a2")"
        changed = changed + 1
      end
      if msay.a1 = '?' & msay.a2 /= '?' then do 
        say "second arg known" msay.a2 "store better"
        mdo.m = "("strip(mdo.a1)")" op msay.a2
        say time() "Added " mdo.m "=" "("mdo.a1")" op msay.a2
        changed = changed + 1
      end
    end
   
  end
  say time() "Done it changed " changed "entries"
  if changed = 0 then goon = 'no'
end


say monkeys
/* last bit ?? */
do i = 1 to words(badmonkeys)
  m = word(badmonkeys,i)
  say m "=" mdo.m 
  /* they get big, so for all 4 chars.. if in monkeys... change with do */
  monkeystoreplace = ''
  do j = 1 to length(mdo.m) - 4
    check = substr(mdo.m,j,4)
    if wordpos(check,monkeys) > 0 then do
      monkeystoreplace = monkeystoreplace m 
    end
  end
  say "replace for " m "these" monkeystoreplace
  replaced = mdo.mm
  do k = 1 to words(monkeystoreplace)
    mm = word(monkeystoreplace,k)
    orig = mdo.m
    mdo.m = strreplace(orig,mm,"("strip(mdo.mm)")")
  end
  
end

do i = 1 to words(badmonkeys)
  m = word(badmonkeys,i)
  say m "=" mdo.m 
  c = "res="mdo.m 
  say c
  trace i
  interpret(c)
  trace off
  say m "-=->" res
end





exit

badmonkey:
  say "boko" rc SIGL
  signal on syntax name badmonkey
  signal on failure name badmonkey

  
strreplace:
ORIGINAL = ARG(1)
OLDTXT = ARG(2)
NEWTXT = ARG(3)
/* YOU CAN CHANGE THE BELOW KEY (TMPTXT), WHICH IS USED AS A TEMPORARY
POINTER TO IDENTIFY THE TEXT TO BE REPLACED */
TMPTXT = '6A53CD2EW1F'
NEWSTR = ORIGINAL
DO WHILE POS(OLDTXT,NEWSTR) > 0
NEWSTR = SUBSTR(NEWSTR, 1 , POS(OLDTXT,NEWSTR)-1) ||,
TMPTXT || SUBSTR(NEWSTR, POS(OLDTXT,NEWSTR) + LENGTH(OLDTXT))
END
DO WHILE POS(TMPTXT,NEWSTR) > 0
NEWSTR = SUBSTR(NEWSTR, 1 , POS(TMPTXT,NEWSTR)-1) ||,
NEWTXT || SUBSTR(NEWSTR, POS(TMPTXT,NEWSTR) + LENGTH(TMPTXT))
END
RETURN NEWSTR



