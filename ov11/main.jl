function floyd_warshall(adjacency_matrix, nodes , f, g)
    n , m = size(adjacency_matrix)
    D = adjacency_matrix

    for k = 1:n
        for i = 1:n
            for j = 1:n
                D[i,j] = f(D[i,j],g(D[i,k],D[k,j]))
            end
        end
    end
    return D
end

function transitive_closure(adjacency_matrix, nodes)
    R = floyd_warshall(adjacency_matrix, nodes , min , +)
    println(R)
    m, n = size(adjacency_matrix)
    for i = 1:m
        for j = 1:n
            if R[i,j] > 999999
                R[i,j] = 0
            else
                R[i,j] = 1
            end

        end
    end

    return R
end

function create_preference_matrix(ballots, voters, candidates)
    P = zeros(candidates,candidates)
    for i = 1:voters
        for j = 1:candidates
            c = ballots[i][j]
            for char in ballots[j+1:end]
                P[c-'A'+1,char-'A'+1] += 1
            end
        end
    end
    return P
end

function find_strongest_paths(preference_matrix, candidates)
     m , n = size(preference_matrix)
     P = preference_matrix
     for i = 1:m
         for j = 1:n
             if P[i,j] < P[j,i]
                 P[i,j] = 0
             else
                 P[j,i] = 0
             end
         end
     end
     P = floyd_warshall(P , candidates , max , +)
     return P
 end

 println(find_strongest_paths([0 11 20 14; 19 0 9 12; 10 21 0 17; 16 18 13 0], 4))
