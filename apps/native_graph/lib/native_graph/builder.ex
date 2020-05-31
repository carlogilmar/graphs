defmodule NativeGraph.Builder do
	require Integer

	def random_graph(limit) do # start
		s=1
		# end
		e = limit
		g = Graph.new()
		results =
			for(n <- s..e, m <- (n + 1)..e, do: _evaluate(n, m))
			|> Enum.reject(&is_nil/1)

		results
		|> Enum.reduce(
			g,
			fn result, g ->
				[rs, re] = result
				g
				|> Graph.add_edge(rs, re)
			end
		)
	end

	defp _evaluate(n, m) do
		number = Kernel.trunc(System.os_time() / 1000)
		case Integer.is_even(number) do
			true -> [n, m]
			false -> nil
		end
	end

end
