import sugar
import tables
import strutils
import sequtils
import strformat

import times, os, strutils

template benchmark(benchmarkName: string, code: untyped) =
  block:
    let t0 = epochTime()
    code
    let elapsed = epochTime() - t0
    let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 3)
    echo "CPU Time [", benchmarkName, "] ", elapsedStr, "s"

let lines = collect:
    for elt in lines("inputs"):
        if elt != "":
            elt

let order = lines[0]

var mapInfos : Table[string, seq[string]]
for elt in lines[1..^1]:
    let sep = elt.split(" = ")
    mapInfos[sep[0].strip()] = sep[1].strip(chars = {'(', ')'}).split(",").map(x => x.strip())

# Number of steps for each start until they reach their end
var nb_steps : seq[seq[int]]
var current_nodes = mapInfos.keys.toSeq.filter(x => x.endsWith("A"))

echo current_nodes

benchmark("Time"):
    for node in current_nodes:
        var found = false
        var counter = 0
        var nb_loops = 0
        var curr_n = node
        while found == false:
            nb_loops += 1
            for elt in order:
                counter += 1
                if elt == 'R':
                    curr_n = mapInfos[curr_n][1]
                else:
                    curr_n = mapInfos[curr_n][0]
                # If all nodes end with Z
                if curr_n.endsWith("Z"):
                    echo &"Found for {node}"
                    found = true
                #echo current_nodes[idx]
        nb_steps.add(@[counter, nb_loops])

    var res = 1
    for elt in nb_steps:
        res *= elt[1]
    echo res * order.len