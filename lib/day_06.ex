defmodule Day06 do
  def parse_position(string) do
    [first, second] =
      string
      |> String.split(", ")
      |> Enum.map(&String.to_integer/1)

    {first, second}
  end

  def get_corners(points) do
    {{min_x, _}, {max_x, _}} = Enum.min_max_by(points, fn {x, _} -> x end)
    {{_, min_y}, {_, max_y}} = Enum.min_max_by(points, fn {_, y} -> y end)

    {{min_x, max_x}, {min_y, max_y}}
  end

  def distance({first_x, first_y}, {second_x, second_y}) do
    abs(first_x - second_x) + abs(first_y - second_y)
  end

  def get_closest_point(points, point) do
    [{first_id, first_distance}, {_, second_distance}] =
      points
      |> Enum.map(fn {position, id} -> {id, distance(position, point)} end)
      |> Enum.sort_by(fn {_, distance} -> distance end)
      |> Enum.take(2)

    if first_distance != second_distance do
      first_id
    else
      -1
    end
  end

  def solve_a do
    points =
      FileHelper.read_as_lines(6)
      |> Enum.map(&parse_position/1)

    {{min_x, max_x}, {min_y, max_y}} = get_corners(points)

    points = Enum.with_index(points)

    {areas, ignore} =
      Enum.reduce(min_x..max_x, {%{}, MapSet.new()}, fn x, {acc, ignore} ->
        Enum.reduce(min_y..max_y, {acc, ignore}, fn y, {acc_2, ignore_2} ->
          key = get_closest_point(points, {x, y})

          if x == min_x || x == max_x || y == min_y || y == max_y do
            {acc_2, MapSet.put(ignore, key)}
          else
            {Map.update(acc_2, key, 1, fn count -> count + 1 end), ignore_2}
          end
        end)
      end)

    Map.filter(areas, fn {key, _} -> !MapSet.member?(ignore, key) end)
    |> Map.values()
    |> Enum.max()
  end

  def solve_b do
    points =
      FileHelper.read_as_lines(6)
      |> Enum.map(&parse_position/1)

    {{min_x, max_x}, {min_y, max_y}} = get_corners(points)

    Enum.flat_map(min_x..max_x, fn x ->
      Enum.map(min_y..max_y, fn y ->
        points
        |> Enum.map(&distance(&1, {x, y}))
        |> Enum.sum()
      end)
    end)
    |> Enum.filter(fn distance_sum -> distance_sum < 10000 end)
    |> length()
  end
end
