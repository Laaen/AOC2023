import sugar

type
    Matrix*[T] = object of RootObj
        content : seq[seq[T]]
    
proc newMatrix*[T](c : seq[seq[T]]) : Matrix[T] =
    Matrix[T](content: c)

proc content*[T] (m : Matrix[T]) : seq[seq[T]] =
    m.content

proc lines*[T](m : Matrix[T]) : seq[seq[T]] =
    ## Returns the lines of the matrix
    m.content

proc columns*[T](m : Matrix[T]) : seq[seq[T]] =
    ## Returns the columns of the matrix
    let columns = collect:
        for col in 0..(m.content[0].len - 1):
            var tmp: seq[T]
            for line in 0..(m.lines.len - 1):
                tmp.add(m.content[line][col])
            tmp
    return columns