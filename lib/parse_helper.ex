defmodule ParseHelper do

  @spec try_parse(String.t()) :: integer()
  def try_parse(str) do
    case Integer.parse(str) do
      {num, _} -> num
      :error -> 0
    end
  end

end
