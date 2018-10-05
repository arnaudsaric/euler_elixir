defmodule Euler.P3 do

  @moduledoc """
  The prime factors of 13195 are 5, 7, 13 and 29.

  What is the largest prime factor of the number 600851475143 ?
  """

  defp cut_after(list, threshold, acc\\[])
  defp cut_after([], _, acc), do: acc
  defp cut_after([head|_tail], threshold, acc) when head > threshold, do: acc
  defp cut_after([head|tail], threshold, acc), do: cut_after(tail, threshold, [head|acc])

  defp generate_primes(limit, current\\3, acc\\[2])
  defp generate_primes(limit, current, acc) when limit < current, do: acc
  defp generate_primes(limit, current, acc) do
    sr = :math.sqrt current
    if largest_prime_factor(current, Enum.reverse(acc) |> cut_after(sr)) == current do
      generate_primes(limit, current+2, [current|acc])
    else
      generate_primes(limit, current+2, acc)
    end
  end

  @doc """

  ## Examples

      iex> Euler.P3.largest_prime_factor 13195
      29

  """
  def largest_prime_factor(num, primes\\nil)
  def largest_prime_factor(num, nil), do: largest_prime_factor(num, generate_primes(:math.sqrt(num)))
  def largest_prime_factor(num, []), do: num
  def largest_prime_factor(num, [head|_]) when rem(num,head) == 0, do: head
  def largest_prime_factor(num, [_|tail]), do: largest_prime_factor(num, tail)
  
  @doc """
  Solves the challenge
  Still kind of long but acceptable (1'13 here)
  """
  def solve, do: IO.puts(largest_prime_factor 600851475143)

end



