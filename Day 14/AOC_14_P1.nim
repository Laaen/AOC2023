import sugar
import sequtils
import math
import strformat
import algorithm
import strutils

proc goNorth(m : var seq[seq[char]]) =
    for elt in m:
        for i in countdown(m.len - 1, 1):
            for j in countdown(m[i].len - 1, 0):
                if m[i][j] == 'O':
                    if m[i - 1][j] == '.':
                        m[i - 1][j] = 'O'
                        m[i][j] = '.'

var m : seq[seq[char]]
for line in lines("inputs"):
    m.add(line.toSeq)

goNorth(m)

var res = 0
for idx in 0..(m.len - 1):
    res += m[idx].filter(x => x == 'O').map(x => 1).sum * (m.len - idx)
echo res
