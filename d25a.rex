/* REXX */

x = bpxwunix('cat input/d25',,f.,se.)

NUMERIC DIGITS 643

summed = 0
do i = 1 to f.0
  realval = snafu(f.i)
  say "READ "f.i "but that means" realval "(check back "desnafu(realval)   
  summed = summed + realval
end

say "Sum: "summed "SNAFU:"desnafu(summed)

exit

snafu: procedure
  parse arg str
  val = 0
  str = reverse(str)
  do i = 1 to length(str)
    mval = 5 ** (i-1) 
    mult = snafuval(substr(str,i,1))
    val = val + (mval*mult) 
  end

  return val


snafuval: procedure
  parse arg d
  if d = 2 then return 2
  if d = 1 then return 1
  if d = 0 then return 0
  if d = "-" then return -1
  if d = "=" then return -2


desnafu: procedure
  parse arg d
  snafu = ''
  i = 0
  do forever
    if ((5 ** i) * 2) >= d then do
      leave 
    end
    else do
      i = i + 1
    end
  end
  do while i >= 0
    opti = '='
    low = weirdcalc(opti,d,i)
    do p = -1 to 2   
      pick = desnafuval(p)
      val = weirdcalc(pick,d,i)
      if abs(val) < low then do
        low = abs(val)
        opti = pick  
      end 
    end
    d = weirdcalc(opti,d,i) 
    snafu = snafu || opti
    i = i - 1
  end
  return snafu

desnafuval: procedure
  parse arg s
  if s = -2  then return '='
  if s = -1  then return '-'
  if s = '0' then return 0
  if s = '1' then return 1
  if s = '2' then return 2


weirdcalc: procedure
  parse arg s,d,i 
  if s = '=' then val = d + (5 ** i) * 2
  if s = '-' then val = d + (5 ** i)
  if s = '0' then val = d
  if s = '1' then val = d - (5 ** i)
  if s = '2' then val = d - (5 ** i) * 2
  return val 
