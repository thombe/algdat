mutable struct Node
    id::Int
    neighbours::Array{Node}
    color::Union{String, Nothing}
    distance::Union{Int, Nothing}
    predecessor::Union{Node, Nothing}
end
Node(id) = Node(id, [], nothing, nothing, nothing)


function makenodelist(adjacencylist)
    nodes = []
    for i = 1:length(adjacencylist)
        n = Node(i)
        push!(nodes , n)
    end

    for i = 1:length(adjacencylist)
        for id in adjacencylist[i]
            push!(nodes[i].neighbours , nodes[id])
        end

    end
    return nodes
end


function printnodelist(nodelist)
    println("Skriver ut nodeliste med printnodelist")
    for node in nodelist
        neighbourlist = [neighbours.id for neighbours in node.neighbours]
        println("id: $(node.id), neighbours: $neighbourlist")
    end
end


function main(;n=5, degree=3)
    println("Kjører makenodelist")
    adjacencylist = generateadjacencylist(n, degree)
    @info "adjacencylist" adjacencylist
    nodelist = makenodelist(adjacencylist)
    printnodelist(nodelist)
end


generateadjacencylist(n, degree) = [rand(1:n, degree) for id = 1:n]


# Det kan være nyttig å kjøre mange tester for å se om programmet man har laget
# krasjer for ulike instanser
function runmanytests(;maxlistsize=15)
    # Kjører n tester for hver listestørrelse – én for hver grad
    for n = 1:maxlistsize
        for degree = 1:n
            adjacencylist = generateadjacencylist(n, degree)
            #@info "Listelendge $n" n, degree #, adjacencylist
            makenodelist(adjacencylist)
        end
    end
end


main()
runmanytests()
