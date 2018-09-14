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

A = ["ccc", "cba", "ca", "ab", "abc"]
counting_sort_letters(A , 2)
