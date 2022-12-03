/* REXX */

x = bpxwunix('cat input/d03',,file.,se.)

values = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
part1 = 0
part2 = 0
group. = 0
do i = 1 to file.0
  
  gc = group.0 + 1
  group.gc = file.i
  group.0 = gc

  if group.0 = 3 then do
    /* there should be one char in all three only*/
    do j = 1 to length(group.1)
      g2 = pos(substr(group.1,j,1),group.2)
      g3 = pos(substr(group.1,j,1),group.3)
      if g2 > 0 & g3 > 0 then do
        say "Common = "substr(group.1,j,1)
        part2 = part2 +  pos(substr(group.1,j,1), values)
        leave
      end
    end
    group. = 0
  end



  c1 = substr(file.i,1,length(file.i)/2)
  c2 = substr(file.i,(length(file.i)/2)+1)
  common = ''
  do p1 = 1 to length(c1)
    if pos(substr(c1,p1,1), c2) >= 1 then do
      common = substr(c1,p1,1)
      part1 = part1 + pos(common, values)
      leave
    end
  end
  
end
say "Part one: "part1
say "Part two: "part2







