import std/sugar
import strutils
import std/sets
import sequtils
import math
import algorithm
import re
import tables



type 
    HandType = enum
        FiveOfAKind, FourOfAKind, FullHouse, ThreeOfAKind, TwoPairs, OnePair, HighCard

type
    Hand = object of RootObj
        value* : string
        bid : int

proc translateCard(c : char) : int =
    ## Translates A K Q J and T and numbers to ints
    case c
        of 'A' : return 14
        of 'K' : return 13
        of 'Q' : return 12
        of 'J' : return 11
        of 'T' : return 10
        else: return parseInt($c)

proc cmpHands(a, b : Hand) : int =
    for idx, elt in a.value:
        if translateCard(elt) < translateCard(b.value[idx]):
            return 1
        elif translateCard(elt) > translateCard(b.value[idx]):
            return -1
    return 0

proc newHand(value : string, bid : int) : Hand =
    Hand(value : value, bid : bid)

proc getHandType(s : string) : HandType =
    ## Returns the type of the hand
    # All the same, 4 different and all different
    case s.toHashSet.len
        of 1: return FiveOfAKind
        of 2:
            if max(s.items.toSeq.map(x => count(s, x))) == 4:
                return FourOfAKind
            else:
                return FullHouse
        of 3:
            if max(s.items.toSeq.map(x => count(s, x))) == 3:
                return ThreeOfAKind 
            else:
                return TwoPairs
        of 4: return OnePair
        of 5: return HighCard
        else: discard

let infos = collect(newSeq):
    for l in lines("inputs"):
        [l.split(" ")[0], l.split(" ")[1]]  

# Init the table
var hands = initTable[HandType, seq[Hand]]()
for e in HandType.items:
    hands[e] = newSeq[Hand]()

# Craft the table
for elt in infos:
    hands[elt[0].getHandType()].add(newHand(elt[0], elt[1].parseInt))

var all_hands : seq[Hand]
# Sort each hand Type, adn add them to the full arr
for t in HandType.items:
    hands[t].sort(cmpHands)
    all_hands.add(hands[t])

var res = 0
for idx, elt in all_hands.reversed:
    res += (idx + 1) * elt.bid
echo res

