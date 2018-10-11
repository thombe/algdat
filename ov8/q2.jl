function bfs!(nodes , start)

    for node in nodes# = 2:length(nodes)
        node.color = "white"
        node.distance = typemax(Int64)
        node.predecessor = Nothing
    end

    start.color = "gray"
    start.d = 0
    start.predecessor = Nothing

    Q = Queue{Node}()
    while Q
        u = dequeue!(Q)
        for v in u.neighbours
            if isgoalnode(v)
                return true
            end
            if v.color == "white"
                v.color = "gray"
                v.distance = u.distance + 1
                v.predecessor = u
                enqueue!(Q, v)
            end
        end
        u.color = "black"
    end
    return false
end
