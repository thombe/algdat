function counting_sort_letters(A, position::Int)
    k = 26
    C = zeros(Int , k)

    for j = 1:length(A)
        C[A[j]] += 1
    end
    println(A)

    for i = 1:k
        C[i] += C[i-1]
    end

    for j = length(A):1
        B[C[A[j]]] = A[j]
        C[A[j]] -= 1
    end



end
