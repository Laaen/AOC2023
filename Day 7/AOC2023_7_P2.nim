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
        of 'J' : return 1
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
    let nb_j = s.count('J')
    var max_card = 0
    try:
        max_card = max(s.replace("J", "").items.toSeq.map(x => count(s, x))) + nb_j
    except:
        return FiveOfAKind

    case max_card
        of 5: return FiveOfAKind
        of 4: return FourOfAKind
        of 3:
            if s.replace("J", "").toHashSet.len == 2:
                return FullHouse
            else:
                return ThreeOfAKind
        of 2:
            if s.replace("J", "").toHashSet.len == 3:
                return TwoPairs
            else:
                return OnePair
        of 1: return HighCard
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

