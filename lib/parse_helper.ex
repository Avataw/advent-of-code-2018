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

  @doc """
  Get's everything before a string.

  ## Examples
    iex> ParseHelper.get_before("a+bc", "+")
    "a"
  """
  def get_before(search_input, char) do
    char = Regex.escape(char)

    [[_, result]] = Regex.scan(~r/(.+)#{char}/, search_input)
    result
  end

  @doc """
  Get's everything after a string.

  ## Examples
    iex> ParseHelper.get_after("a+bc", "+")
    "bc"
  """
  def get_after(search_input, char) do
    char = Regex.escape(char)

    [[_, result]] = Regex.scan(~r/#{char}(.+)/, search_input)
    result
  end

  @doc """
  Get's everything inbetween two strings.

  ## Examples
    iex> ParseHelper.get_inbetween("a+b*c", "+", "*")
    "b"
  """
  def get_inbetween(search_input, first_char, second_char) do
    first_char = Regex.escape(first_char)
    second_char = Regex.escape(second_char)

    [[_, result]] = Regex.scan(~r/#{first_char}(.+?)#{second_char}/, search_input)
    result
  end
end
