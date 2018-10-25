using DataStructures: PriorityQueue, enqueue!, dequeue!

mutable struct Node
    ip::Int
    neighbours::Array{Tuple{Node,Int}}
    risk::Union{Float64, Nothing}
    predecessor::Union{Node, Nothing}
    probability::Float64
end
Node(ip) = Node(ip, [], nothing, nothing, 0)

function initialize_single_source!(graph, start)
    for node in graph
        node.risk = typemax(Float64)
        node.predecessor = nothing #Migth be unneccecary because of contructor
    end
    #kan også prøve å lage kopier basert på ip og bruke konstruktør
    start.risk = 0.0
end

function relax!(from_node,to_node,cost)
    w = from_node.risk + cost/to_node.probability
    if to_node.risk > w
        to_node.risk = w
        to_node.predecessor = from_node
    end
end

function dijkstra!(graph,start)
    initialize_single_source!(graph, start)
    Q = PriorityQueue{Node, Float64}()
    visited = Set()
    enqueue!(Q , start , 0.0)
    while !isempty(Q)
        from_node = dequeue!(Q)
        push!(visited,from_node)

        for (to_node,cost) in from_node.neighbours
            relax!(from_node, to_node,cost)
            if !in(to_node, visited)
                if !haskey(Q,to_node)
                    enqueue!(Q,to_node,to_node.risk)
                end
                if to_node.risk < Q[to_node]
                    Q[to_node] = to_node.risk
                end
            end
        end
    end
end

n1 = Node(1)
n2 = Node(2)
n3 = Node(3)
n4 = Node(4)
n5 = Node(5)


n1.probability = 0.75
n2.probability = 0.75
n3.probability = 1.0
n4.probability = 0.5
n5.probability = 1.0

n1.neighbours = []
n2.neighbours = [(n4,6)]
n3.neighbours = [(n1,6),(n4,7)]
n4.neighbours = [(n5,8)]
n5.neighbours = [(n2,9),(n3,8)]

grph = [n1 , n2 , n3 , n4 , n5]

dijkstra!(grph,n5)

function bellman_ford!(graph,start)
    initialize_single_source!(graph,start)
    for g = 1:length(graph)-1
        for u in graph

            for (v,w) in u.neighbours
                relax!(u,v,w)
            end

        end
    end
    for u in graph
        for (v,w) in u.neighbours
            if v.risk > (u.risk + (w/v.probability))
                return false
            end
        end
    end
    return true
end

n1.probability = 1.0
n2.probability = 1.0
n3.probability = 1.0
n4.probability = 1.0

n1.neighbours = [(n3,3)]
n2.neighbours = []
n3.neighbours = [(n4,4)]
n4.neighbours = [(n1,4)]

grph = [n1 , n2 , n3 , n4]
bellman_ford!(grph,n4)
