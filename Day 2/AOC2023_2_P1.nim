import std/tables
import std/strutils
import std/sugar
import std/math

const max = {"red": 12, "green": 13, "blue": 14}.toTable

proc processLine(line: string) : int = 
    var ok = true
    let id = line.split(" ")[1].strip(chars = {':'})
    let infos = line.split(seps = {':', ',', ';'})[1 .. ^1]
    for elt in infos:
        let (v, k) = (elt.strip().split(" ")[0], elt.strip().split(" ")[1])
        if max[k] < parseInt(v):
            ok = false
    if ok:
        return parseInt(id)
    else:
        return 0

let res = collect:
    for elt in lines("inputs"):
        processLine(elt)
echo sum(res)