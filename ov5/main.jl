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

function build(list_of_words::Array{Tuple{String,Int}})::Node
end

new_node = Node()
