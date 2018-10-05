defmodule Euler.P6 do

  @moduledoc """
  The sum of the squares of the first ten natural numbers is,

  12 + 22 + ... + 102 = 385
  The square of the sum of the first ten natural numbers is,

  (1 + 2 + ... + 10)2 = 552 = 3025
  Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.

  Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
  """

  defp sum_squares(n, acc \\ 0)
  defp sum_squares(0, acc), do: acc
  defp sum_squares(n, acc), do: sum_squares(n-1, n*n+acc)

  @doc """

  ## Examples

      iex> Euler.P6.diff 10
      2640

  """
  def diff(n), do: div(n*n*(n+1)*(n+1), 4) - sum_squares n
  
  @doc """
  Solves the challenge
  """
  def solve, do: IO.puts(diff 100)

end





