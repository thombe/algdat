function cumulative(weigths)
    path_weigths = deepcopy(weigths)

    rows, cols = size(weigths)

    for i = 2:rows
        for j = 1:cols
            if j == 1
                path_weigths[i,j] += min(path_weigths[i-1,j] , path_weigths[i-1,j+1])
            elseif j == cols
                path_weigths[i,j] += min(path_weigths[i-1,j] , path_weigths[i-1,j-1])
            else
                path_weigths[i,j] += min(path_weigths[i-1,j-1] , path_weigths[i-1,j] , path_weigths[i-1,j+1])
            end
        end
    end
    return path_weigths
end

function print_matrix(matrix)
    rows , cols = size(matrix)
    for i = 1:rows
        for j = 1:cols
            print(matrix[i,j] , "\t")
        end
        println()
    end
end



weights = [3  6  8 6 3;
           7  6  5 7 3;
           4  10 4 1 6;
           10 4  3 1 2;
           6  1  7 3 9]
path_weigths = cumulative(weights)
print_matrix(path_weigths)

function back_track(path_weigths)
    R = []
    rows , cols = size(path_weigths)
    pos = 1
    prev_pos = 1

    for i = rows:-1:1
        m = path_weigths[i,1]
        for j = 1:cols
            dis = abs(j-prev_pos)
            if dis > 1
                continue
            end
            if path_weigths[i,j] < m
                m = path_weigths[i,j]
                pos = j
            end
        end
        prev_pos = pos
        push!(R , (i,pos))
    end

    return R
end

println(back_track(path_weigths))
