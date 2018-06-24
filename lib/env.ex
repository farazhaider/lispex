defmodule Env do
  def new_env(outer \\ nil) do
    env = %{
        :+ => &(List.first(&1) + List.last(&1)),
        :- => &(List.first(&1) - List.last(&1)),
        :* => &(List.first(&1) * List.last(&1)),
        :/ => &(List.first(&1) / List.last(&1)),
        :< => &(List.first(&1) < List.last(&1)),
        :> => &(List.first(&1) > List.last(&1)),
        :<= => &(List.first(&1) <= List.last(&1)),
        :>= => &(List.first(&1) >= List.last(&1)),
        := => &(List.first(&1) == List.last(&1)),
        :pi => :math.pi(),
        :acosh => &:math.acosh(List.first(&1)),
        :asin => &:math.asin(List.first(&1)),
        :asinh => &:math.asinh(List.first(&1)),
        :atan => &:math.atan(List.first(&1)),
        :atan2 => &:math.atan2(List.last(&1), List.first(&1)),
        :atanh => &:math.atanh(List.first(&1)),
        :ceil => &:math.ceil(List.first(&1)),
        :cos => &:math.cos(List.first(&1)),
        :cosh => &:math.cosh(List.first(&1)),
        :exp => &:math.exp(List.first(&1)),
        :floor => &:math.floor(List.first(&1)),
        :fmod => &:math.fmod(List.first(&1), List.last(&1)),
        :log => &:math.log(List.first(&1)),
        :log10 => &:math.log10(List.first(&1)),
        :log2 => &:math.log2(List.first(&1)),
        :pow => &:math.pow(List.first(&1), List.last(&1)),
        :sin => &:math.sin(List.first(&1)),
        :sinh => &:math.sinh(List.first(&1)),
        :sqrt => &:math.sqrt(List.first(&1)),
        :tan => &:math.tan(List.first(&1)),
        :tanh => &:math.tanh(List.first(&1)),
        :car => &List.first(List.last(&1)),
        :cdr => &tl(List.last(&1)),
        :cons => &([List.first(&1)] ++ List.last(&1)),
        :begin => &List.last(&1),
        :max => &max(List.first(&1) , List.last(&1)),
        :min => &min(List.first(&1) , List.last(&1)),
        :and => &(List.first(&1) and List.last(&1)),
        :or => &(List.first(&1) or List.last(&1)),
        :not => &(not List.first(&1)),
        :null? => &(List.first(&1) == []),
        :number? => &is_number(List.first(&1)),
        :list => &(&1),
        :list? => &is_list(&1),
        :symbol? => &is_bitstring(List.first(&1)),
        :apply => & &1.(&2),
        :append => &(&1 ++ &2),
        :procedure? => &is_function(&1)
      }

    case outer do
        nil -> env
        _ -> Map.put(%{},:outer,outer)
    end
  end

  def put(k, v, env) do
    Map.put(env, k, v)
  end

  def get(x, env) do
    case [Map.get(env, x),Map.get(env,:outer)] do
        [nil,nil] -> nil
        [nil,outer_env] -> get(x,outer_env)
        [val,_] -> val 
    end
  end
end
