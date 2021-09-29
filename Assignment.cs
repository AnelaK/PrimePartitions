using System;
using System.Collections.Generic;
using System.Linq;

namespace Assignment1{
    class UniquePrimePartitions{
        static List <int> primes (int a, int b){ 
        // Sieve of Eratosthenes implemented to get primes between a and b inclusive
            List <int> primes = new List <int>();
            bool[] numbers = new bool[b+1];

            for (int ind = 2; ind <= b; ind++){
                if (ind != 2 && (ind % 2) == 0) {
                    numbers[ind] = false;
                }
                else {
                    numbers[ind] = true;
                }
            }
            
            for (int i = 3; i <= Math.Sqrt(b); i++)
                if (numbers[i] == true){
                    for(int j = i * i; j < b+1; j+=i)
                        numbers[j] = false;
                }
                
            for (int p = a; p < b+1; p++)
                if(numbers[p] == true){
                    primes.Add(p);
                }
            return primes;
        }

        static void prime_partitions(int n, int k, List<int> solution){
            if(n == 0){
                string sum = string.Join(" + ", solution.Select(x => x.ToString()).ToArray());
                Console.WriteLine(sum);
            }
            else if(n > k){ 
                List <int> updated_primes = primes (k+1, n);
                foreach(var p in updated_primes){
                    List <int> updated_solution = new List<int>();
                    updated_solution.Add(p);
                    prime_partitions(n-p, p,solution.Concat(updated_solution).ToList());
                }
            }
        }

        static void Main(string[] args) {
            Console.WriteLine("Please enter a number: ");
            int n = Int32.Parse(Console.ReadLine());
            List <int> lst = new List<int>();
            prime_partitions(n, 1, lst);
        }
    }
}
