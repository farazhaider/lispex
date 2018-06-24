defmodule Lispex do
  def interpret(program) do
    program
    |> Parse.parse
    |> Eval.eval
    |> elem(0)
  end

  def create_ast(program) do
    Parse.parse(program)
  end


end
