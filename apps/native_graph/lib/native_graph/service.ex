defmodule NativeGraph.Service do
	@moduledoc """
	Module implementing graph store behaviour for native graphs. """
	@behaviour GraphCommons.Service
	use Agent
	import GraphCommons.Utils, only: [eval: 1]
	@dets_table 'priv/service/native/ex_graphs_book.dets'
	## AGENT
	# functions for managing Agent process
	## BEHAVIOUR
	# functions implementing graph service callbacks
end

