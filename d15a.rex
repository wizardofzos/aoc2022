/* REXX */


x = bpxwunix('cat input/d15',,f.,se.)

say time() "Parsing input"

P1LINE = 10 /* set for test */
P1LINE = 2000000


beacons = ''


sensors = ''

ranges. = 0

nobeacons = ''

nobeaconsonline. = ''

p1 = 0
allnobeacs. = 0
allnobeacs.0 = 0
do i = 1 to f.0
  parse var f.i "Sensor at x="q", y="w": closest beacon is at x="e", y="r 
  sensors = sensors || " " || q || "," || w || "@" || (abs(q-e)+abs(w-r))
  if r = P1LINE then 
    if wordpos(e , beacons) = 0 then
      beacons = beacons e
  if wordpos(q , nobeacons) = 0 then
    if w = P1LINE then do
      nb = allnobeacs.0 + 1
      say allnobeacs.0 nb
      allnobeacs.nb = q
      allnobeacs.0 = nb
    end
end

say allnobeacs.0


soemvals = ''
do i = 1 to words(sensors)
  s = word(sensors,i)
  parse var s sx","sy"@"d
  say time() "Sensor at "sx","sy" has closest beacon on "d
  /* find if any on line 10...smaller dist than d*/
  if abs(sy - P1LINE) > d then do
    say "no need check, y="P1LINE" is not in range of "d  
    iterate
  end

  offsetter = min(sx,sy-P1LINE)
  min1 = sx - d + offsetter 
  min2 = sx - d - P1LINE
  max1 = sx + d - offsetter 
  max2 = sx + d - P1LINE

  vcheck = d - abs(sy-P1LINE)

  if vcheck = 0 then do
    a = abs(sx)
    b = abs(sx)
  end
  else do
    a = abs(sx) - vcheck
    b = abs(sx) + vcheck
  end
  


  nr = ranges.0 + 1
  ranges.nr = a || " " || b
  ranges.0 = nr

 
end



say "--"

minr = word(ranges.1,1)
maxr = word(ranges.1,2)



/* */
say "merging ranges"
do i = 1 to ranges.0
  say "ranges "ranges.i 
  cmin = word(ranges.i,1)
  cmax = word(ranges.i,2)
  if cmin < minr & cmax <= maxr 
  then minr = cmin

  if cmin > minr &  cmax > maxr
  then maxr = cmax

  if cmin > maxr then do
    say "new range ->" cmin "to "cmax
  end
  if cmin < minr & cmax > maxr 
  then do 
    maxr = cmax
    minr = word(ranges.i,1)
  end
say "new => "minr "to" maxr

end
say "Part one answer:" maxr - minr 

/*

ADDRESS SYSCALL
fname = '/prj/repos/aoc2022/d15uitfile'
"writefile (fname) 600 allnobeacs."

x = bpxwunix('sort -u d15uitfile  | wc -l',,so.,se.)
say so.1
*/

