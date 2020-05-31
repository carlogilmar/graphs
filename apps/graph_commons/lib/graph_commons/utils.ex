defmodule GraphCommons.Utils do

  def eval(string) do
    with {result, _} <- Code.eval_string(string) do
      result
    end
  end

  def libgraph!(query_string), do: to_query_graph!(NativeGraph, query_string)

  defguard is_module(graph_module)
  when graph_module == DGraph or graph_module == NativeGraph or
  graph_module == PropertyGraph or graph_module == RDFGraph or graph_module == TinkerGraph

  defp to_query_graph!(graph_module, query_string) when is_module(graph_module) do
    query_string
    |> graph_module.new_query()
    |> graph_module.query_graph!()
  end
end
