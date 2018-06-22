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
    { nil , Env.put(symbol, eval(exp, env), env)}
  end

  def eval(x, env) when is_list(x) do
    proc = elem(eval(hd(x), env),0)
    [_ | exp] = x
    #IO.inspect proc
    args = Enum.map(exp, fn arg -> eval(arg, env) end) |> Enum.into([], fn x -> elem(x,0) end)
    #IO.inspect args
    {proc.(args),nil}
    #apply(proc, args)
  end
end
