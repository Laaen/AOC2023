import sugar
import strutils
import sequtils
import sets
import strformat
import algorithm

proc processLine(a: seq[int], i : int) : int =
    var res: seq[int]
    # Process the line
    for i in 0..(a.len - 2):
        res.add(a[i + 1] - a[i])
    if res.toHashSet.len != 1:
        let delta = processLine(res, i + 1)
        return a[^1] + delta
    else:
        return res[^1] + a[^1] 

let infos = collect:
    for l in lines("inputs"):
        l.split(" ").map(x => x.parseInt)

var res = 0
for line in infos:
    var current_line = line
    res += processLine(current_line, 0)

echo res