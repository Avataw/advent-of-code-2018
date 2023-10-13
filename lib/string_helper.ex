defmodule StringHelper do
  def count_letters(letters) do
    letters
    |> String.graphemes()
    |> Enum.reduce(Map.new(), fn c, occs ->
      Map.update(occs, c, 1, &(&1 + 1))
    end)
  end
end
