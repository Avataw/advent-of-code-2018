defmodule ParseHelper do
  @doc """

  Tries to parse a string to an integer. Returns 0 if it can't

  ## Examples
    iex> ParseHelper.try_parse("1")
    1

    iex> ParseHelper.try_parse("-1")
    -1

    iex> ParseHelper.try_parse("_")
    0
  """
  @spec try_parse(String.t()) :: integer()
  def try_parse(str) do
    case Integer.parse(str) do
      {num, _} -> num
      :error -> 0
    end
  end
end
