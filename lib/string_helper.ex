defmodule StringHelper do
  @doc """

  Returns a map of every character and it's occurence in the string

  ## Examples
    iex> StringHelper.count_letters("abbccc")
    %{"a" => 1, "b" => 2, "c" => 3}

  """
  def count_letters(string) do
    string
    |> String.graphemes()
    |> Enum.reduce(Map.new(), fn char, occs ->
      Map.update(occs, char, 1, &(&1 + 1))
    end)
  end


end
