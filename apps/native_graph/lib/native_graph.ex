defmodule NativeGraph do
  use GraphCommons.Graph, graph_type: :native, graph_module: __MODULE__

  defdelegate write_image(arg), to: NativeGraph.Format, as: :to_png
  defdelegate write_image(arg1, arg2), to: NativeGraph.Format, as: :to_png

  defdelegate random_graph(arg), to: NativeGraph.Builder, as: :random_graph
end
