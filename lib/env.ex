defmodule Env do
  def new_env() do
    env = %{
      :+ => &(&1 + &2),
      :- => &(&1 - &2),
      :* => &(&1 * &2),
      :/ => &(&1 / &2),
      :< => &(&1 < &2),
      :> => &(&1 > &2),
      :<= => &(&1 <= &2),
      :>= => &(&1 >= &2),
      := => &(&1 == &2),
      ":\=" => &(&1 != &2),
      :pi => :math.pi(),
      :acosh => &:math.acosh(&1),
      :asin => &:math.asin(&1),
      :asinh => &:math.asinh(&1),
      :atan => &:math.atan(&1),
      :atan2 => &:math.atan2(&2, &1),
      :atanh => &:math.atanh(&1),
      :ceil => &:math.ceil(&1),
      :cos => &:math.cos(&1),
      :cosh => &:math.cosh(&1),
      :exp => &:math.exp(&1),
      :floor => &:math.floor(&1),
      :fmod => &:math.fmod(&1, &2),
      :log => &:math.log(&1),
      :log10 => &:math.log10(&1),
      :log2 => &:math.log2(&1),
      :pow => &:math.pow(&1, &2),
      :sin => &:math.sin(&1),
      :sinh => &:math.sinh(&1),
      :sqrt => &:math.sqrt(&1),
      :tan => &:math.tan(&1),
      :tanh => &:math.tanh(&1),
      :car => &hd(&1),
      :cdr => &tl(&1),
      :cons => &([&1] ++ &2),
      :begin => &Enum.take(&1, -1),
      :max => &max(&1, &2),
      :min => &min(&1, &2),
      :and => &(&1 and &2),
      :or => &(&1 or &2),
      :not => &(not &1),
      :null? => &(&1 == []),
      :number? => &is_number(&1),
      :list => & &1,
      :list? => &is_list(&1),
      :symbol? => &is_bitstring(&1),
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
