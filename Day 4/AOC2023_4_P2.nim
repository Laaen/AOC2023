import std/strutils
import std/sugar

# Slow code

type
    Card = object of RootObj
        nb : int
        content : seq[int]
        winning : seq[int]

proc newCard(c : seq[int], w : seq[int]) : Card =
    Card(nb: 1, content: c, winning : w)

proc winning(c :Card) : int =
    ## Returns the number of winning n°
    for elt in c.content:
        if elt in c.winning:
            result += 1

proc strToIntArr(a : string) : seq[int] =
    for elt in a.split(" "):
        if elt != "":
            result.add(elt.parseInt())

iterator processFile(file_name : string): seq[seq[int]] =
    for elt in lines(file_name):
        let infos = elt.split(":")[1].split("|")
        yield @[strToIntArr(infos[0].strip()), strToIntArr(infos[1].strip())]

# Fill the cards list
var cards_list = collect:
    for elt in processFile("inputs"):
        newCard(elt[1], elt[0])

var total = 0
# We iterate through each card X times (nb of card we have)
for idx, card in cards_list:
    for i in 0..card.nb - 1:
        for w in 1..card.winning():
            cards_list[idx + w].nb += 1
    total += card.nb

echo total