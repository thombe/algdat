function floyd_warshall(adjacency_matrix, nodes , f, g)
    n , m = size(adjacency_matrix)
    D = adjacency_matrix
    Pi = adjacency_matrix
    for row = 1:n
        for col = 1:m
            if Pi[row,col] > 0
                Pi[row,col] = row
            end
        end
    end

    for k = 1:n
        for i = 1:n
            for j = 1:n
                if f(D[i,j],g(D[i,k],D[k,j]))
                    D[i,j] = g(D[i,k],D[k,j])
                    Pi[i,j] = Pi[k,j]
                end
            end
        end
    end

    return D, Pi
end
