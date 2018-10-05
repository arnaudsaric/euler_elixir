defmodule Euler.P1 do
  @moduledoc """
  If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
  Find the sum of all the multiples of 3 or 5 below 1000.
  """

  defp mod_inc(num, mod) do
    if num == mod-1 do
      0
    else
      num+1
    end
  end

  @doc """

  ## Examples

      iex> Euler.P1.sum_multiples 10
      23

  """
  def sum_multiples(n, i\\0, mod3\\0, mod5\\0, acc\\0)
  def sum_multiples(n, i, _, _, acc) when i == n, do: acc
  def sum_multiples(n, i, 0, mod5, acc), do: sum_multiples(n, i+1, 1, mod_inc(mod5,5), acc+i)
  def sum_multiples(n, i, mod3, 0, acc), do: sum_multiples(n, i+1, mod_inc(mod3,3), 1, acc+i)
  def sum_multiples(n, i, mod3, mod5, acc), do: sum_multiples(n, i+1, mod_inc(mod3,3), mod_inc(mod5,5), acc)

  @doc """
  Solves the challenge
  """
  def solve, do: IO.puts(sum_multiples(1000))

end

