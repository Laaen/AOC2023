import sugar
import sequtils
import algorithm
import matrices
import strformat

proc checkSymm(m: seq[seq[char]], a, b : int) : bool = 
    for l in 0..(a):
        try:
            if m[a - l] != m[b + l]:
                return false
        except:
            return true
    return true

proc findSymmetry(m: seq[seq[char]]) : int=
    ## Returns the indexes of the symmery plan
    var delta = 0
    var tmp = 0
    var symm: seq[seq[char]]
    for elt in 0..(m.len-2):
        if m[elt] == m[elt + 1] :
            if checkSymm(m, elt, elt + 1):
                # We have two identical adjacent lines
                # Test if we have at minimum 2 other lines
                return elt + 1

var total = 0
var current_grid : seq[seq[char]]
for line in lines("inputs"):
    if line != "":
        current_grid.add(line.toSeq)
    else:
        let m = newMatrix(current_grid)
        let vt =  findSymmetry(m.columns)
        if vt == 0:
            echo findSymmetry(m.lines)
            total += findSymmetry(m.lines) * 100
        else:
            echo vt
            total += vt
        current_grid = @[]

echo total