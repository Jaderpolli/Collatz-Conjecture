using Plots
pyplot()

function collatz(n::BigInt)
     n % 2 == 0 ? div(n,2) : div((3n+1),2)
end
