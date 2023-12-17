import sugar
import sequtils
import algorithm
import matrices
import strformat

proc nbDiff(a, b : seq[char]) : int =
    for i in 0..(a.len - 1):
        if a[i] != b[i]:
            result += 1

proc checkSymm(m: seq[seq[char]], a, b : int, nb_diff : int) : bool = 
    var trials = 1 - nb_diff 
    for l in 0..(a):
        try:
            if m[a - l] != m[b + l]:
                trials -= nbDiff(m[a - l], m[b + l])
                if trials < 0:
                    return false
        except:
            if trials != 0:
                return false
            return true
        
    if trials != 0:
        return false

    return true

proc findSymmetry(m: seq[seq[char]]) : int=
    ## Returns the indexes of the symmery plan
    var delta = 0
    var tmp = 0
    var symm: seq[seq[char]]
    for elt in 0..(m.len-2):
        let diff = nbDiff(m[elt], m[elt+1])
        # Test the two adjacent lines, see if they have one difference
        if diff == 0:
            if checkSymm(m, elt, elt + 1, 0):
                # We have two identical adjacent lines
                # Test if we have at minimum 2 other lines
                return elt + 1
        elif diff == 1:
            var tmp = m
            tmp[elt + 1] = tmp[elt]
            if checkSymm(tmp, elt, elt + 1, 1):
                return elt + 1

var total = 0
var current_grid : seq[seq[char]]
for line in lines("inputs"):
    if line != "":
        current_grid.add(line.toSeq)
    else:
        let m = newMatrix(current_grid)
        let hz =  findSymmetry(m.lines) * 100
        if hz == 0:
            total += findSymmetry(m.columns)
        else:
            total += hz
        current_grid = @[]

echo total