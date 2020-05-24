defmodule NativeGraph do

	def read_graph(graph_file), do: GraphCommons.Graph.read_graph(graph_file, :native)

	def write_graph(graph_data, graph_file), do: GraphCommons.Graph.write_graph(graph_data, graph_file, :native)

end
