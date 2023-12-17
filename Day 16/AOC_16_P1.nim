import sequtils
import sugar
import tables
import strutils
import algorithm

const corresp_table = {'/' : {2 : 1, 4 : 3, 1 : 2, 3: 4}.toTable,
'\\' : {2 : 3, 4 : 1, 1 : 4, 3: 2}.toTable}.toTable

const directions = {'n' : 1, 'e' : 2 , 's' : 3, 'w' : 4}.toTable

var m : seq[seq[char]]
for line in lines("inputs"):
    m.add(line.toSeq)

var position = (0, -1, 2)
var res : OrderedTable[(int, int, int), int]
var stack : seq[(int, int, int)]
var done : seq[(int, int, int)]

stack.add(position)
while stack.len != 0:
    var new_pos = stack.pop()

    # Move depending on the direction
    case new_pos[2]
        of 2 : new_pos[1] += 1
        of 4 : new_pos[1] -= 1
        of 1 : new_pos[0] -= 1
        of 3 : new_pos[0] += 1
        else: discard

    # Check if this position already visited
    if new_pos in done:
        continue
    done.add(new_pos)

    # What is on the pos ?
    var info = '.'
    try:
        info = m[new_pos[0]][new_pos[1]]
    except:
        ## OOB
        continue

    case info
        of '/': new_pos[2] = corresp_table['/'][new_pos[2]]
        of '\\' : new_pos[2] = corresp_table['\\'][new_pos[2]]
        of '|' : 
            if new_pos[2] == 2 or new_pos[2] == 4:
                var tmp = new_pos
                tmp[2] = 1
                stack.add(tmp)
                tmp[2] = 3
                stack.add(tmp)
                continue
        of '-' : 
            if new_pos[2] == 1 or new_pos[2] == 3:
                var tmp = new_pos
                tmp[2] = 2
                stack.add(tmp)
                tmp[2] = 4
                stack.add(tmp)
                continue  
        else: discard
    
    stack.add(new_pos)

var total : seq[(int, int)]
for elt in done:
    if (elt[0] >= 0) and (elt[1] >= 0) and (elt[0] < m.len) and (elt[1] < m[0].len):
        total.add((elt[0], elt[1]))

echo total.deduplicate.len
