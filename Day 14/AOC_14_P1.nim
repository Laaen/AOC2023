import sugar
import sequtils
import math
import strformat
import algorithm
import strutils

proc goNorth(m : var seq[seq[char]]) =
    for elt in m:
        for i in countdown(m.len - 2, 1):
            for j in countdown(m[i].len - 2, 1):
                if m[i][j] == 'O':
                    if m[i - 1][j] == '.':
                        m[i - 1][j] = 'O'
                        m[i][j] = '.'

proc goEast(m : var seq[seq[char]]) =
    for elt in m:
        for i in countdown(m.len - 2, 1):
            for j in countdown(m[i].len - 2, 1):
                if m[i][j] == 'O':
                    if m[i][j + 1] == '.':
                        m[i][j + 1] = 'O'
                        m[i][j] = '.'

proc goWest(m : var seq[seq[char]]) =
    for elt in m:
        for i in countdown(m.len - 2, 1):
            for j in countdown(m[i].len - 2, 1):
                if m[i][j] == 'O':
                    if m[i][j - 1] == '.':
                        m[i][j - 1] = 'O'
                        m[i][j] = '.'

proc goSouth(m : var seq[seq[char]]) =
    for elt in m:
        for i in 1..m.len - 2:
            for j in countdown(m[i].len - 2, 1):
                if m[i][j] == 'O':
                    if m[i + 1][j] == '.':
                        m[i + 1][j] = 'O'
                        m[i][j] = '.'

var m : seq[seq[char]]
for line in lines("inputs"):
    m.add(line.toSeq)

let fct_arr = [goNorth, goWest, goSouth, goEast]

goWest(m)

var res = 0
for idx in 0..(m.len - 1):
    res += m[idx].filter(x => x == 'O').map(x => 1).sum * (m.len - idx)
echo res

for elt in m:
    echo elt.join