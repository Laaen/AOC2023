import std/nre
import std/parseutils
import std/syncio
import std/tables
import std/sugar

const translation_table = {"one" : "1", "two" : "2", "three" : "3", "four" : "4", "five" : "5", "six" : "6", "seven" : "7",
"eight" : "8", "nine" : "9"}.toTable()

proc translate(s : string) : string =
    ## Returns the translation of a number written in full letters
    try:
        result = translation_table[s]
    except:
        result = s

proc getDigits(s : string) : string = 
    ## Returns the first and last digits (translated if writtent in letters)
    try:
        let capt = collect:
            for elt in findIter(s, re"(?=((one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)|[0-9]))"):
                elt.captures[0]
        result = translate(capt[0]) & translate(capt[^1])
    except:
        return ""

var res = 0
for l in lines("inputs"):
    var num : int
    if l.getDigits().parseInt(num) != 0:
        res += num

echo res