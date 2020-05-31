defmodule Format do
	@graph_images_dir GraphCommons.storage_dir() <> "/native/graphs/images/"
	@binary_dir "/usr/local/bin"
	@type layout :: :dot | :neato | :twopi | :circo | :fdp | :sfdp | :patchwork | :osage

	@spec to_png(GraphCommons.Graph.t(), layout) :: String.t()
	def to_png(%GraphCommons.Graph{} = graph, layout \\ :dot) do
		layout_cmd = Path.join(@binary_dir, Atom.to_string(layout)) dot_file = graph.path
		png_file = @graph_images_dir <> Path.basename(dot_file, ".dot") <> ".png"
		with {_, 0} <-
			System.cmd(layout_cmd, ["-T", "png", dot_file, "-o", png_file])
		do
			{:ok, Path.basename(png_file)} end
	end

end
