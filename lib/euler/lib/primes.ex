defmodule Euler.Lib.Primes do

  @moduledoc """
  Module to generate primes
  """

  defp first_prime_factor_ets(num, thr, idx\\0) do
    case :ets.lookup(:primes, idx) do
      [{_,prime}] when prime > thr -> num
      [{_,prime}] when rem(num,prime) == 0 -> prime
      _ -> first_prime_factor_ets(num, thr, idx+1)
    end
  end

  defp init_primes_ets() do
    :ets.new(:primes, [:set, :private, :named_table])
    :ets.insert(:primes, {0, 2})
    :ets.insert(:primes, {:last, {1,3}})
  end

  @doc """
  Generates primes until limit is reached.
  Stateful: if you call it later with another limit, it won't recompute primes it already knows
  """

  def gen_primes_ets(limit, current\\nil, idx\\0)
  def gen_primes_ets(limit, nil, _) do
    case :ets.info(:primes) do
      :undefined -> init_primes_ets()
      _ -> nil
    end
    case :ets.lookup(:primes, :last) do
      [{:last,{start_idx,start}}] -> gen_primes_ets(limit, start, start_idx)
      _ -> raise "should not happen"
    end
  end
  def gen_primes_ets(limit, current, idx) when limit < current do
    :ets.insert(:primes, {:last,{idx,current}})
    :ets.select(:primes, [{{:'$1',:'$2'},[{:is_integer,:'$1'},{:'<',:'$2',limit+1}],[:'$2']}])
  end
  def gen_primes_ets(limit, current, idx) do
    sr = :math.sqrt current
    if first_prime_factor_ets(current, sr) == current do
      :ets.insert(:primes, {idx, current})
      gen_primes_ets(limit, current+2, idx+1)
    else
      gen_primes_ets(limit, current+2, idx)
    end
  end

  @doc """
  Primality test
  """
  def is_prime?(n) do
    case :ets.match(:primes, {:'_', n}) do
        [] -> false
        [[]] -> true
    end
  end
end
