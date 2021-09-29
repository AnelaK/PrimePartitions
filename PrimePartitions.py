import sys, math

def sieveOfEratosthenes(a, b):
    #returns list of all primes between a and b inclusive  using the method Sieve of Eratosthenes
    primes =[True for i in range(b+1)]
    primes[0] = False
    primes[1] = False
    
    length = int(math.sqrt(b))
    for i in range(length + 1):
        if (primes[i] == True):
            for j in range(i ** 2, b + 1, i):
                primes[j] = False
    
    result_primes = []
    for p in range(a, b + 1, 1):
        if (primes[p] == True):
            result_primes.append(p);
    
    return result_primes

def prime_partitions (n, k, solution=[]):
#returns prime partitions of n with all the primes being greater than k
    if (n == 0):
    #if we reach 0 after recursive calls that means we have found primes that when summed up give the n
            solution = list(map(str, solution))
            print(' + '.join(solution))
    elif (n > k):
    #recursive calls 
        for prime in sieveOfEratosthenes(k + 1, n):
            prime_partitions(n-prime, prime, solution + [prime])

print("Prime Partitions - Python Version \n")
while True:
    try:
        n = int(input("Enter a number for which you want prime partitions. To exit at any moment please enter any non-number character! "))
        prime_partitions(n, 1)
    except:
        print("You entered non-number. Goodbye!")
        sys.exit()