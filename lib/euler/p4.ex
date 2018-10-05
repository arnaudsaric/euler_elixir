defmodule Euler.P4 do

  @moduledoc """
  A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

  Find the largest palindrome made from the product of two 3-digit numbers.
  """

  defp palindrome?(n) do
    s = to_string n
    s == String.reverse s
  end
  
  defp largest_palindrome(max, n1, n2) do
    if palindrome?(n1*n2) do
      n1*n2
    else
      if n1 == max-1 do
        d = div(n1+n2,2)
        case rem(n1+n2,2) do
          0 -> largest_palindrome(max, d, d-1)
          1 -> largest_palindrome(max, d, d)
        end
      else
        largest_palindrome(max, n1+1, n2-1)
      end
    end
  end

  @doc """

  ## Examples

      iex> Euler.P4.largest_palindrome 100
      9009

  """
  def largest_palindrome(max), do: largest_palindrome(max, max-1, max-1)
  
  @doc """
  Solves the challenge
  """
  def solve, do: IO.puts(largest_palindrome 1000)

end




