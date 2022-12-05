/* REXX */
x = bpxwunix('cat input/d05t',,file.,se.)
part1 = 0
part2 = 0

STATE = 'LAYOUT'

stacks. = ''
maxstack = 0
moves.  = 0

do i = 1 to file.0
  if STATE = 'MOVELIST' then do
    mi = moves.0 + 1
    parse var file.i "move"amt"from"src"to"target
    moves.mi = amt' 'src' 'target
    moves.0 = mi
  end

  if STATE = 'LAYOUT' then do
    /* Let's do this smart/lazy/error-prone :) */  
    stackidx = 1
    do j = 2 to 100 by 4 
      if length(file.i) < j then leave
      item = substr(file.i, j, 1)
      if item /= '' & datatype(item) /= 'NUM' then do
        stacks.stackidx = stacks.stackidx || item
      end
      stackidx = stackidx + 1
      if stackidx > maxstack then maxstack = stackidx -1
    end
  end
  if file.i = "" then 
    STATE = 'MOVELIST'


end


/* flip the stacks */
do i = 1 to maxstack
  stacks.i = reverse(stacks.i)
end

stacks2. = 0
do jjj = 1 to maxstack
  stacks2.jjj = stacks.jjj
end
say "HJERE"
say stacks2.1

/* do part one */
do i = 1 to moves.0
  say moves.i
  amt = word(moves.i,1)
  src = word(moves.i,2)
  tgt = word(moves.i,3)
  tomove = substr(stacks.src,length(stacks.src)-amt+1)
  tomove2 = substr(stacks2.src,length(stacks2.src)-amt+1)
  stacks.tgt = stacks.tgt || reverse(tomove)
  stacks2.tgt = stacks2.tgt || tomove
  stacks.src = substr(stacks.src,1,length(stacks.src)-amt)
  if amt = length(stacks2.src) 
  then stacks2.src = ''
  else stacks2.src = substr(stacks2.src,1,length(stacks2.src)-amt)
  do k = 1 to maxstack
    say stacks2.k
  end
end
/* Part One */
p1 = ''
p2 = ''
do i = 1 to maxstack
  p1 = p1 || substr(stacks.i, length(stacks.i), 1)
  p2 = p2 || substr(stacks2.i, length(stacks2.i), 1)
end
say "Part one: "p1
say "Part two: "p2








