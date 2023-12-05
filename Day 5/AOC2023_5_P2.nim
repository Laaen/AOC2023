import std/sugar
import strutils
import sequtils
import re
import strformat
import algorithm
import math

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

proc to_i(a : string) : seq[int] =
    a.split(" ").filter(x => x != "").map(x => x.parseInt())

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

var res = 551761867
var seed = 0
for elt in getSeeds(lines[0].split(":")[^1]):
    var trad = elt
    for mp in map:
        trad = transform(trad, mp)
    if trad < res:
        res = trad
        seed = elt

echo seed
echo res