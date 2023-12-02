def extractVal(set)
    set.split(",").map do |x|
        [x.split(" ")[1], x.split(" ")[0].to_i]
    end.to_h
end

def processLine(line)
    tmp = { "red" => 0, "green" => 0, "blue" => 0}
    # Process each set in a game
    line.split(":")[-1].split(";").each do |x| 
        extractVal(x).each_pair do |k, v|
            if tmp[k] < v
                tmp[k] = v
            end
        end
    end
    return tmp.values.reduce(:*)
end

puts File.open("inputs").each.map {|x| processLine(x).to_i}.sum