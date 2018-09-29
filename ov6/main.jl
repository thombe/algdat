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



weights = [27 1 76 31 1 39 92;
            95 49 2 20 14 63 91;
            133 85 98 5 99 85 90;
            87 145 15 124 168 103 143;
            98 180 217 33 122 126 140;
            164 133 120 131 212 202 165;
            175 152 166 211 219 200 245]
weights_2 = [26 58 15 57 42 36;
            102 112 89 77 134 91;
            124 105 81 101 100 178;
            176 180 108 90 171 160;
            212 169 137 156 134 192;
            239 204 140 198 175 203;
            248 186 212 164 227 275;
            244 280 196 242 184 316;
            301 280 248 195 225 260;
            322 298 216 240 283 320]

path_weigths = cumulative(weights)
#print_matrix(path_weigths)


function back_track(path_weigths)
    R = [] #result
    rows , cols = size(path_weigths)


    pos = 1
    m = path_weigths[rows,1]
    for j = 1:cols
        if path_weigths[rows,j] < m
            m = path_weigths[rows,j]
            pos = j
        end
    end
    push!(R,(rows,pos)) #first row added to result


    for i = rows-1:-1:1 #looping rest of rows
        if pos == 1
            m = path_weigths[i , 1]
            for j = 1:pos+1
                if path_weigths[i,j] < m
                    m = path_weigths[i,j]
                    pos = j
                end
            end
        elseif pos == cols
            m = path_weigths[i , pos-1] #start checking one the first valid pos
            pos = pos - 1
            for j = pos:cols
                if path_weigths[i,j] < m
                    m = path_weigths[i,j]
                    pos = j
                end
            end
        else
            m = path_weigths[i , pos-1]
            pos -= 1
            for j = pos:pos+2
                if path_weigths[i,j] < m
                    m = path_weigths[i,j]
                    pos = j
                end
            end
        end
        push!(R , (i,pos))
    end

    return R
end

#println(back_track(path_weigths))
print_matrix(weights_2)
println(back_track(weights_2))
