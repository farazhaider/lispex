defmodule Lispex do
  def interpret(program, env) do
    program
    |> Parse.parse
    |> Eval.eval(env,0)
  end

  def scheme_string(exp) do
    case is_list(exp) do
      true -> "(" <> (Enum.map(exp,fn x -> scheme_string(x) end) |> Enum.join(" ")) <> ")"  
      false -> to_string(exp)
    end
  end

  def repl(env \\ nil) do
    program = IO.gets "lispex> "
    {result, env}  = program |> interpret(env)
    result |> scheme_string |> IO.puts
    repl(env)
  end

  def create_ast(program) do
    Parse.parse(program)
  end


end
