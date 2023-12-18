import strutils

var infos : seq[(string, int, string)]
for line in lines("inputs"):
    let spl = line.split(" ")
    infos.add((spl[0], spl[1].parseInt, spl[2]))

# Determine the size of the matrix
var w = 0
var n = 0

for elt in infos:
    case elt[0]:
        of "U" : n += elt[1]
        of "L" : w += elt[1]

# Do the thing
var pos = ((n/2).toInt, (w/2).toInt)

# Sommets
var sommets : seq[(int, int)]
sommets.add(pos)

# Bounds
var bounds = 0

for elt in infos:
    case elt[0]:
        of "U": 
            for i in 0..(elt[1] - 1):
                pos[0] -= 1
                bounds += 1
        of "D":
            for i in 0..(elt[1] - 1):
                pos[0] += 1
                bounds += 1
        of "L":
            for i in 0..(elt[1] - 1):
                pos[1] -= 1
                bounds += 1
        of "R":
            for i in 0..(elt[1] - 1):
                pos[1] += 1
                bounds += 1
    sommets.add(pos)

# Shoelace + Pick

var res = 0
for idx in 0..(sommets.len - 2):
    res += ((sommets[idx][0] * sommets[idx + 1][1]) - (sommets[idx][1] * sommets[idx + 1][0]))
echo ((abs(res)/2).toInt + 1) - (bounds / 2).toInt + bounds