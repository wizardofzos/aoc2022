/* REXX */

x = bpxwunix('cat input/d25',,f.,se.)

NUMERIC DIGITS 32

summed = 0
do i = 1 to f.0
  realval = snafu(f.i)
  say "READ "f.i "but that means" realval
  summed = summed + realval
end

say "Sum: "summed
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
  
  end
