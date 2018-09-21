struct Node
    children::Dict{Char,Node}
    posi::Array{Int}
end
Node() = Node(Dict(),[])

function parse_string(sentence::String)::Array{Tuple{String,Int}}
    A = []
    s = 1
    for i = 1:length(sentence)
        if Int(sentence[i]) == 32
            e = i
            push!(A , (sentence[s:(e-1)],s))
            s = i + 1
        end
        if i == length(sentence)
            push!(A , (sentence[s:end],s))
        end
    end
    return A
end
#=
function left(i)
    return 2*i
end

function rigth(i)
    return 2*i + 1
end

function max_heapify(heap , i)
    l = left(i)
    r = rigth(i)
    if l <= length(heap) && heap[l] > heap[i]
        m = l
    else
        m = i
    end

    if r < length(heap) && heap[r] > heap[m]
        m = r
    end

    if m != i
        temp = deepcopy(heap[i])
        heap[i] = heap[m]
        heap[m] = temp

        max_heapify(heap , m)
    end


end

=#
function build(list_of_words::Array{Tuple{String,Int}})::Node

    for word in list_of_words
        for char in word[1]
            println(char)
        end
    end


    new_node = Node()
    return new_node
end

new_node = Node()

A = parse_string("algdat er et hardt fag")
build(A)
