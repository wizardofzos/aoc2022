/* REXX */

x = bpxwunix('cat input/d21',,f.,se.)

NUMERIC DIGITS 15



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
    msay.monkey = does + 0.000
    action = 'stored value' does 'for' monkey
  end
  else do
    mdo.monkey = does
    msay.monkey = '?'
  end


  action = 'stored action' does 'for' monkey 
    
  

  /* say time() "Processed "monkey "->" action */
end

drop f.

root = solve('root')
say "root" root
exit

do while root = '?'
  say time() "Solve root: " root
  root = solve('root')
end



exit

solve: procedure expose mdo. msay. 
  parse arg m
   
  if msay.m /= '?' then do
    return msay.m
  end

  parse var mdo.m arg1 op arg2



  select 
    when msay.arg1 /= '?' & msay.arg2 /= '?' then do
      val = notinterpret(msay.arg1, op, msay.arg2)
      msay.m = val
      return val
    end

    when msay.arg1 = '?' & msay.arg2 /= '?' then do
      s1 = solve(arg1)
      msay.arg1 = s1
      val = notinterpret(s1,op,msay.arg2)
      msay.m = val
      return val



    end
    
    when msay.arg1 /= '?' & msay.arg2 = '?' then do
      s2 = solve(arg2)
      msay.arg2 = s2
      val = notinterpret(msay.arg1,op,s2)
      return val
    end

    when msay.arg1 = '?' & msay.arg2 = '?' then do
      


      parse var mdo.arg2 arg2var1 op2 arg2var2
      val1 = solve(arg2var1,n)
      val2 = solve(arg2var2,n)
      msay.arg2 = notinterpret(val1,op2,val2)

      parse var mdo.arg1 arg1var1 op1 arg1var2
      
      val1 = solve(arg1var1)
      val2 = solve(arg1var2)
      msay.arg1 = notinterpret(val1,op1,val2)

      return notinterpret(msay.arg1,op,msay.arg2)
      
    
      
    end

    otherwise do
      say "udderijs"
    end
  end

  return '?'
     
     




  notinterpret: procedure
    parse arg a,b,c 
    
    a = a + 0.000
    c = c + 0.000

    /* let's not do interpret again :) */
    if b = '+' then res =  a + c
    if b = '-' then res =  a - c
    if b = '/' then res =  a / c
    if b = '*' then res =  a * c
    
    if b = '/' then do
      say a b c "=" res
    end
    
    
    return res
    return "BAD"











