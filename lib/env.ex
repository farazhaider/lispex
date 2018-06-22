defmodule Env do
  def new_env() do
    env = %{
      :+ => &(hd(&1) + List.last(&1)),
      :- => &(hd(&1) - List.last(&1)),
      :* => &(hd(&1) * List.last(&1)),
      :/ => &(hd(&1) / List.last(&1)),
      :< => &(hd(&1) < List.last(&1)),
      :> => &(hd(&1) > List.last(&1)),
      :<= => &(hd(&1) <= List.last(&1)),
      :>= => &(hd(&1) >= List.last(&1)),
      := => &(hd(&1) == List.last(&1)),
      :pi => :math.pi(),
      :acosh => &:math.acosh(hd(&1)),
      :asin => &:math.asin(hd(&1)),
      :asinh => &:math.asinh(hd(&1)),
      :atan => &:math.atan(hd(&1)),
      :atan2 => &:math.atan2(List.last(&1), hd(&1)),
      :atanh => &:math.atanh(hd(&1)),
      :ceil => &:math.ceil(hd(&1)),
      :cos => &:math.cos(hd(&1)),
      :cosh => &:math.cosh(hd(&1)),
      :exp => &:math.exp(hd(&1)),
      :floor => &:math.floor(hd(&1)),
      :fmod => &:math.fmod(hd(&1), List.last(&1)),
      :log => &:math.log(hd(&1)),
      :log10 => &:math.log10(hd(&1)),
      :log2 => &:math.log2(hd(&1)),
      :pow => &:math.pow(hd(&1), List.last(&1)),
      :sin => &:math.sin(hd(&1)),
      :sinh => &:math.sinh(hd(&1)),
      :sqrt => &:math.sqrt(hd(&1)),
      :tan => &:math.tan(hd(&1)),
      :tanh => &:math.tanh(hd(&1)),
      :car => &hd(List.last(&1)),
      :cdr => &tl(List.last(&1)),
      :cons => &([hd(&1)] ++ List.last(&1)),
      :begin => &Enum.take(&1, -1),
      :max => &max(hd(&1) , List.last(&1)),
      :min => &min(hd(&1) , List.last(&1)),
      :and => &(hd(&1) and List.last(&1)),
      :or => &(hd(&1) or List.last(&1)),
      :not => &(not hd(&1)),
      :null? => &(hd(&1) == []),
      :number? => &is_number(hd(&1)),
      :list => &(&1),
      :list? => &is_list(&1),
      :symbol? => &is_bitstring(hd(&1)),
      :apply => & &1.(&2),
      :append => &(&1 ++ &2),
      :procedure? => &is_function(&1)
    }

    env
  end

  def put(k, v, env) do
    Map.put(env, k, v)
  end

  def get(x, env) do
    Map.get(env, x)
  end
end
