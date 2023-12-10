import sugar
import sequtils
import tables
import sets

const pipeTypes = {'|' : ['s', 'n'],
'7' : ['s', 'w'],
'F' : ['s', 'e'],
'-' : ['w', 'e'],
'J' : ['w', 'n'],
'L' : ['e', 'n'],
'.' : ['l', 'a']}.toTable()

type
    Point = object of RootObj
        x: int
        y: int
        dir: string

proc up(p: Point): Point =
    Point(x : p.x-1, y: p.y, dir: "s")

proc down(p: Point): Point =
    Point(x : p.x+1, y: p.y, dir: "n")

proc left(p: Point): Point =
    Point(x : p.x, y: p.y-1, dir: "e")

proc right(p: Point): Point =
    Point(x : p.x, y: p.y+1, dir: "w")

proc `==`(p1, p2 : Point) : bool =
    return (p1.x == p2.x) and (p1.y == p2.y)

proc `!=`(p1, p2 : Point) : bool =
    return not (p1 == p2)

proc get(a: seq[seq[char]], p : Point): char =
    ## Returns the value at p
    return a[p.x][p.y]

proc lookAround(m: seq[seq[char]], p: Point): Point =
    # Returns the next point
    if p.x >= 1 and 's' in pipeTypes[m.get(p.up())]:
        p.up()
    elif p.y >= 1 and 'e' in pipeTypes[m.get(p.left())]:
        p.left()
    elif p.y < m[0].len and 'w' in pipeTypes[m.get(p.right())]:
        p.right()
    else:
        p.down()

proc followDir(m: seq[seq[char]], p: Point): Point =
    ## Returns the point following the direction
    # Symbol of the current point
    let symbol = m.get(p)
    var difference = (pipeTypes[symbol].toHashSet() - p.dir.toHashSet())
    case difference.pop()
        of 'w': return p.left()
        of 's': return p.down()
        of 'e': return p.right()
        of 'n': return p.up()
        else: discard

let matrix = collect:
    for line in lines("inputs"):
        line.toSeq

# Get the starting point
var start : Point
var i = 0
for l in matrix:
    if l.find('S') != -1:
        start = Point(x: i, y: l.find('S'))
    i += 1

var next : Point
i = 1
# Startup
next = matrix.lookAround(start)
# Loop through the pipes
while next != start:
    next = matrix.followDir(next)
    echo matrix.get(next)
    i += 1
echo (i/2).toInt