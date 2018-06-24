defmodule Eval do
  def eval(x) do
    eval(x, Env.new_env())
  end

  def eval(x, env) when is_atom(x) do
    {Env.get(x, env), env}
  end

  def eval(x, env) when is_number(x) do
    {x, env}
  end

  def eval([:if, test, conseq | alt], env) do
    case eval(test, env) do
      true -> eval(conseq, env)
      false -> eval(alt, env)
    end
  end

  def eval([:define, symbol | exp], env) do
    exp =
      if length(exp) <= 1 do
        hd(exp)
      end
      {nil, Env.put(symbol,eval(exp, env) |> elem(0), env)}
  end

  def eval(x, env) when is_list(x) do
    proc = eval(hd(x), env) |> elem(0)
    [_ | exp] = x
    args = compute_args(exp, Env.new_env(env)) |> Enum.into([], fn x -> elem(x, 0) end)
    {proc.(args), env}
  end

  def compute_args([], env) do
    []
  end

  def compute_args([h | t], env) do
    {result, env} = eval(h, env)
    [{result, env} | compute_args(t, env)]
  end
end
