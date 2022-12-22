/* REXX */

x = bpxwunix('cat input/d21',,f.,se.)

NUMERIC DIGITS 21

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
  
  */
  parse var f.i monkey":" does
  monkeys = monkeys monkey /* dunno if we need to keep track? */
  
  if words(does) = 1 then do
    msay.monkey = does
    action = 'stored value'
  end
  else do
    mdo.monkey = does
    action = 'stored action'
    badmonkeys = badmonkeys monkey
    end

  say time() "Processed "monkey "->" action
end

do while words(badmonkeys) > 0
  say time() "I've got" words(badmonkeys) badmonkeys "to fix.."
  newbad = ''
  do i = 1 to words(badmonkeys)
    m = word(badmonkeys,i)
    parse var mdo.m arg1 op arg2 
    /* check for best case */
    if msay.arg1 /= '?' & msay.arg2 /= '?' then do
      /* we've (finally?) got these two execute and store*/
      cmd = "val =" msay.arg1 op msay.arg2
      interpret(cmd)
      msay.m = val
      cmd = m "=" val
      interpret(cmd) 
      action = 'stored value' val '('m'='val')'
    end
    else do
      newbad = newbad m
      action = 'could not solve'
    end
    say time() "   " i "Tried" m "and" action
  end
  badmonkeys = newbad
end

say time() "All monkeys accounted for..."

say time() "Monkey root has value:" root


say starttime "Was when I started"

exit

badmonkey:
  say "boko" rc SIGL
  rc=0
  resume
  
 



