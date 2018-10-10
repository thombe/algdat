function can_use_greedy(coins)
    for i=1:length(coins)-1
        if coins[i] % coins[i+1] != 0
            return false
        end
    end
    return true
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
    return R
end


C = [4,3,1]

println(min_coins_greedy(C , 6))
println(min_coins_greedy([1000,500,100,20,5,1],1226))
println(min_coins_greedy([1000,500,100,20,5,1],2567))


inf = 100000000000

function find_greedy(coins , value)
    r = inf
    for i = 1:length(coins)
        if min_coins_greedy(coins[i:end],value) < r
            println("The list " , coins[i:end] , "\ngave a lower ans")
            r = min_coins_greedy(coins[i:end], value)
        end
    end
    return r
end


function min_coins_dynamic(coins,value)
    while value
        

    return r
end

println()
#println(min_coins_dynamic([1000,500,100,20,5,1],1226))
#println(min_coins_dynamic([4,3,1],6))
println(min_coins_dynamic([1000, 500, 200, 100, 50, 20, 10, 5, 4, 3, 1],1027))
