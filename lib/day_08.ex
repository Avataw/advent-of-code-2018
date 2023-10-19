defmodule Tree do
  defstruct children: [], metadata: []

  def parse([child_count, metadata_count | rest]) do
    {children, rest_after_children} = parse_children(child_count, rest)
    {metadata, remaining} = Enum.split(rest_after_children, metadata_count)

    {%Tree{children: children, metadata: metadata}, remaining}
  end

  def sum(%Tree{metadata: metadata, children: children}) do
    metadata_sum = Enum.sum(metadata)
    children_sum = Enum.map(children, &sum/1) |> Enum.sum()
    metadata_sum + children_sum
  end

  def value(%Tree{metadata: metadata, children: []}), do: Enum.sum(metadata)

  def value(%Tree{metadata: metadata, children: children}) do
    metadata
    |> Enum.map(fn index ->
      child = Enum.at(children, index - 1)
      if child == nil, [{:do, 0}, {:else, value(child)}]
    end)
    |> Enum.sum()
  end

  defp parse_children(0, data), do: {[], data}

  defp parse_children(count, data) when count > 0 do
    {child, rest_after_child} = parse(data)
    {other_children, remaining} = parse_children(count - 1, rest_after_child)

    {[child | other_children], remaining}
  end
end

defmodule Day08 do
  def solve_a do
    FileHelper.read_as_word(8)
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> Tree.parse()
    |> elem(0)
    |> Tree.sum()
  end

  def solve_b do
    FileHelper.read_as_word(8)
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> Tree.parse()
    |> elem(0)
    |> Tree.value()
  end
end
