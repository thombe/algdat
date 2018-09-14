function counting_sort_letters(A, position::Int)

    k = 26
    C = zeros(Int , k)
    B = deepcopy(A)

    for j = 1:length(A)
    #    if position > length(A[j])
    #        break
    #    end
        C[Int(A[j][position]-96)] += 1
    end

    for i = 2:k
        C[i] += C[i-1]
    end

    for j = length(A):-1:1
        B[C[Int(A[j][position]-96)]] = A[j]
        C[Int(A[j][position]-96)] -= 1
    end

    return B
end

function counting_sort_length(A)
    k = length(A[1])
    for i = 2:length(A)
        if length(A[i]) > k
            k = length(A[i])
        end
    end

    C = zeros(Int , k+1)
    B = deepcopy(A)

    for j = 1:(length(A))
        C[length(A[j])+1] += 1
    end
    #println(C)
    for i = 2:k+1
        C[i] = C[i] +  C[i-1]
    end
    #println(C)

    for j = length(A):-1:1
        B[C[length(A[j])+1]] = A[j]
        C[length(A[j])+1] -= 1
    end
    return B
end

function flexradix(A , max_length)
    B = counting_sort_length(A)
    println(B)
    #k = length(B)
    for i = max_length:-1:1
        k = 1
        for j = length(B):-1:1
            if length(B[j]) >= i
                continue
            else
                println(B[j] , " wasnt longer or equal than " , i , " and thus k = " , j + 1 , '\n')
                k = j + 1
                break
            end
        end
#        println(" k is now: " , k)
        println(B[k:end] , " \nis about to be sortet by the pos " , i)
        B[k:end] = counting_sort_letters(B[k:end] , i)
#        println("Round " , max_length-i+1 , " is done")
        println(B)
        println('\n')
    end
    return B
end

A = ["kobra", "aggie", "agg", "kort", "hyblen"]
B = ["kobra", "alge", "agg", "kort", "hyblen", "i"]
println(flexradix(B, 6))
#B = counting_sort_length(A)
#B[1:2] = counting_sort_letters(B[1:2] , 2)
#println(B)
