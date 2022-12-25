/* REXX */

x = bpxwunix('cat input/d21',,f.,se.)

NUMERIC DIGITS 1001

msay. = '?'
mdo. = '?'

do i = 1 to f.0
  /* we get a list of monkey-say, monkey-do
  aaaa = x (monkey say)
  bbbb = aaaa ? cccc (monkey does arithmic operator ? on aaaa and cccc
  
  */
  parse var f.i monkey":" does
  
  if monkey = 'humn' then do
    /* we get the human :)*/
    humanstring = does
  end
  if monkey = 'root' then do 
    /* we get the root */
    rootstring = does
  end 
  if words(does) = 1 then do
    msay.monkey = does
    mon.monkey = does
    action = 'stored value' does 'for' monkey
  end
  else do
    mdo.monkey = does
    msay.monkey = '?'
  end


  action = 'stored action' does 'for' monkey 
    
  

  say time() "Processed "monkey "->" action
end

drop f.

root = solve('root',1)
say "root" root
exit

do while root = '?'
  say time() "Solve root: " root
  root = solve('root',1)
end



exit

solve: procedure expose mdo. msay. 
  parse arg m
  
   say n "looking for" m "(start as "mdo.m "or" msay.m")"  
   
  if msay.m /= '?' then do
    say n" return for" m "-->" msay.m

    return msay.m
  end
  else do
    say nest"    Dunno this " m "Monkey....yet...."
    parse var mdo.m arg1 op arg2
    say mdo.m "parsed as arg1="arg1", arg2="arg2", op="op

    say nest" checking" msay.arg1 "("arg1")" op msay.arg2 "("arg2")"


    select 
      when msay.arg1 /= '?' & msay.arg2 /= '?' then do
        say m"   --> pairs known" msay.arg1 op msay.arg2
        val = notinterpret(msay.arg1, op, msay.arg2)
        msay.m = val
         say nest" Returning from call --> "val
        return val
      end

      when msay.arg1 = '?' & msay.arg2 /= '?' then do
        say nest" ARG1 unknown, solving it"
        s1 = solve(arg1)
        msay.arg1 = s1
        say nest "ARG1 unknown, but solved as" s1
        val = notinterpret(s1,op,msay.arg2)
        msay.m = val
        return val



      end
      
      when msay.arg1 /= '?' & msay.arg2 = '?' then do
       say nest "ARG2 unknown, solving it"
       s2 = solve(arg2,n)
       msay.arg2 = s2
       say nest "ARG2 unknown, but solved as" s2
       val = notinterpret(s2,op,msay.arg1)
       return val
      end

      when msay.arg1 = '?' & msay.arg2 = '?' then do
       say nest " *********  Otherwisey..."arg1 arg2
       


       parse var mdo.arg2 arg2var1 op2 arg2var2
       val1 = solve(arg2var1,n)
       say nest"***** arg2 ok" val1
       val2 = solve(arg2var2,n)
       say nest " *********  solved" val1 val2
       say nest " -=-=-=-=-" val1 op  val2  "22222222222222222 INTERPRETP"
       msay.arg2 = notinterpret(val1,op2,val2)

       parse var mdo.arg1 arg1var1 op1 arg1var2
       say mdo.arg1 arg1var1 op1 arg1var2
       val1 = solve(arg1var1)
       say nest "***** arg1 ok" val1
       val2 = solve(arg1var2)
       say nest " *********  solved" val1 val2
       say nest " -=-=-=-=-" val1 op  val2  "11111111111111111 INTERPRETP"
       msay.arg1 = notinterpret(val1,op1,val2)

       return notinterpret(msay.arg1,op,msay.arg2)
       
      
       
      end

      otherwise do
        say "udderijs"
      end
    end
  end
  return '?'
     
     




  notinterpret: procedure
    parse arg a,b,c 
    /* let's not do interpret again :) */
    
    if b = '+' then return a + c
    if b = '-' then return a - c
    if b = '/' then return a / c
    if b = '*' then return a * c
    return "BAD"


