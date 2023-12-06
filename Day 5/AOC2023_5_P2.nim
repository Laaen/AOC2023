import std/sugar
import strutils
import sequtils
import re
import strformat
import algorithm
import math
import threadpool

iterator seedRanges(s : string) : Slice[int] =
    ## Yields ranges from input
    var tmp : seq[int]
    for elt in s.split(" ").filter(x => x != ""):
        tmp.add(elt.parseInt())
        if tmp.len == 2:
            yield tmp[0]..sum(tmp)
            tmp = @[]

iterator getSeeds(s : string) : int = 
    ## Yields each two chars as an int seq
    var tmp : seq[int]
    for elt in seedRanges(s):
        for x in elt:
            yield x

proc transform(i : int, map : seq[seq[int]]) : int = 
    ## Returns the transformed seed through the given map
    var trad = i
    for mp in map:
        if (let offset = trad - mp[1]; offset >= 0 and offset <= mp[2]):
            trad = mp[0] + offset
            break
    trad

proc applyFilter(i : int, mp : seq[int]) : int = 
    ## Returns the transformed seed through the given map
    if (let offset = i - mp[1]; offset >= 0 and offset <= mp[2]):
        return mp[0] + offset

proc to_i(a : string) : seq[int] =
    a.split(" ").filter(x => x != "").map(x => x.parseInt())

proc processRange(r : Slice[int], map : seq[seq[seq[int]]]) =
    var res = 551761867
    for s in r:
        var trad = s
        for mp in map:
            trad = transform(s, mp)
        if trad < res:
            res = trad
    echo res

let lines = collect:
    for elt in lines("inputs"):
        if elt =~ re"[^\n|]":
            elt

var map : seq[seq[seq[int]]]
var tmp : seq[seq[int]]
for elt in lines[2..^1]:
    if elt =~ re"[^a-z]":
        tmp.add(elt.to_i())
    else:
        map.add(tmp)
        tmp = @[]
map.add(tmp)


# Create a seq of seq containing the ranges max and min
var rng : seq[int]
for elt in seedRanges(lines[0].split(":")[^1]):
    rng.add(elt.a)
    rng.add(elt.b)

echo rng

var res_range : seq[int]
for elt in rng:
    var trad = elt
    for mp in map:
        for j in mp:
            if (let offset = trad - j[1]; offset >= 0 and offset <= j[2]):
                trad = j[0] + offset
                break
    res_range.add(trad)

let ranges = collect:
    for elt in seedRanges(lines[0].split(":")[^1]):
        elt

var res = 878888888888888888
for elt in ranges[(res_range.find(res_range.min)/2).toInt - 1]:
    var trad = elt
    for mp in map:
        for j in mp:
            if (let offset = trad - j[1]; offset >= 0 and offset <= j[2]):
                trad = j[0] + offset
                break
    if trad < res:
        res = trad

echo res