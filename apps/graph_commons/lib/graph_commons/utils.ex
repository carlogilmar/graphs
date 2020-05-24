defmodule GraphCommons.Utils do

  def eval(string) do
    with {result, _} <- Code.eval_string(string) do
      result
    end
  end

end
