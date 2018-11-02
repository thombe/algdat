#=ob.value & ob.next
mutable struct Record
    next::Union{Record,Nothing}
    value::Int
end
function createlinkedlist(length, valuerange)
    next = nothing
    record = nothing
    for i in i:length
        record = Record(next, rand(valuerange))
        next = record
    end
    return record
end
=#


function traversemax(record)
    maxval = -99999999999999
    while record.next != nothing
        if record.value > maxval
            maxval = record.value
        end
        record = record.next
    end
    return maxval
end
