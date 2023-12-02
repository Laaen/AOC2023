import std/tables
import std/strutils
import std/sugar
import std/math
import std/sequtils

proc processLine(line: string) : int = 
    var tmp = {"red": 0, "green": 0, "blue": 0}.toTable
    let infos = line.split(seps = {':', ',', ';'})[1 .. ^1]
    for elt in infos:
        let (v, k) = (elt.strip().split(" ")[0], elt.strip().split(" ")[1])
        if tmp[k] < parseInt(v):
            tmp[k] = parseInt(v)
    let val = collect:
        for elt in tmp.values:
            elt
    return foldl(val, a * b)

let res = collect:
    for elt in lines("inputs"):
        processLine(elt)
echo sum(res)