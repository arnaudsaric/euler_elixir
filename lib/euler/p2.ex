defmodule Euler.P2 do
  use Bitwise

  @moduledoc """
  Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:

  1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

  By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.
  """

  @doc """

  ## Examples

      iex> Euler.P2.sum_even_fib 100
      44

  """
  def sum_even_fib(limit, term1\\1, term2\\2, acc\\0)
  def sum_even_fib(limit, _, term2, acc) when term2 > limit, do: acc
  def sum_even_fib(limit, term1, term2, acc) when (term2 &&& 1) == 0, do: sum_even_fib(limit, term2, term1+term2, acc+term2)
  def sum_even_fib(limit, term1, term2, acc), do: sum_even_fib(limit, term2, term1+term2, acc)

  @doc """
  Solves the challenge
  """
  def solve, do: IO.puts(sum_even_fib 4000000)

end


