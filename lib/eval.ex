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
    alt = sanitize(alt)
    case eval(test, env) do
      {true,_} -> eval(conseq, env)
      {false,_} -> eval(alt, env)
    end
  end

  def eval([:define, symbol | exp], env) do
    exp = sanitize(exp)
      {nil, Env.put(symbol,eval(exp, env) |> elem(0), env)}
  end

  def eval([:set!, symbol | exp], env) do
    exp = sanitize(exp)
     case Env.get(symbol,env) do
         nil -> raise "#{symbol} not defined."
         _ -> {nil, Env.put(symbol, eval(exp, env) |> elem(0),env) }
     end
  end

  def eval(x, env) when is_list(x) do
    proc = eval(hd(x), env) |> elem(0)
    [_ | exp] = x
    parent_env  = env
    child_env = Env.new_env(env)
    args = compute_args(exp, child_env) |> Enum.into([], fn x -> elem(x, 0) end)
    {proc.(args), parent_env}
  end

  def compute_args([], env) do
    []
  end

  def compute_args([h | t], env) do
    {result, env} = eval(h, env)
    [{result, env} | compute_args(t, env)]
  end

  def sanitize(x) do
    if length(x) <= 1 do
        hd(x)
    else x
    end
  end
end
