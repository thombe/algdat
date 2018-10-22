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

function union!(x::DisjointSetNode, y::DisjointSetNode)
    link(findset(x), findset(y))
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
    for edge in E
        for n in nodes
            if edge[2] != n.u
                node = DisjointSetNode()
                node.p = node
                node.rank = 0
                push!(node, nodes)
            end
        end
    end
    sort!(E)
    for i = 1:length(E)
        u = E[i][2]
        v = E[i][3]
        if findset(nodes[u]) != findset(nodes[v])
            push!((u,v), R)
            union(nodes[u], nodes[v])
            if length(R) == k
                return R
            end
        end
    end
    return R
end
