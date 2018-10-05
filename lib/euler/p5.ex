defmodule Euler.P5 do

  @moduledoc """
  2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

  What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
  """


  @doc """
  GCD of two integers using Euclid's algorithm

  ## Examples

      iex> Euler.P5.gcd(12,34)
      2

      iex> Euler.P5.gcd(60,42)
      6

      iex> Euler.P5.gcd(60,63)
      3

  """
  def gcd(a, b) do
    case rem(a,b) do
      0 -> b
      r -> gcd(b,r)
    end
  end
  
  @doc """

  ## Examples

      iex> Euler.P5.cumulated_lcm 10
      2520

  """
  def cumulated_lcm(n, acc \\ 1)
  def cumulated_lcm(1, acc), do: acc
  def cumulated_lcm(n, acc), do: cumulated_lcm(n-1, (div(n,gcd(acc,n)))*acc)
  
  @doc """
  Solves the challenge
  """
  def solve, do: IO.puts(cumulated_lcm 20)

end




