import sugar
import tables
import strutils
import sequtils

let lines = collect:
    for elt in lines("inputs"):
        if elt != "":
            elt

let order = lines[0]

var mapInfos : Table[string, seq[string]]
for elt in lines[1..^1]:
    let sep = elt.split(" = ")
    mapInfos[sep[0].strip()] = sep[1].strip(chars = {'(', ')'}).split(",").map(x => x.strip())

var current : string = "AAA"
var counter = 0
var found = false
while found == false:
    for elt in order:
        counter += 1
        if elt == 'R':
            current = mapInfos[current][1]
        else:
            current = mapInfos[current][0]
        if current == "ZZZ":
            found = true

echo counter