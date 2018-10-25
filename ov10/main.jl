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

n1 = Node(1)
n2 = Node(2)
n3 = Node(3)
n4 = Node(4)
grph = [n1 , n2 , n3 , n4]
initialize_single_source!(grph, n1)
