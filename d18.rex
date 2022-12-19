/* REXX */


x = bpxwunix('cat input/d18h',,f.,se.)

say time() "Parsing input"

grid. = -1
maxa = 0
maxb = 0
maxc = 0 



part1 = 0
say f.0 "RECS"
do i = 1 to f.0
  parse var f.i aa","bb","cc
  grid.aa.bb.cc = 1
  maxa = max(maxa,aa)
  maxb = max(maxb,bb)
  maxc = max(maxc,cc)
end




nblist = ''
do a = 0 to maxa               /* Thanks Erik, for making me use*/
  do b = 0 to maxb             /* trace i to see that there's 0 values */
    do c= 0 to maxc            /* that the iterate broke on :) */
      newnb = ''
      gpos = a || ',' || b || ',' || c
      if grid.a.b.c /= -1  then do
        nb = neighbours(a,b,c)
        if nb /= 0 then do
          say gpos "has "words(nb) "neighbours:" nb 6 - words(nb) "open facets" 
        end
        part1 = part1 + 6 - words(nb)
      end
    end
  end
end


say "Part 1: " part1

exit

neighbours: procedure expose grid.
  parse arg lx,ly,lz
  
  res = 0

  nblist = ''


  x1 = lx-1
  x2 = lx+1
  y1 = ly-1
  y2 = ly+1
  z1 = lz-1
  z2 = lz+1


  if grid.lx.ly.lz = -1 then return ''

  
  if grid.x1.ly.lz /= -1 then
    nblist = nblist x1","ly","lz
  if grid.x2.ly.lz /= -1 then
    nblist = nblist x2","ly","lz

  if grid.lx.y1.lz /= -1 then
    nblist = nblist lx","y1","lz
  if grid.lx.y2.lz /= -1 then
    nblist = nblist lx","y2","lz

  if grid.lx.ly.z1 /= -1 then
    nblist = nblist lx","ly","z1
  if grid.lx.ly.z2 /= -1 then
    nblist = nblist lx","ly","z2


  return nblist




