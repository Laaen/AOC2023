import sugar
import sequtils
import algorithm
import matrices

proc findSymmetry(m: seq[seq[char]]) : int=
    ## Returns the indexes of the symmery plan
    var delta = 0
    var tmp = 0
    var symm: seq[seq[char]]
    for elt in 0..(m.len-2):
        if m[elt] == m[elt+1]:
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
        echo findSymmetry(m.lines)
        echo findSymmetry(m.columns)
        
        current_grid = @[]

echo total