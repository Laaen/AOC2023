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

proc goEast(m : var seq[seq[char]]) =
    for elt in m:
        for i in countdown(m.len - 1, 0):
            for j in 0..(m[i].len - 2):
                if m[i][j] == 'O':
                    if m[i][j + 1] == '.':
                        m[i][j + 1] = 'O'
                        m[i][j] = '.'

proc goWest(m : var seq[seq[char]]) =
    for elt in m:
        for i in countdown(m.len - 1, 0):
            for j in countdown(m[i].len - 1, 1):
                if m[i][j] == 'O':
                    if m[i][j - 1] == '.':
                        m[i][j - 1] = 'O'
                        m[i][j] = '.'

proc goSouth(m : var seq[seq[char]]) =
    for elt in m:
        for i in 0..m.len - 2:
            for j in countdown(m[i].len - 1, 0):
                if m[i][j] == 'O':
                    if m[i + 1][j] == '.':
                        m[i + 1][j] = 'O'
                        m[i][j] = '.'

var m : seq[seq[char]]
for line in lines("inputs"):
    m.add(line.toSeq)

let fct_arr = [goNorth, goWest, goSouth, goEast]

var res = 0
var arr_resp: seq[int]

while true:
    res = 0
    for idx in 0..(fct_arr.len - 1):
        fct_arr[idx](m)

    for idx in 0..(m.len - 1):
        res += m[idx].count('O') * (m.len - idx)

    arr_resp.add(res)
    if count(arr_resp, res) == 3:
        break

# Detect the cycle
# The beginning, not related to the cycle
let first_occurence = find(arr_resp, res)
let start = arr_resp[0..first_occurence]

let remaining = arr_resp[start.len..^1]
let cycle_len = remaining.len

var idx = 1000000000 - start.len
idx = (idx mod cycle_len) - 1
echo remaining[idx]

