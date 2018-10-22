#using Pkg
#Pkg.add("DataStructures")
using DataStructures: Queue, enqueue!, dequeue!
mutable struct Node
    id::Int
    neighbours::Array{Node}
    color::Union{String, Nothing}
    distance::Union{Int, Nothing}
    predecessor::Union{Node, Nothing}
end
Node(id) = Node(id, [], nothing, nothing, nothing)

function isgoalnode(v)
    if v.distance % 2 == 1
        return true
    else
        return false
    end
end

function bfs!(nodes , start)
    if isgoalnode(start)
        return start
    end
    for node in nodes
        node.color = "white"
        node.distance = typemax(Int64)
        node.predecessor = nothing
    end

    start.color = "gray"
    start.distance = 0
    start.predecessor = nothing

    Q = Queue{Node}()
    enqueue!(Q,start)

    while !isempty(Q)
        u = dequeue!(Q)
        for v in u.neighbours
            if v.color == "white"
                v.color = "gray"
                v.distance = u.distance + 1
                v.predecessor = u
                enqueue!(Q, v)
                if isgoalnode(v)
                    return v
                end
            end
        end
        u.color = "black"
    end
    return nothing
end

Node(id) = Node(id, [], nothing, nothing, nothing)

n1 = Node(1 , [] , "white" , 0, nothing)
n2 = Node(2 , [] , "white" , 0, n1)
n3 = Node(3 , [] , "white" , 0, n2)
n4 = Node(4 , [] , "white" , 0, n2)
n5 = Node(5 , [] , "white" , 0, n3)

n1.neighbours = [n2]
n2.neighbours = [n3,n4]



#println(bfs!([n1,n2,n3,n4] , n1).id)
#=
function getpi(R , node)
    push!(R , node.predecessor.id)
    if node.predecessor.predecessor != nothing
        #push!(R , node.predecessor.id)
        return getpi(R, node.predecessor)
    end
    return node.predecessor
end
=#


function makepathto(goalnode)
    R = [goalnode.id]
    while goalnode.predecessor != nothing
        pushfirst!(R , goalnode.predecessor.id)
        goalnode = goalnode.predecessor
    end
    return R
end

T = makepathto(n5)
for e in T
    println("bla $(e)")
end
