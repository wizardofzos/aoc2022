/* REXX */
x = bpxwunix('cat input/d12t',,file.,se.)
part1 = 0
part2 = 0




grid. = ''
maxx = length(file.1)
maxy = file.0



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
  end
  say line
end

say "S->"Sx","Sy"("grid.Sy.Sx") ==>"value(Sy,Sx)
say "E->"Ex","Ey"("grid.Ey.Ex") ==>"value(Ey,Ex)



start = Sy','Sx
target = Ey','Ex


allpaths = dfs(start, target,'','',0)

say "paths:" allpaths
part1 = 999
do i = 1 to words(allpaths)
  if word(allpaths, i) < part1 then part1 = word(allpaths,i)
end

say "Part1: "part1
say "Part2: "part2


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
  

dfs: procedure expose grid.

  
  parse arg current, finish, visited, paths, level
  parse var current cy","cx
  parse var finish ty","tx
  say "Nesting level "level
  if level > 40 then do
    /* this is where it breaks :( */
    paths = paths'|'9999
    say paths
    return paths
  end
  /* where can we go? */
  options = valid_moves(current)
  /* is this coord new ?*/
  if wordpos(current,visited) = 0 then do
    visited = visited" "current
  end

  /* check all options */
  do j = 1 to words(options)
    option = word(options,j)
    if option = finish then do
      /* found a path !!*/
      newpath = visited" "option
      say "found a path with length="words(newpath)-1 "=>"newpath
      paths = paths' 'words(newpath)-1
    end
    else do   
      if wordpos(option, visited) = 0 then do
        paths = dfs(option, finish, visited, paths, level+1)
      end
    end
  end

  return paths

  


  
  






