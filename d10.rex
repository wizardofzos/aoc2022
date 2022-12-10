/* REXX */
x = bpxwunix('cat input/d10',,file.,se.)
part1 = 0
part2 = 0

instpointer = 1
currinst = file.instpointer
q = 1
X = 1
cycle = 0

do forever
  cycle = cycle + 1

   if cycle = 20 | (cycle - 20) // 40 = 0 then do
    s = cycle * X
    say "Cycle "cycle" X= " X " signal=" X * cycle
    part1 = part1 + (X * cycle)
  end


  parse var currinst op" "arg
  select
    when op = "noop" then do
      instpointer = instpointer + 1
      currinst = file.instpointer
    end

    when op = "addxdo" then do
      X = X + arg
      instpointer = instpointer + 1
      currinst = file.instpointer
    end

    when op = "addx" then do
      currinst = 'addxdo 'arg
    end



    otherwise do
      say "Bad Operator"
    end
  end

  /*
  
  */

 

  if instpointer > file.0 then leave
end


say "Part one: "part1
say "Part two: "part2








