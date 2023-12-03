class Information
    attr_accessor :line, :start, :end_c, :is_symbol, :value
    # Represents the infos of a number or a symbol (its value, and coordinates)
    def initialize(val, line, start, e, symb)
        @value = val
        @line = line
        @start = start
        @end_c = e
        @is_symbol = symb
    end
    def to_s()
        return "Value : #{@value}, line : #{@line}, begin : #{@start}, end : #{@end_c}, symbol? : #{@is_symbol}"
    end
end

def checkAround(list, info)
    # Checks the coordinates around (square) if there is a symbol not "."
    # We keep the previous, the current and the next lines
    # The coordinates (One more)
    coord = (info.start - 1 .. info.end_c + 1)
    list.each do |elt|
        if elt.is_symbol and coord.member?(elt.start) and not info.is_symbol
            puts info
            return info.value.to_i
        end
    end
    return 0
end

def processLine(line_nb, line_content)
    # We change the "*" and "$" makes the regex manipulation harder

    # Creates Information for each relevant item in the line
    arr_info = []
    line_content.scan(/\d+|[^a-z0-9.\s]/).each do |x|
        infos = line_content.match(Regexp.escape(x))
        arr_info << Information.new(x, line_nb, infos.begin(0), infos.end(0) - 1, x.match?(/[^a-z0-9.\s]/))
        line_content.sub!(x, "."*x.size)
    end
    return arr_info
end

infos = []
File.open("inputs").each_with_index do |x, i|
    infos += (processLine(i, x))
end 

i = 0
infos.each do |elt|
    if not elt.is_symbol
        i += checkAround(infos.select{|x| (elt.line - 1 .. elt.line + 1).member?(x.line)}, elt)
    end
end

puts i