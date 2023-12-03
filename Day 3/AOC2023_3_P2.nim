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
    var found : seq[Information]
    for elt in around:
        let coord = elt.start - 1 .. elt.fin + 1
        if not elt.isSymbol and info.start in coord:
            found.add(elt)
    if found.len == 2:
        return found[0].value.parseInt * found[1].value.parseInt
    else:
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
            if elt.isSymbol and elt.value == "*":
                checkAround(elt, infos_list.filter( x => x.line in elt.line - 1 .. elt.line + 1))
echo sum(res)