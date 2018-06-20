defmodule Lispex do
  def interpret(program) do
    program
    |> Parse.parse
    |> Eval.eval
  end

  def create_ast(program) do
    Parse.parse(program)
  end
end
