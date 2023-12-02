MAX = { "red" => 12, "green" => 13, "blue" => 14}

def extractVal(set)
    set.split(",").map do |x|
        [x.split(" ")[1], x.split(" ")[0].to_i]
    end.to_h
end

def processLine(line)
    id = /Game ([0-9]+)/.match(line).captures[0]
    ok = true
    # Process each set in a game
    line.split(":")[-1].split(";").each do |x| 
        extractVal(x).each_pair do |k, v|
            if MAX[k] < v
                ok = false
            end
        end
    end
    return id if ok
end

puts File.open("inputs").each.map {|x| processLine(x).to_i}.select {|x| x != nil}.sum