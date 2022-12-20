/* REXX */

/* Work in progress for part 2... works for the test data...
not the real thing... :) pushing anyway :)
*/

x = bpxwunix('cat input/d18',,f.,se.)

say time() "Parsing input"

grid. = -1 /* -1 = air */
maxa = 0
maxb = 0
maxc = 0 



part1 = 0
lavacubes = ''
air = ''
do i = 1 to f.0
  parse var f.i aa","bb","cc
  grid.aa.bb.cc = 1 /* lava */
  maxa = max(maxa,aa)
  maxb = max(maxb,bb)
  maxc = max(maxc,cc)
  lavacubes = lavacubes aa || ',' || bb || ',' || cc
end



part2 = 0
nblist = ''
do a = 0 to maxa               /* Thanks Erik, for making me use*/
  do b = 0 to maxb             /* trace i to see that there's 0 values */
    do c= 0 to maxc            /* that the iterate broke on :) */
      newnb = ''
      gpos = a || ',' || b || ',' || c
      if grid.a.b.c = 1  then do
        nb = neighbours(a,b,c,1,1) /* lava with lava neighbours*/
        if nb /= 0 then do
          say gpos "has "words(nb) "neighbours:" nb 6 - words(nb) "open faces"
          

        end
        part1 = part1 + 6 - words(nb)
        
      end
    end
  end
end

say "Part 1: " part1
say part2


/* Part 2 : we need only the 'outside' surface area? 
The steam will expand to reach as much as possible, completely displacing 
any air on the outside of the lava droplet but never expanding diagonally.

so fill all grids with -2 (water) if on outside of connected cubes?

need some 'edge detection'??

o detect the number of outside faces in a set of cube locations, 
you can use the following steps:

    Iterate through each cube in the set.
    For each cube, check if it is adjacent to any other cubes. 
    If it is not adjacent to any other cubes, then it has 4 outside faces. 
    If it is only adjacent to one other cube, it has 2 outside faces. 
    If it is adjacent to two or more other cubes, it has 0 outside faces.
    Sum up the number of outside faces for each cube to get the total 
    number of outside faces in the set.


*/
connectedcubes = ''
cca = ''

do kkk = 1 to words(lavacubes)
  outcube = word(lavacubes,kkk)
  
  parse var outcube ix","iy","iz
  if grid.ix.iy.iz = 1 then t = 'lava'
  if grid.ix.iy.iz = -1 then t = 'air'
  if grid.ix.iy.iz = 2 then t = 'water'
  say outcube t
  nbl = neighbours(ix,iy,iz,1,1) outcube
  nba = neighbours(ix,iy,iz,1,-1)  
  nbw = neighbours(ix,iy,iz,1 ,2)  
  addme = 1

  do jj = 1 to words(nbl)

    clava = strip(word(nbl, jj))
    cc = translate(connectedcubes,' ', '|')
    if wordpos(clava, cc) > 0 then do 
      addme = 0
    end

  end
  if addme = 1 & nbl /= '' then do
    connectedcubes = connectedcubes translate(strip(nbl),'|',' ') " "
    cca = cca words(nbl)

  end


end


say connectedcubes 
say cca

part2 = 0
say part2



do i = 1 to words(connectedcubes) 
  cubes = word(connectedcubes,i)
  cubes = translate(cubes,' ', '|')
  say time() "connected cubes: "cubes
  if words(cubes) = 1 then do
    say time() cubes "Has only 1 so add 6"
    part2 = part2 + 6
  end
  else do
    say time() cubes "has multiple so check em"
    do j = 1 to words(cubes)
      myscore = 0
      subcube = word(cubes,j)
      
      parse var subcube ix","iy","iz
      nb = neighbours(ix,iy,iz,1,-1)
      nbs = words(nb)
      say time() "Cheking" subcube nbs "neighbours"
      add = 0
      if nbs = 0 then do
        add = 4
        say time() "zero neighbours..so add 4"
      end
      if nbs = 1 then do
        add = 2
        say time() "1 neighbours..so add 2"
      end
      say time() subcube "checked, adding "add
      part2 = part2 + add
    end
  end
end



say "Part 2" part2

exit





neighbours: procedure expose grid.
  parse arg lx,ly,lz,t1,t2
  /* checks if this grid is a t1 and yields t2 neighbours*/
  res = 0

  nblist = ''


  x1 = lx-1
  x2 = lx+1
  y1 = ly-1
  y2 = ly+1
  z1 = lz-1
  z2 = lz+1


  if grid.lx.ly.lz /= t1 then return ''

  if x1 > 0 then
    if grid.x1.ly.lz = t2 then
      nblist = nblist x1","ly","lz
  if x2 > 0 then
    if grid.x2.ly.lz = t2 then
      nblist = nblist x2","ly","lz


  if y1 > 0 then 
    if grid.lx.y1.lz = t2 then
      nblist = nblist lx","y1","lz
  if y2 > 0 then 
    if grid.lx.y2.lz = t2 then
      nblist = nblist lx","y2","lz

  if z1 > 0 then
    if grid.lx.ly.z1 = t2 then
      nblist = nblist lx","ly","z1
  if z2 > 0 then
    if grid.lx.ly.z2 = t2 then
      nblist = nblist lx","ly","z2


  return nblist


connected: procedure expose grid.
  parse arg lx,ly,lz,rx,ry,rz 

  /* gpt says 
  To determine if two cubes share a face, you can check if their coordinates 
  are such that one of their faces lies directly against the other's face. 
  For example, you could check if the distance between their x-coordinates, 
  y-coordinates, and z-coordinates is equal to the length of the side 
  of the cubes.
  */
  
  return abs(lx-rx) + abs(ly-ry) + abs(lz-rz) 




