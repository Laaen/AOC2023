import sugar
import sequtils
import algorithm
import math
import strformat

const EXPANSION_OFFSET = 999999

type
    Point = object of RootObj
        line: int
        col : int

proc distance (a, b : Point) : int =
    ## Returns the distance between these two points
    let delta_x = abs(a.line - b.line)
    let delta_y = abs(a.col - b.col)
    return delta_x + delta_y

var matrix = collect:
    for line in lines("inputs"):
        line.toSeq

var expanded_rows : seq[int]
# Lines expansion
for line in 0..(matrix.len - 1):
    if matrix[line].all(e => e == '.'):
        expanded_rows.add(line)

# Columns expansions
var expanded_col : seq[int]
for col in 0..(matrix[0].len - 1):
    var empty = true
    for line in 0..(matrix.len - 1):
        if matrix[line][col] != '.':
            empty = false
            break
    if empty == true:
        expanded_col.add(col)

# Get shortest distance

# First we get every galaxy coord
var galaxies_coordinates : seq[Point]
for line in 0..(matrix.len - 1):
    for col in 0..(matrix[0].len - 1):
        if matrix[line][col] != '.':
            let nb_row = sum(expanded_rows.filter(x => x < line).map(x => 1))
            let nb_col = sum(expanded_col.filter(x => x < col).map(x => 1))
            galaxies_coordinates.add(Point(line: (line + nb_row * EXPANSION_OFFSET), col: (col + nb_col * EXPANSION_OFFSET)))

# Create the pairs
var gal_pairs: seq[array[2, Point]]

for idx in 0..(galaxies_coordinates.len - 1):
    for j in (idx+1)..(galaxies_coordinates.len - 1):
        gal_pairs.add([galaxies_coordinates[idx], galaxies_coordinates[j]])

# Find the lowest distance for each pair
echo sum(gal_pairs.map(x => distance(x[0], x[1])))
    


