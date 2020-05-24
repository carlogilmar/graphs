defmodule NativeGraph do
  use GraphCommons.Graph, graph_type: :native, graph_module: __MODULE__

  def read_graph(graph_file), do: GraphCommons.Graph.read_graph(graph_file, :native)

  def write_graph(graph_data, graph_file),
    do: GraphCommons.Graph.write_graph(graph_data, graph_file, :native)
end
