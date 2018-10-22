mutable struct DisjointSetNode
    rank::Int
    p::DisjointSetNode
    DisjointSetNode() = (obj = new(0); obj.p = obj;)
end

function findset(x::DisjointSetNode)
    if x != x.p
        x.p = findset(x.p)
    end
    return x.p
end

function link(x::DisjointSetNode, y::DisjointSetNode)
    if x.rank > y.rank
        y.p = x
    else
        x.p = y
        if x.rank == y.rank
            y.rank += 1
        end
    end
end

function unionn!(x::DisjointSetNode, y::DisjointSetNode)
    link(findset(x), findset(y))
end
function findnodes(x::DisjointSetNode)
    R = []
    if x.p != x
        return x.p
    end
    return Nothing
end


function hammingdistance(s1::String, s2::String)
    r = 0
    for i = 1:length(s1)
        if s1[i] != s2[i]
            r += 1
        end
    end
    return r
end

function findclusters(E::Vector{Tuple{Int, Int, Int}}, n::Int, k::Int)
    R = []
    for i = 1:k
        push!(R,[])
    end
    nodes = []
    edges = []

    for i = 1:n
        node = DisjointSetNode()
        node.p = node
        node.rank = 0
        push!(nodes,node)
    end
    sort!(E)
    trees = n

    for i = 1:length(E)
        if trees == k
            break
        end
        u = E[i][2]
        v = E[i][3]
        if findset(nodes[u]) != findset(nodes[v])
            unionn!(nodes[u], nodes[v])
            push!(edges,E[i])
            trees -= 1
        end
    end

    clusters = Dict{DisjointSetNode, Vector{Int}}()
    for i = 1:n
        node = findset(nodes[i])
        group = get!(clusters, node, Vector{Int}())
        push!(group, i)
    end
    return collect(Vector{Int} , values(clusters))
end


E = [(5,1,2),(3,1,3), (4,3,4), (1,2,3), (2,1,4), (6,1,5) , (7,2,4)]
println(findclusters(E,5,2))


function findanimalgroups(animals::Vector{Tuple{String, String}}, k::Int64)
    E = Vector{Tuple{Int, Int, Int}}()
    for i = 1:length(animals)
        for j = 1:i-1
            push!(E,(hammingdistance(animals[i][2],animals[j][2]), i , j,))
        end
    end
    R = findclusters(E,length(animals) , k)
    println(R)
    F = []
    for i = 1:k
        push!(F,[])
    end
    println(F)
    for i = 1:length(R)
        for j = 1:length(R[i])
            push!(F[i],animals[R[i][j]][1])
        end
    end
    return F

end

println(findanimalgroups([("Ugle", "CGGCACGT"), ("Elg", "ATTTGACA"), ("Hjort", "AATAGGCC")] , 2))
