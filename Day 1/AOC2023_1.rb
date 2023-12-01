TABLE = {"one" => "1", "two" => "2", "three" => "3", "four" => "4", "five" => "5", "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9"}

def translate(s)
    TABLE[s] or s
end

def getDigits(s)
    res = s.scan(/(?=(one|two|three|four|five|six|seven|eight|nine|\d))/).flatten
    return translate(res[0]) + translate(res[-1])
end

puts File.open("inputs").map{|l| getDigits(l).to_i}.sum