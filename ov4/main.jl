function counting_sort_letters(A, position::Int)
    k = 26
    C = zeros(Int , k)
    B = deepcopy(A)

    for j = 1:length(A)
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

    C = zeros(Int , k)
    B = deepcopy(A)

    for j = 1:length(A)
        C[length(A[j])] += 1
    end

    for i = 2:k
        C[i] += C[i-1]
    end

    for j = length(A):-1:1
        B[C[length(A[j])]] = A[j]
        C[length(A[j])] -= 1
    end
    return B
end

A = ["bbbb" , "aa" , "aaaa" , "ccc"]
counting_sort_length(A)
