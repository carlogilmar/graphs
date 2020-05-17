defmodule GraphCommons.Service do
  @optional_callbacks graph_info: 0
  ## GRAPH
  @callback graph_create(GraphCommons.Graph.t()) :: any()
  @callback graph_delete() :: any()
  @callback graph_read() :: any()
  @callback graph_update(GraphCommons.Graph.t()) :: any()
  @callback graph_info() :: any()
  ## QUERY
  @callback query_graph(GraphCommons.Query.t()) :: any()
  @callback query_graph!(GraphCommons.Query.t()) :: any()
end
