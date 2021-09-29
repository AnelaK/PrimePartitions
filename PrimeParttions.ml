open Printf

let is_prime x =
    let rec not_divisible d =
      d * d > x || (x mod d <> 0 && not_divisible (d + 1)) in
    x <> 1 && not_divisible 2;;

let rec primes a b l = 
  if a > b then l
  else
    if is_prime a then
      primes (a + 1) b (a :: l)
    else
      primes (a + 1) b l

let print_list l =
    List.iteri (fun i p -> 
      if i == (List.length l) - 1 then 
        printf "%d \n" p
      else 
        printf "%d + " p
      ) l

let rec prime_partitions n k l =
  if n == 0 then
    print_list l
  else if n > k then
    List.iter (fun p ->
      prime_partitions (n - p) p (p :: l)
    ) primes (k + 1) n []

let rec input_prompt () =
  print_string "Prime Partition - Ocaml version \n";
  print_string "Enter a number for which you want prime partitions. To exit at any moment please enter any non-number character! ";
  let n = read_int () in 
    prime_partitions n 1 [];
    input_prompt();;

input_prompt()