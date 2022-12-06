/* REXX */
x = bpxwunix('cat input/d06',,file.,se.)
part1 = 0
part2 = 0


do i = 1 to file.0
  /* FIND first char in blocks of 4 that's unique*/
  do j = 4 to length(file.i)
    chunk = substr(file.i,j-3,4)
    marker = 1
    do k = 1 to 4
      p = pos(substr(chunk,k,1), chunk, k+1)
      if p > 0 then do 
        marker = 0
        leave
      end
    end
    if marker = 1 then do
      part1 = j
      j=10000
    end
  end
end

do i = 1 to file.0
  /* FIND first char in blocks of 4 that's unique*/
  do j = 14 to length(file.i)
    chunk = substr(file.i,j-13,14)
    marker = 1
    do k = 1 to 14
      p = pos(substr(chunk,k,1), chunk, k+1)
      if p > 0 then do 
        marker = 0
        leave
      end
    end
    if marker = 1 then do
      part2 = j
      j=10000
    end
  end
end



say "Part one: "part1
say "Part two: "part2








