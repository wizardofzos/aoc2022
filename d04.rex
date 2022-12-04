/* REXX */
x = bpxwunix('cat input/d04',,file.,se.)
part1 = 0
part2 = 0

do i = 1 to file.0
  parse var file.i x1"-"y1","x2"-"y2
  maxx = max(x1,x2)
  miny = min(y1,y2)
  if (maxx = x1 & miny = y1) | (maxx = x2 & miny = y2) then do
    part1 = part1 + 1
    part2 = part2 + 1
  end
  else do
    if x1 <= x2 then do
      if x2 <= y1 then
        if y1 <= y2 then do
          part2 = part2 + 1
        end
    end
    else if x2 <= x1 then do
        if x1 <= y2 then
          if y2 <= y1 then do
            part2 = part2 + 1
          end
    end
  end
end
say "Part one: "part1
say "Part two: "part2







