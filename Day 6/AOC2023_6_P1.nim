
import std/tables
import strutils
import sequtils
import sugar
import re

proc getNbTimes(time : int, dist : int) : int =
    ## Calculate and returns the number of holding times OK
    for x in 0..time:
        if x * (time - x) > dist:
            result += 1

var mapDT = initTable[int, int]()

let content = readLines("inputs", 2)

let times = content[0].split(":")[^1].strip().split("     ").map(x => x.strip.parseInt)
let dist = content[1].split(":")[^1].strip().split("   ").map(x => x.strip.parseInt)

for idx, elt in times:
    mapDT[elt] = dist[idx]

var res = 1
for time, dist in mapDT.pairs:
    res *= getNbTimes(time, dist)

echo res