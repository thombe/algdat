using Pkg
Pkg.add("DataStructures")
using DataStructures: Queue, enqueue!, dequeue!

mutable struct Node
    id::Int
    neighbours::Array{Node}
    color::Union{String, Nothing}
    distance::Union{Int, Nothing}
    predecessor::Union{Node, Nothing}
end

Node(id) = Node(id, [], nothing, nothing, nothing)


function printnodelist(nodelist)
println("Skriver ut nodeliste med printnodelist")
for node in nodelist
    neighbourlist = [neighbours.id for neighbours in node.neighbours]
    println("id: $(node.id), neighbours: $neighbourlist")
end

function makenodelist(adjacencylist)
    nodeList = [Node(i) for i=1:length(adjacencylist)]
    for i=1:length(nodeList)
        for j=1:length(adjacencylist[i])
            push!(nodeList[i].neighbours, nodeList[adjacencylist[i][j]])
        end
    end
    return nodeList
end

# printnodelist(makenodelist([[2,3],[3],[4],[]]));

function bfs!(nodes, start)
    if isgoalnode(start)
        return start
    end
    for node in nodes
        node.color = "white"
        node.distance = typemax(typeof(1))
        node.predecessor = nothing
    end
    start.color = "gray"
    start.distance = 0
    start.predecessor = nothing
    Q = Queue{Node}()
    enqueue!(Q, start)
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

function makepathto(goalnode)
    path = [goalnode.id]
    while goalnode.predecessor != nothing
        pushfirst!(path, goalnode.predecessor.id)
        goalnode = goalnode.predecessor
    end
    return path
end
