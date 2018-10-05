defmodule Euler.P7 do

  @moduledoc """
  By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

  What is the 10 001st prime number?
  """

  defp cut_after(list, threshold, acc\\[])
  defp cut_after([], _, acc), do: acc
  defp cut_after([head|_tail], threshold, acc) when head > threshold, do: acc
  defp cut_after([head|tail], threshold, acc), do: cut_after(tail, threshold, [head|acc])

  defp largest_prime_factor(num, []), do: num
  defp largest_prime_factor(num, [head|_]) when rem(num,head) == 0, do: head
  defp largest_prime_factor(num, [_|tail]), do: largest_prime_factor(num, tail)

  @doc """

  ## Examples

      iex> Euler.P7.nth_prime 6
      13

      iex> Euler.P7.nth_prime 9
      23

  """
  def nth_prime(n, current\\3, acc\\[2])
  def nth_prime(1, _, [head|_]), do: head
  def nth_prime(n, current, acc) do
    sr = :math.sqrt current
    if largest_prime_factor(current, Enum.reverse(acc) |> cut_after(sr)) == current do
      nth_prime(n-1, current+2, [current|acc])
    else
      nth_prime(n, current+2, acc)
    end
  end
  
  @doc """
  Solves the challenge
  """
  def solve, do: IO.puts(nth_prime 10001)

end






