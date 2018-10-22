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
    nodes = []
    picked = []
    for i = 1:n
        node = DisjointSetNode()
        node.p = node
        node.rank = 0
        push!(nodes,node)
        push!(picked,[])
    end
    sort!(E)
    trees = n
    println("picked is now " ,picked)
    for i = 1:length(E)
        u = E[i][2]
        v = E[i][3]
        if findset(nodes[u]) != findset(nodes[v])
            unionn!(nodes[u], nodes[v])
            #push!(R , [u,v])
            push!(picked[u],v)
            trees -= 1
            if trees == k
                break
            end
        end
    end
    for u in picked
        if !isempty(u)
            push!(R,u)
        end
    end
    return R
end
E = [(5,1,2),(3,1,3), (4,3,4), (1,2,3), (2,4,1), (6,1,5) , (7,2,4)]
println(findclusters(E,5,1))
