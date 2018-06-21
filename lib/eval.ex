defmodule Eval do
  def eval(x) do
    eval(x, Env.new_env())
  end

  def eval(x, env) when is_atom(x) do
    Env.get(x, env)
  end

  def eval(x, env) when is_number(x) do
    x
  end

  def eval([:if, test, conseq | alt], env) do
    case eval(test, env) do
      true -> eval(conseq, env)
      false -> eval(alt, env)
    end
  end

  def eval([:define, symbol | exp], env) do
    exp = if length(exp)<=1 do
           hd(exp)
          end
    IO.puts exp
    Env.put(symbol, eval(exp, env), env)
  end

  def eval(x, env) when is_list(x) do
    proc = eval(hd(x), env)
    [_ | exp] = x
    args = Enum.map(exp, fn arg -> eval(arg, env) end)
    apply(proc, args)
  end
end
