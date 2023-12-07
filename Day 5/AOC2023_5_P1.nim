import std/sugar
import strutils
import sequtils
import re
import strformat

proc to_i(a : string) : seq[int] =
    a.split(" ").filter(x => x != "").map(x => x.parseInt())

let lines = collect:
    for elt in lines("inputs"):
        if elt =~ re"[^\n|]":
            elt

let seeds = lines[0].split(":")[^1].split(" ").filter(x => x != "").map(x => x.parseInt())

var map : seq[seq[seq[int]]]
var tmp : seq[seq[int]]
for elt in lines[2..^1]:
    if elt =~ re"[^a-z]":
        tmp.add(elt.to_i())
    else:
        map.add(tmp)
        tmp = @[]
map.add(tmp)

var res : seq[int]
for elt in seeds:
    var trad = elt
    for mp in map:
        for j in mp:
            if (let offset = trad - j[1]; offset >= 0 and offset < j[2]):
                trad = j[0] + offset
                break
    res.add(trad)

echo res
echo res.min
