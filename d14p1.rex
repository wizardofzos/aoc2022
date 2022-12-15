/* REXX */
x = bpxwunix('cat input/d14t',,file.,se.)
part1 = 0
part2 = 0

grid. = '.'

minx = 500
maxx = 500
maxy = 0

say time() "Parsing input"
do i = 1 to file.0
  parse var file.i coord '->' rest
  parse var coord sx","sy
  if sx < minx then 
    minx = sx
  if sx > maxx then 
    maxx = sx
  if sy > maxy then
    maxy = sy
  grid.sx.xy = '#'
  do while coord /= ''
    coord = strip(coord)
    parse var coord nx","ny
    if nx < minx then 
      minx = nx
    if nx > maxx then
      maxx = nx
    if ny > maxy then
      maxy = ny
    if nx = sx then do
      /* we move up/down*/
      if sy < ny then do
        do y = sy to ny
          grid.nx.y = '#'
        end
      end
      else do
        do y = sy to ny by -1
          grid.nx.y = '#'
        end
      end
    end
    else do
      /* we must be left/right */
      if sx < nx then do
        do x = sx  to nx
          grid.x.ny = '#'
        end
      end
      else do
        do x = sx  to nx by - 1
          grid.x.ny = '#'  
        end
      end
    end  

    parse var rest coord '->' rest
    sx = nx
    sy = ny
  end
end

/* sand sprout */
grid.500.0 = '+'
say "Minx = "minx

/* for part 2 only */
do kk = 0 to maxx + 10
  floor = maxy + 2
  grid.kk.floor = '#'
end

/* initial view */
say "Inital view..."
call print

say "minx="minx
say "maxx="maxx
say "maxy="maxy

say time() "Simulating sand drops.."
sands = 0

do forever
  /* well not really forever, there's an exit somewhere... */
  sandx = 500
  sandy = 0
  sands = sands + 1
  moving = 'yes'
  /* drop down */
  do while moving = 'yes'                    
    /* did we reach the abyss ?? */
    if sandx < minx | sandy > maxy then do 
      say time() "The abyss!!!! (sandy="sandy
      call print
      say time() "Sand units:" sands - 1
      exit
    end
    newy = sandy + 1                           /* down drop */ 
    if isthisa('air', sandx, newy) = 1 then do
      sandy = newy
    end
    else do
      /* try left-down */
      newx = sandx - 1
      if isthisa('air', newx, newy) = 1 then do
        sandx = newx
      end
      else do /* cant go left down, try right down */
        newx = sandx + 1
        if isthisa('air', newx, newy) = 1 then do
          sandx = newx
        end
        else do
          grid.sandx.sandy = 'o'
          moving = 'no'
        end
      end
    end
  end
end
call print

exit

print: 
/* Print TEST INPUT grid */
  do printy = 0 to maxy +3
    printline = ''
    do printx = minx - 5 to maxx + 5
      printline = printline || grid.printx.printy
    end
    say printline
  end
  return

isthisa: procedure expose grid.
  parse arg what,airx,airy
  if what = 'rock' then lookup = '#'
  if what = 'air'  then lookup = '.'
  if what = 'sand' then lookup = 'o'
  if what = 'abyss' then lookup = '|'
  if grid.airx.airy = lookup then
    return 1
  else
    return 0
