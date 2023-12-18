import sugar
import sequtils
import strutils

var infos : seq[(string, int, string)]
for line in lines("inputs"):
    let spl = line.split(" ")
    infos.add((spl[0], spl[1].parseInt, spl[2]))

var new_infos: seq[(int, int)]
for elt in infos:
    let stripped = elt[2].strip(chars = {'(', ')', '#'})
    new_infos.add((stripped[^1..^1].parseInt, stripped[0..^2].parseHexInt))

# Determine the size of the matrix
var w = 0
var n = 0

for elt in new_infos:
    case elt[0]:
        of 3 : n += elt[1]
        of 2 : w += elt[1]
        else: discard

# Do the thing
var pos = ((n/2).toInt, (w/2).toInt)

# Sommets
var sommets : seq[(int, int)]
sommets.add(pos)

# Bounds
var bounds = 0

for elt in new_infos:
    case elt[0]:
        of 3: 
            for i in 0..(elt[1] - 1):
                pos[0] -= 1
                bounds += 1
        of 1:
            for i in 0..(elt[1] - 1):
                pos[0] += 1
                bounds += 1
        of 2:
            for i in 0..(elt[1] - 1):
                pos[1] -= 1
                bounds += 1
        of 0:
            for i in 0..(elt[1] - 1):
                pos[1] += 1
                bounds += 1
        else: discard
    sommets.add(pos)

# Shoelace + Pick
var res = 0
for idx in 0..(sommets.len - 2):
    res += ((sommets[idx][0] * sommets[idx + 1][1]) - (sommets[idx][1] * sommets[idx + 1][0]))
echo ((abs(res)/2).toInt + 1) - (bounds / 2).toInt + bounds