
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

let content = readLines("inputs", 2)
let time = content[0].split(":")[^1].strip().split("     ").join("").parseInt()
let dis = content[1].split(":")[^1].strip().split("   ").join("").parseInt()

var res = 1
res *= getNbTimes(time, dis)
echo res