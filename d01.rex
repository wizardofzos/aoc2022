/* REXX */

x = bpxwunix('cat input/d01',,file.,se.)

elves. = 0
elf = 0

do i = 1 to file.0
  if file.i /= '' then
    elves.elf = elves.elf + file.i
  else 
    elf = elf + 1
end


/* Sorting stems in z/OS REXX is so easy :) */
tosort = ''
do i = 0 to elf
  tosort = tosort" "elves.i
end

cmd = 'echo "'tosort'" | tr " " "\n" | sort -n | tr "\n" " ";echo'
x = bpxwunix(cmd,,sorted., se.)

say "Part one: "word(sorted.1, elf+1)
p2 = word(sorted.1, elf+1) + word(sorted.1, elf) + word(sorted.1, elf-1)
say "Part two: "p2






