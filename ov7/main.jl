function can_use_greedy(coins)
    for c in coins
        if c
            body
        end
    end
end

function min_coins_greedy(coins , value)
    T = []
    R = 0
    sum = 0
    for coin in coins
        while sum+coin <= value
            sum += coin
            R += 1
            push!(T,coin)
        end
    end
    return R , T
end


C = [4,3,1]

println(min_coins_greedy(C , 6))
println(min_coins_greedy([1000,500,100,20,5,1],1226))
println(min_coins_greedy([1000,500,100,20,5,1],2567))
