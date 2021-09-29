with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Containers.Vectors; use Ada.Containers;

procedure assignment1 is

package Integer_Vectors is new Vectors(Natural, Integer);
primes : Integer_Vectors.Vector;
n: Integer;

function sieveOfEratos (a: Integer; b: Integer) return Integer_Vectors.Vector  is
-- the function that returns list of primes between a and b inclusive
       result: Integer_Vectors.Vector;
       Primes: array(1 .. b) of Boolean;
       i: Integer;
       j: Integer;
       
    begin
    --sieve of eratostenes alg implementation
      Primes := (1 => False, others => True);
      i := 2;
       loop
          exit when  b < i * i;
          if Primes(i) then
             j := i + i;
             loop
                exit when j > b;
                Primes(j) := False;
                j := j + i;
             end loop;
          end if;
          i := i + 1;
       end loop;
       
       for p in Primes'Range loop
          if (p >= a) then
              if Primes(p) then
                 result.Append(p);
              end if;
          end if;
       end loop;
       return result;
    end sieveOfEratos;

procedure prime_partitions (n: Integer; k: Integer; l: out Integer_Vectors.Vector) is
-- the function that prints out the prime partitions of a number
  p : Integer;
  l2 : Integer_Vectors.Vector;
  begin

    if n > k then
    -- while n>k recursively we want to exhuast all the possible combinations of primes that could sum up to n
      for i in sieveOfEratos(k+1,n).Iterate loop
        p := Integer_Vectors.Element(i);
        l2:= l;
        Integer_Vectors.Append(l2,p);
        prime_partitions(n - p, p, l2);
      end loop;
    end if;

    if n = 0 then
    -- if the reminder is 0 that means that we have found the primes that sum up to n
      for i in l.Iterate loop
        if Integer_Vectors.Element(i) = l.Last_Element then
          Put(Integer_Vectors.Element(i));
        else
          Put(Integer_Vectors.Element(i));
          Put("+");
        end if;
      end loop;
      Put_line("");
    end if;

    return;
  end prime_partitions;

begin

    Put("Prime-partition assignment -Ada Version ");
    loop
        Put("Enter a number for which you want prime partitions. To exit at any moment please enter any non-number character!");
        begin
            Get(n);
        exception
        when others => 
            return;
        end;
        prime_partitions(n, 1, primes);
    end loop;

end assignment1;