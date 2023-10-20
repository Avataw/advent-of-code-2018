defmodule FuelCell do
  defstruct rack_id: nil, power: nil

  def hundreds_digit(n) when n < 100, do: 0

  def hundreds_digit(n), do: rem(div(n, 100), 10)

  def new(x, y, serial_number) do
    rack_id = x + 10
    power = rack_id * y
    power = power + serial_number
    power = power * rack_id
    power = hundreds_digit(power)
    power = power - 5

    %FuelCell{rack_id: rack_id, power: power}
  end
end

defmodule Day11 do
  def get_power_level(cells, position) do
    sum =
      Position.get_surrounding(position)
      |> Enum.map(fn p ->
        if Map.has_key?(cells, p) do
          Map.get(cells, p).power
        else
          0
        end
      end)
      |> Enum.sum()

    {position, sum}
  end

  def solve_a(serial_number) do
    cells =
      Enum.reduce(1..300, %{}, fn x, acc ->
        Enum.reduce(1..300, acc, fn y, acc2 ->
          Map.put(acc2, %Position{x: x, y: y}, FuelCell.new(x, y, serial_number))
        end)
      end)

    cells
    |> Map.keys()
    |> Enum.map(fn p -> get_power_level(cells, p) end)
    |> Enum.max_by(fn {_, sum} -> sum end)
    |> elem(0)
    |> Position.upLeft()
  end

  # 21,15
  #  25,24
  # 298, y: 300
  # 12,37

  def solve_b do
    1
  end
end
