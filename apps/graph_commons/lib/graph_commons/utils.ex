defmodule GraphCommons.Utils do

  def eval(string) do
    with {result, _} <- Code.eval_string(string) do
      result
    end
  end

  def libgraph!(query_string), do: to_query_graph!(NativeGraph, query_string)
end
