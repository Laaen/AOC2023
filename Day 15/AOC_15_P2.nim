import sequtils
import sugar
import math
import strutils
import tables

var dict_arr : array[256, OrderedTable[string, int]]

for line in lines("inputs"):
    for elt in line.split(","):
        var res = 0
        let start = elt.split(seps = {'=', '-'})[0]
        for s in start:
            # Calc Hash
            res += ord(s)
            res *= 17
            res = res mod 256
            # if ends with -, suppr
        if elt[^1] == '-':
            dict_arr[res].del(start)
        else:
            dict_arr[res][start] = parseInt($elt[^1])
            # else add

var res = 0
for idx in 0..(dict_arr.len-1):
    var i = 1
    for v in dict_arr[idx].values:
        res += (idx + 1) * i * v
        i += 1
echo res
echo dict_arr