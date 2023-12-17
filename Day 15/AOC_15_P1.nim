import sequtils
import sugar
import math
import strutils

var total = 0

for line in lines("inputs"):
    for elt in line.split(","):
        var res = 0
        for s in elt:
            res += s.ord()
            res *= 17
            res = res mod 256
        total += res

echo total