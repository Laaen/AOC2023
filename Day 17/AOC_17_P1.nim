import sugar
import sequtils
import strutils

proc getMin(m : (seq[seq[int]]), p: (int, int, float)) : (int, int, float) =
    ## Returns the lowest adjacent node
    # Check around
    var res = 10
    if m[p[0]][p[1]] < result:
        res = m[p[0]][p[1]]
    

var matrix : seq[seq[int]]
for line in lines("inputs"):
    matrix.add(line.toSeq.map(x => parseInt($x)))

# All vertices distances are infinite
var list_vertices = collect:
    for i in 0..(matrix.len - 1):
        for j in 0..(matrix[0].len - 1):
            (i, j, Inf)

# Except the first one
list_vertices[0][2] = 0

var shortestPathTree : seq[(int, int)]

for elt in list_vertices:
    echo elt