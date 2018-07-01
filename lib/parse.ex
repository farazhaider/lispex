defmodule Parse do
  @moduledoc """
  Tokenizer and parser for the Lisp source code
  """

  

  @doc """
  Splits the lisp source code by spaces. Ensures spaces between '(' and ')' by replacing 
  them with ' ( ' and ' ) '.
  """
  def tokenize(str) do
    str
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.split()
  end



  @doc """
  Turns the given Lisp program into an Abstract syntax tree by calling `tokenize/1` 
  and recursively calling 'parse/2' a private function in the `Parse` module.

  Returns `List`

  ## Parameters
    
    - **program** : `String` Lisp source code

  ## Example

      iex> Lispex.parse("(begin (define r 10) (* pi (* r r)))")
      [["begin", ["define", "r", 10], ["*", "pi", ["*", "r", "r"]]]]

  """
  def parse(program) do
    program
    |> tokenize
    |> parse([])
    |> hd
  end

  ## "(begin (define r 10) ))"
  ## whenever you get a '(' make a new subtree
  @doc false
  defp parse(["(" | tail], acc) do
    {rem_tokens, sub_tree} = parse(tail, [])
    parse(rem_tokens, [sub_tree | acc])
  end

  ## whenver you get a ')' accumulate the current sub tree in the parent tree
  defp parse([")" | tail], acc) do
    {tail, Enum.reverse(acc)}
  end

  ## when you reach the end of tokens roll back and start accumulating
  defp parse([], acc) do
    Enum.reverse(acc)
  end

  ## when you encounter an atom, accumulate it and parse remaining tokens
  defp parse([head | tail], acc) do
    parse(tail, [atom(head) | acc])
  end


  @doc """
  
  Converts a String token to its atomic form. 

  Returns `Integer`, `Float` or an `Atom`

  ## Parameters

    - **token** : `String` token

  """
  def atom(token) do
    case Integer.parse(token) do
      {value, ""} ->
        value

      :error ->
        case Float.parse(token) do
          {value, ""} -> value
          :error -> String.to_atom(token)
        end
    end
  end
end
