defmodule FileHelper do
  @spec read_file(integer()) :: Stream.t(String.t())
  def read_file(day), do: File.stream!("./inputs/#{day}.txt")
end
