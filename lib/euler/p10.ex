defmodule Euler.P10 do

  @moduledoc """
  The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

  Find the sum of all the primes below two million.
  """

  defp first_prime_factor(num, [], _), do: num
  defp first_prime_factor(num, [head|_], thr) when head > thr, do: num
  defp first_prime_factor(num, [head|_], _) when rem(num,head) == 0, do: head
  defp first_prime_factor(num, [_|tail], thr), do: first_prime_factor(num, tail, thr)

  @doc """

  Kept for reference, Elixir lists show their limits here...
  ETS version below is about 100 times faster

  ## Examples

      iex> Euler.P10.sum_primes 10
      17

  """
  def sum_primes(limit, current\\3, acc\\[2], sum\\2)
  def sum_primes(limit, current, _acc, sum) when limit < current, do: sum
  def sum_primes(limit, current, acc, sum) do
    sr = :math.sqrt current
    if first_prime_factor(current, :lists.reverse(acc,[]), sr) == current do
      sum_primes(limit, current+2, [current|acc], current+sum)
    else
      sum_primes(limit, current+2, acc, sum)
    end
  end

  defp first_prime_factor_ets(num, thr, idx\\0) do
    case :ets.lookup(:primes, idx) do
      [{_,prime}] when prime > thr -> num
      [{_,prime}] when rem(num,prime) == 0 -> prime
      _ -> first_prime_factor_ets(num, thr, idx+1)
    end
  end

  @doc """

  ## Examples

      iex> Euler.P10.sum_primes_ets 10
      17

  """
  def sum_primes_ets(limit, current\\3, idx\\0, sum\\2)
  def sum_primes_ets(limit, current, 0, sum) do
    :ets.new(:primes, [:set, :private, :named_table])
    :ets.insert(:primes, {0, 2})
    sum_primes_ets(limit, current, 1, sum)
  end
  def sum_primes_ets(limit, current, _idx, sum) when limit < current, do: sum
  def sum_primes_ets(limit, current, idx, sum) do
    sr = :math.sqrt current
    if first_prime_factor_ets(current, sr) == current do
      :ets.insert(:primes, {idx, current})
      sum_primes_ets(limit, current+2, idx+1, current+sum)
    else
      sum_primes_ets(limit, current+2, idx, sum)
    end
  end

  @doc """
  Solves the challenge
  """
  def solve, do: IO.puts(sum_primes_ets(2000000))

end

