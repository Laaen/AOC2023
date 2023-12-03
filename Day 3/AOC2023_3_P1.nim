import std/nre
import std/strutils
import std/sugar
import sequtils
import std/math

type
    Information* = object of RootObj
        value : string
        line : int
        start : int
        fin : int
        isSymbol : bool

proc createInformation(value : string, line, start, fin : int, isSymbol : bool) : Information =
    ## Creates an Information object
    Information(value : value, line: line, start : start, fin : fin, isSymbol : isSymbol)

proc checkAround(info : Information, around : openArray[Information]) : int =
    let coord = info.start - 1 .. info.fin + 1
    for elt in around:
        if elt.isSymbol and elt.start in coord:
            return info.value.parseInt
    return 0

proc processLine(line_nb : int, line_content : string) : seq[Information] =
    for elt in findIter(line_content, re"\d+|[^a-z0-9.\s]"):
        let symb = elt.match.contains(re"[^a-z0-9.\s]")
        result.add(createInformation(elt.match, line_nb, elt.matchBounds.a, elt.matchBounds.b, symb))

var infos_list: seq[Information]
var line = 0
for elt in lines("inputs"):
    infos_list.add(processLine(line, elt))
    line += 1

let res = collect:
        for elt in infos_list:
            if not elt.isSymbol:
                checkAround(elt, infos_list.filter( x => x.line in elt.line - 1 .. elt.line + 1))
echo sum(res)