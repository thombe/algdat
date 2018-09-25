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

function place_words(node::Node , word::Tuple{String,Int})
    for i = 1:length(word[1])
        char = word[1][i]
        if haskey(node.children , char)
            node = node.children[char]
        else
            node.children[char] = Node()
            node = node.children[char]
        end

        if i == length(word[1])
            push!(node.posi , word[2])

        end

    end

end


function build(list_of_words::Array{Tuple{String,Int}})::Node
    top_node = Node()
    for word in list_of_words
        place_words(top_node , word)
    end
    return top_node
end

new_node = Node()

A = parse_string("ha ha mons har en hund med moms hun er en hunn")
B = build(A)

function print_tree(node::Node, tabs::Int)
    for children in keys(node.children)
        for i = 1:tabs
            print('\t')
        end
        print( children )
        for char in children
            print_tree(node.children[char], tabs)
            tabs += 1
            println()
        end
    end

end


function positio(word, node , A , index=1)
    if length(word) == index
        println("length eq index")
    end



    for num in node.posi
        if length(word) == index
            println("returning")
            push!(A, num)
            return
        end
    end

    #=
    println("legth: " , length(word))
    println("index: " , index)
    if length(word) == index
        println("length eq index")
        for num in node.posi
            println("num: " , num)
            println(typeof(node.posi))
            push!(A , num)
        end
        return
    end
    =#

    for char in keys(node.children)
        if word[index] == char || word[index] == '?'
            node = node.children[char]
            index += 1
            positio(word , node , A , index)
            break
        end

    end

end

function positions(word, node , index=1)
    A = []
    positio(word , node ,A , index)
    return A
end

C = positions("ha" , B , 1)
for num in C
    println(num)
end
