/* REXX */
x = bpxwunix('cat input/d12',,file.,se.)
part1 = 0
part2 = 0




grid. = ''
maxx = length(file.1)
maxy = file.0

queue. = 0

starts = ''

/* Parse the input */
do i = 1 to file.0 
   do j = 1 to length(file.i)
     val = substr(file.i,j,1)
     if val = 'S' then do
       Sx = j
       Sy = i
     end
     if val = 'E' then do
       Ex = j
       Ey = i
     end
     grid.i.j = val
   end
end

do y = 1 to maxy
  line = ''
  do x = 1 to maxx
    line = line || grid.y.x
    if grid.y.x = 'a' then starts = starts y || "," || x
  end
  say line
end

say "S->"Sx","Sy"("grid.Sy.Sx") ==>"value(Sy,Sx)
say "E->"Ex","Ey"("grid.Ey.Ex") ==>"value(Ey,Ex)



start = Sy','Sx
finish = Ey','Ex
alldone = 0


/* TEST FOR QUEUE IN REXX. SHOULD PRINT aap THEN noot :) */
queue.1 = 'aap'
queue.2 = 'noot'
queue.3 = 'mies'
queue.0 = 3

say queuepopleft()
say queuepopleft()

/* END OD TEST */



p1 = bfs(start,finish,1)
say "Part 1:" p1
/* find all possible 'a' starting points... and check shortest.. */
min = p1
say "evaluating "words(starts)" start positions"
do i = 1 to words(starts)
  say time() "Trying" word(starts,i) "(current min="min")"
  st = word(starts,i)
  parse var st ty","tx
  if tx < Sx | ty < Sy then do 
    say "skip"
    iterate
  end
  cp2 = bfs(word(starts,i),finish,min)
  say time() "Path to finish =" cp2 "long"
  if cp2 = "CANT BE HERE" then cp2=1000
  if cp2 < min then min = cp2
end
say "Part2:" min
exit

value: procedure expose grid.
  arg y,x
  vals = 'abcdefghijklmnopqrstuvwxyz'
  if y > 0 | x > 0 then
    check = grid.y.x
  else
    return -1
  
  if check = 'S' then check = 'a'
  if check = 'E' then check = 'z'
  if check = ' ' then return -1

  return pos(check, vals)

bfs: procedure expose grid. maxx maxy queue.
  parse arg start,finish,p
  
  seen = ''
  queue.1 = start
  queue.0 = 1
  do while queue.0 > 0
    path  = queuepopleft()
    last = word(path,words(path))
    if wordpos(last,seen) = 0 then do
      seen = seen strip(last)
      if p > 1 then do
        if words(path) > p then do
          say "Path from" start "too long, stopping"
          return p+100
        end
      end
      if last = finish then do
        return words(path) - 1
      end
      parse var last ly","lx
      x = strip(lx)
      y = strip(ly)
      h1 = value(y,x)
      moves = ""
      if y - 1 > 0 then moves = moves || " " || y-1 || "," || x
      if y + 1 <= maxy then moves = moves || " " || y+1 || "," || x
      if x - 1  > 0 then moves = moves || " " || y || "," || x-1
      if x + 1  <= maxx then moves = moves || " " || y || "," || x+1
      do k = 1 to words(moves)
        pwrd = word(moves,k)
        parse var pwrd my","mx
        my = strip(my)
        mx = strip(mx) 
        h2 = value(my,mx)
        if h2 <= h1 + 1 then do
          newpath = path word(moves,k)
          nq = queue.0 + 1
          queue.nq = newpath
          queue.0 = nq
        end

      end
    end
  end 
  return "CANT BE HERE"

queuepopleft: procedure expose queue.
  localq. = 0
  donesumfing = 'n'
  res = queue.1
  if queue.0 = 1 then do
    queue.0 = 0
    return queue.1
  end
  do i = 2 to queue.0
    nl = localq.0 + 1
    localq.nl = queue.i
    localq.0 = nl
    donesumfing = 'y' 
  end
  if donesumfing = 'y' then do 
    queue.0 = queue.0 - 1
    do i = 1 to queue.0
      queue.i = localq.i
    end 
    return res
  end

  say "POPPING EMPTY QUEUE????"
  return "EMPTY" 
  
  
  popleft: procedure
  parse arg q
  w = words(q)
  r = ''
  popped = word(q,1)
  do i = 2 to words(q)
    r = strip(r) word(q,i)
  end
  return popped || "<" || r 

popright: procedure
  parse arg q
  w = words(q)
  r = ''
  popped = word(q,words(q))
  do i = 1 to words(q) - 1
    r = strip(r) word(q,i)
  end
  return popped || "<" || r 

valid_moves: procedure expose grid.
  arg pos
  res = ''
  parse var pos ypos","xpos
  curval = value(ypos,xpos)
  /* check up */
  uy = ypos - 1
  uval = value(uy,xpos)
  if uval > 0 & abs((uval-curval)) <= 1 then res = res || uy","xpos" "
  /* check down */
  dy = ypos + 1
  dval = value(dy,xpos)
  if dval > 0 & abs((dval-curval)) <= 1 then res = res || dy","xpos" "
  /* check left */
  lx = xpos - 1
  lval = value(ypos,lx)
  if lval > 0 & abs((lval-curval)) <= 1 then res = res || ypos","lx" "
  /* check right */
  rx = xpos + 1
  rval = value(ypos,rx)
  if rval > 0 & abs((rval-curval)) <= 1 then res = res || ypos","rx" "
  return res


