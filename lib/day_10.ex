defmodule Star do
  defstruct position: %Position{}, velocity: %Position{}

  def new([pos, vel]) do
    %Star{position: Position.new(pos), velocity: Position.new(vel)}
  end

  def move_by(%Star{position: %Position{x: x, y: y}, velocity: %Position{x: by_x, y: by_y}}, n) do
    %Position{x: x + by_x * n, y: y + by_y * n}
  end
end

defmodule Day10 do
  def get_numbers(input) do
    input
    |> ParseHelper.get_inbetween("<", ">")
    |> String.trim()
    |> String.split(",")
    |> Enum.map(fn n -> n |> String.trim() |> String.to_integer() end)
  end

  def parse_star(input) do
    pos = input |> ParseHelper.get_before("velocity") |> get_numbers()
    vel = input |> ParseHelper.get_after("velocity") |> get_numbers()

    Star.new([pos, vel])
  end

  def get_message_at(stars, seconds) do
    positions = Enum.map(stars, fn star -> Star.move_by(star, seconds) end)

    {min_x, max_x} = Enum.min_max_by(positions, fn %Position{x: x, y: _} -> x end)
    {min_y, max_y} = Enum.min_max_by(positions, fn %Position{x: _, y: y} -> y end)

    Enum.map(min_y.y..max_y.y, fn y ->
      Enum.map(min_x.x..max_x.x, fn x ->
        if Enum.member?(positions, Position.new([x, y])) do
          "#"
        else
          "."
        end
      end)
      |> Enum.join("")
    end)
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end

  def find_message_time(stars) do
    0..20000
    |> Enum.min_by(fn n ->
      positions = Enum.map(stars, fn star -> Star.move_by(star, n) end)

      {min_x, max_x} = Enum.min_max_by(positions, fn %Position{x: x, y: _} -> x end)
      {min_y, max_y} = Enum.min_max_by(positions, fn %Position{x: _, y: y} -> y end)

      max_x.x - min_x.x + max_y.y - min_y.y
    end)
  end

  def solve_a do
    stars =
      FileHelper.read_as_lines(10)
      |> Enum.map(&parse_star/1)

    message_time = find_message_time(stars)

    get_message_at(stars, message_time)
  end

  def solve_b do
    FileHelper.read_as_lines(10)
    |> Enum.map(&parse_star/1)
    |> find_message_time()
  end
end
