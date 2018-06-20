defmodule Lispex do
  @moduledoc """
  Tokenizer and parse for Lisp
  """

  @doc """
  Turns the given Lisp program into an Abstract syntax tree.

  ## Example

      iex> Lispex.parse("(begin (define r 10) (* pi (* r r)))")
      [["begin", ["define", "r", 10], ["*", "pi", ["*", "r", "r"]]]]

  """
  def hello do
    :world
  end

  def tokenize(str) do
    str |> String.replace("("," ( ") 
        |> String.replace(")", " ) ")
        |> String.split
  end

  def parse(program) do 
    program |> tokenize
            |> parse([])
  end 


  ## "(begin (define r 10) ))"
  ## whenever you get a '(' make a new subtree
  def parse(["(" | tail],acc) do
    {rem_tokens,sub_tree} = parse(tail,[])
    parse(rem_tokens,[sub_tree | acc])
  end
  
  ## whenver you get a ')' accumulate the current sub tree in the parent tree
  def parse([")" | tail],acc) do
    {tail, Enum.reverse(acc)}
  end

  ## when you reach the end of tokens roll back and start accumulating
  def parse([],acc) do
    Enum.reverse(acc)
  end

  ## when you encounter an atom, accumulate it and parse remaining tokens
  def parse([head | tail],acc) do
    parse(tail, [atom(head) | acc])
  end

  def atom(token) do    
    case Integer.parse token do
      {value, ""} -> value
      :error ->
        case Float.parse token do
        {value, ""} -> value
        :error -> token
      end
    end
  end

end


