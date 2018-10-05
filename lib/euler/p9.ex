defmodule Euler.P9 do

  @moduledoc """
  A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

  a2 + b2 = c2
  For example, 32 + 42 = 9 + 16 = 25 = 52.

  There exists exactly one Pythagorean triplet for which a + b + c = 1000.
  Find the product abc.
  """

  defp all_squares(n, acc \\ [])
  defp all_squares(0, acc), do: acc
  defp all_squares(n, acc), do: all_squares(n-1, [{n,n*n}|acc])

  defp find_c(c2, squares)
  defp find_c(_, []), do: nil
  defp find_c(c2, [{_,n2}|_]) when n2 > c2, do: nil
  defp find_c(c2, [{n,n2}|_]) when n2 == c2, do: n
  defp find_c(c2, [_|tail]), do: find_c(c2, tail)

  defp find_triplet_for_a(a, squares)
  defp find_triplet_for_a(_, []), do: nil
  defp find_triplet_for_a({a,a2}, [{b,b2}|tail]) do
    case find_c(a2+b2, tail) do
      nil -> find_triplet_for_a({a,a2}, tail)
      c when a+b+c == 1000 -> a*b*c
      _ -> find_triplet_for_a({a,a2}, tail)
    end
  end

  defp find_triplet(squares \\ nil)
  defp find_triplet(nil), do: all_squares(500) |> find_triplet
  defp find_triplet([]), do: nil
  defp find_triplet([a|tail]) do
    case find_triplet_for_a(a, tail) do
      nil -> find_triplet(tail)
      p -> p
    end
  end


  @doc """
  Solves the challenge
  """
  def solve, do: IO.puts(find_triplet())

end
