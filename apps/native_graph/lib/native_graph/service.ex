defmodule NativeGraph.Service do
	@moduledoc """
	Module implementing graph store behaviour for native graphs.
	"""
	@behaviour GraphCommons.Service
	use Agent
	import GraphCommons.Utils, only: [eval: 1]
	@dets_table 'priv/service/native/ex_graphs_book.dets'
	## AGENT
	# functions for managing Agent process
	## BEHAVIOUR
	# functions implementing graph service callbacks

	def start_link(_ex) do
		:dets.open_file(:ex_graphs_book, [{:file, @dets_table}])
		:dets.member(:ex_graphs_book, :graph) |> case do
			true ->
				[graph: g] = :dets.lookup(:ex_graphs_book, :graph)
				Agent.start_link(fn -> g end, name: __MODULE__)
			false ->
				Agent.start_link(fn -> %Graph{} end, name: __MODULE__)
		end
	end

	def stop() do
		Agent.stop(__MODULE__)
		:dets.close(:ex_graphs_book)
	end

	def graph_create(graph) do
		graph_delete()
		graph_update(graph)
	end

	def graph_delete() do
		Agent.update(__MODULE__, fn _state -> %Graph{} end)
		:dets.delete(:ex_graphs_book, :graph)
	end

	def graph_read() do
		Agent.get(__MODULE__, & &1)
	end

	def graph_update(graph) do
		g = graph.data |> eval Agent.update(__MODULE__, fn _state -> g end)
		:dets.insert(:ex_graphs_book, graph: g)
	end

	def query_graph(%GraphCommons.Query{} = query) do
		:native = query.type
		result =
			eval(
				"import Graph; import Enum; NativeGraph.graph_read |> (#{query.data})"
			)
		{:ok, result}
	end

	def query_graph!(%GraphCommons.Query{} = query) do
		:native = query.type
		eval(
			"import Graph; import Enum; NativeGraph.graph_read |> (#{query.data})"
		)
	end

	def graph_info() do
		g = graph_read()
		info = Graph.info(g)
		labels =
			Graph.vertices(g)
			|> Enum.reduce([], fn v, acc -> acc ++ Graph.vertex_labels(g, v) end)
			|> Enum.uniq()
			|> Enum.sort()

		%GraphCommons.Service.GraphInfo{
			type: :native,
			num_nodes: info.num_vertices,
			num_edges: info.num_edges,
			density: _density(info.num_vertices, info.num_edges),
			labels: labels
		}
	end

	defp _density(n, m) do
		if n > 0, do: Float.round(m / (n * (n - 1)), 3), else: 0.0
	end

end

