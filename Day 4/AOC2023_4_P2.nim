import std/strutils
import std/math
import std/sets

proc winning(c, w : openArray[int]) : int =
    ## Returns the number of winning n°
    return toHashSet(c).intersection(toHashSet(w)).len

proc strToIntArr(a : string) : seq[int] =
    for elt in a.split(" "):
        if elt != "":
            result.add(elt.parseInt())

iterator processFile(file_name : string): seq[seq[int]] =
    for elt in lines(file_name):
        let infos = elt.split(":")[1].split("|")
        yield @[strToIntArr(infos[0].strip()), strToIntArr(infos[1].strip())]


var cards : array[500, int]
var i = 0
# For each card
for elt in processFile("inputs"):
    # The original ticket
    cards[i] += 1
    for j in 1..winning(elt[0], elt[1]):
        cards[j + i] += cards[i]
    i += 1

echo sum(cards)