defmodule GraphCommons do
  @typedoc "Types for graph storage."
  @type base_type :: :native | :property | :rdf | :tinker
  @type graph_type :: base_type()
  @type query_type :: base_type()
  @typedoc "Type for testing file types."
  @type file_test :: :dir? | :regular? | :exists?
  @priv_dir "#{:code.priv_dir(:graph_commons)}"

  def exports_dir(), do: @priv_dir <> "/transfer/exports"
  def imports_dir(), do: @priv_dir <> "/transfer/imports"
  def scripts_dir(), do: @priv_dir <> "/extras/scripts"
  def storage_dir(), do: @priv_dir <> "/storage"
end
