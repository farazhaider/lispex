defmodule Eval do
  @moduledoc """
  Eval module for Lispex. Exposes one public function `eval/3` for the evaluation of AST.
  """

  @doc """

  Evaluates the AST recursively based on the constructs.
  
  """
  def eval(x, env, _) do
    case env do
        nil -> eval(x, Env.new_env())
        _ -> eval(x, env)
    end
  end

  defp eval(x, env) when is_atom(x) do
    {Env.get(x, env), env}
  end

  defp eval(x, env) when is_number(x) do
    {x, env}
  end

  defp eval([:if, test, conseq | alt], env) do
    alt = sanitize(alt)
    case eval(test, env) do
      {true,_} -> eval(conseq, env)
      {false,_} -> eval(alt, env)
    end
  end

  defp eval([:define, symbol | exp], env) do
    exp = sanitize(exp)
    {nil, Env.put(symbol,eval(exp, env) |> elem(0), env)}
  end

  defp eval([:set!, symbol | exp], env) do
    exp = sanitize(exp)
     case Env.get(symbol,env) do
         nil -> raise "#{symbol} not defined."
         _ -> {nil, Env.put(symbol, eval(exp, env) |> elem(0),env) }
     end
  end

  defp eval(x, env) when is_list(x) do
    proc = eval(hd(x), env) |> elem(0)
    [_ | exp] = x
    parent_env  = env
    child_env = Env.new_env(env)
    args = compute_args(exp, child_env) |> Enum.into([], fn x -> elem(x, 0) end)
    {proc.(args), parent_env}
  end

  defp compute_args([], _) do
    []
  end

  defp compute_args([h | t], env) do
    {result, env} = eval(h, env)
    [{result, env} | compute_args(t, env)]
  end

  defp sanitize(x) do
    if length(x) <= 1 do
        hd(x)
    else x
    end
  end

end
