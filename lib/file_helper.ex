defmodule FileHelper do
  @spec read_file(integer()) :: Stream.t(String.t())
  def read_file(day), do: File.stream!("./inputs/#{day}.txt")

  def read_as_lines(day) do
    read_file(day)
    |> Stream.map(&String.trim/1)
  end
end
