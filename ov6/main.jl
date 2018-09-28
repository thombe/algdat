function cumulative(weigths)
    path_weigths = deepcopy(weigths)

    rows, cols = size(weigths)

    for i = 2:rows
        for j = 1:cols
            if j == 1
                path_weigths[i,j] = min(weigths[i-1,j] , weigths[i-1,j+1])
            elseif j == cols
                path_weigths[i,j] = min(weigths[i-1,j] , weigths[i-1,j-1])
            else
                path_weigths[i,j] = min(weigths[i-1,j-1] , weigths[i-1,j] , weigths[i-1,j+1])
            end
        end
    end
    return path_weigths
end

function print_matrix(matrix)
    rows , cols = size(matrix)
    for i = 1:rows
        

weights = [3  6  8 6 3;
           7  6  5 7 3;
           4  10 4 1 6;
           10 4  3 1 2;
           6  1  7 3 9]

println(weights)
println(cumulative(weights))
