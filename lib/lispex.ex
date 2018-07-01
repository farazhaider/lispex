defmodule Lispex do
  @moduledoc """
  
  Lisp parser and interpreter written in Elixir. Uses the Scheme flavour of Lisp.

  """

  @doc """

  Takes in the Scheme source code and the current execution Environment 
  and pipes the source code through `Parse.parse/1` and `Eval.eval/2`.

  Returns `Tuple` of output and an environment

  ## Parameters
    
    - **program** : `String` Scheme source code
    - **env** : `Map` The current execution environment. Find more here `Env`.

  ## Example

      iex> Lispex.interpret("(begin (define a 5) (* a 4))", Env.new_env())
      {5, %{..}}


  """
  def interpret(program, env) do
    program
    |> Parse.parse
    |> Eval.eval(env,0)
  end

  @doc """
  
  Converts the output from `interpret/2` to a Scheme style. Replaces '[' and ']' with '(' and ')'.

  Returns `String`

  ## Example

      iex> Lispex.scheme_string([1 2 [3 4]])
      (1 2 (3 4))

  """
  def scheme_string(exp) do
    case is_list(exp) do
      true -> "(" <> (Enum.map(exp,fn x -> scheme_string(x) end) |> Enum.join(" ")) <> ")"  
      false -> to_string(exp)
    end
  end


  @doc """
  
  REPL - Read Evaluate Print Loop for the Scheme code. Takes input from the user, 
  pipes the output through `interpret/2` and `scheme_string/1` and finally prints it on console.

  ## Example

      iex> Lispex.repl
      lispex> (begin (define a 4) (* a 5))
      20
      lispex> (if a<3 (* a 4) (* a 6))
      24

  """
  def repl(env \\ nil) do
    program = IO.gets "lispex> "
    {result, env}  = program |> interpret(env)
    result |> scheme_string |> IO.puts
    repl(env)
  end


end
