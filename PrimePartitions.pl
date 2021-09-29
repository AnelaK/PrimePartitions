is_prime(X) :- X < 2 -> false;
    		   X = 2 -> true;
    		   X = 3 -> true;
    		   integer(X), X > 3, X mod 2 =\= 0, \+ is_divisible(X,3).

is_divisible(N,F) :- N mod F =:= 0.
is_divisible(N,F) :- F * F < N, F2 is F + 2, is_divisible(N,F2).

primes(A, B, L) :-
	primes(A, B, [], L).

primes(A, B, L, LF) :-
	(
		A > B -> 
		LF = L
		;
    	AA is A + 1,
        (
        is_prime(A) ->  primes(AA, B, [A | L], LF);
        primes(AA, B, L, LF)
        )
	).
reverse([H|T],X,RevL) :- reverse(T,X,[H|RevL]).

prime_partition(N) :-
	primes(1, N, Primes),
    reverse(Primes,RevP),
	prime_partition(N, RevP, [], Sum),
	printList(Sum).

prime_partition(N, P, L1, L2) :-
	(
		concat(S, L1),
		S = N -> L2 = L1;
		P = [H|T],
		(
		prime_partition(N, T, [H|L1], L2) ;
		prime_partition(N, T, L1, L2)
		)
	).

concat(S, L) :- 
	L = [H|T],
	concat(S2, T),
	S is H + S2.
concat(0, []).

printList(Lst) :-
	Lst = [H|T],
	length(T, TailSize),
	(
		TailSize = 0 -> format('~d',H);
		format('~d + ', H)
	),
	printList(T).
printList([]).