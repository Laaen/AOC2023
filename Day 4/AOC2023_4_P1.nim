import std/strutils

proc strToIntArr(a : string) : seq[int] =
    for elt in a.split(" "):
        if elt != "":
            result.add(elt.parseInt())

iterator processFile(file_name : string): seq[seq[int]] =
    for elt in lines(file_name):
        let infos = elt.split(":")[1].split("|")
        yield @[strToIntArr(infos[0].strip()), strToIntArr(infos[1].strip())]

var total = 0
for elt in processFile("inputs"):
    let (winning, current) = (elt[0], elt[1])
    var score = 0
    for elt in current:
        if elt in winning:
            if score == 0:
                score += 1
            else:
                score *= 2
    total += score

echo total