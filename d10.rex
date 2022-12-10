/* REXX */
x = bpxwunix('cat input/d10',,file.,se.)
part1 = 0
part2 = 0

instpointer = 1
currinst = file.instpointer
q = 1
X = 1
cycle = 0


crtx = 40
crty = 6

crt = ''




do forever
  cycle = cycle + 1
 
  if cycle = 20 | (cycle - 20) // 40 = 0 then do
    s = cycle * X
    say "Cycle "cycle" X= " X " signal=" X * cycle
    part1 = part1 + (X * cycle)
  end

  
  xval = (cycle -1 ) // 40

  say "Cycle "cycle", xval=" xval " X = " X
  if xval = X - 1 | xval = X | xval = X + 1 then do
    crt = crt || "#"
  end
  else do
    crt = crt || "."
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



say "Part two: "
do i = 1 to length(crt) by 40
  say substr(crt,i,40)
end













