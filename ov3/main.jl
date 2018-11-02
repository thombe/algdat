

function bisect_left(A, p, r, v)
    i = p
    if p < r
       q = floor(Int, (p+r)/2)  # floor() er en innebygd funksjon som runder ned. ceil() runder opp.
       if v <= A[q]
           i = bisect_left(A, p, q, v)
       else
           i = bisect_left(A, q+1, r, v)
       end
    end
    return i
end

function bisect_right(A, p, r, v)
    i = p
    if p < r
       q = floor(Int, (p+r)/2)  # floor() er en innebygd funksjon som runder ned. ceil() runder opp.
       if v < A[q]
            i = bisect_right(A, p, q, v)
       else
            i = bisect_right(A, q+1, r, v)
       end
    end
    return i
end


function mergealg!(A , l::Int64 , m::Int64 , r::Int64)
    n1 = m - l + 1
    n2 = r - m
    L = zeros(n1)
    R = zeros(n2)


    for i = 1:n1
        L[i] = A[l+i-1]
    end
    for j = 1:n2
        R[j] = A[m+j]
    end

    i = 1
    j = 1
    k = l

    while i <= n1 && j <= n2
        if L[i] <= R[j]
            A[k] = L[i]
            i += 1
            k += 1
        else
            A[k] = R[j]
            j += 1
            k += 1
        end
    end

    while i <= n1
        A[k] = L[i]
        i += 1
        k += 1
    end

    while j <= n2
        A[k] = R[j]
        j += 1
        k += 1
    end

end
function algdat_sorter!(A , l::Int64 , r::Int64)
    if l < r
        m::Int64 = floor((l+r)/2)
        algdat_sorter!(A , l , m)
        algdat_sorter!(A , m+1 , r)
        mergealg!(A , l , m , r)
    end

end

function algdat_sort!(A)
    l::Int64 = 1
    r::Int64 = length(A)

    algdat_sorter!(A , l ,r)
end

function median(A)
    l = length(A)
    m = div(l , 2)
    if l % 2 == 1
        return A[m + 1]
        print(l , " is odd number\n")
    else
        return ( A[m] + A[m + 1] ) / 2
    end
end

function find_median(A , lower , upper)
    l = bisect_left(A, 1 , length(A)+1 , lower)
    u = bisect_right(A , 1 , length(A)+1 , upper) -1

    print("Finding median of " , A[l:u] , '\n')
    return(median(A[l:u]))
end

A = [1,2,3]
print(find_median(A , 1 , 2))
