defmodule Day03 do
  @type position :: {integer(), integer()}
  @type dimensions :: {integer(), integer()}
  @type grid :: %{position() => integer()}

  @spec get_coords(String.t()) :: position()
  def get_coords(input) do
    input
    |> ParseHelper.get_inbetween("@ ", ":")
    |> StringHelper.split_to_int_tuple(",")
  end

  @spec get_dimensions(String.t()) :: dimensions()
  def get_dimensions(input) do
    input
    |> ParseHelper.get_after(": ")
    |> StringHelper.split_to_int_tuple("x")
  end

  @spec squares_from_claims(Enum.t(String.t())) :: grid()
  def squares_from_claims(input) do
    input
    |> Enum.reduce(%{}, fn line, acc ->
      {start_x, start_y} = get_coords(line)
      {width, height} = get_dimensions(line)

      Enum.reduce(start_x..(start_x + width - 1), acc, fn x, acc1 ->
        Enum.reduce(start_y..(start_y + height - 1), acc1, fn y, acc2 ->
          Map.update(acc2, {x, y}, 1, &(&1 + 1))
        end)
      end)
    end)
  end

  @spec squares_within_multiple_claims(grid()) :: non_neg_integer()
  def squares_within_multiple_claims(grid) do
    grid
    |> Map.values()
    |> Enum.count(&(&1 > 1))
  end

  def solve_a do
    FileHelper.read_as_lines(3)
    |> squares_from_claims()
    |> squares_within_multiple_claims()
  end

  @spec find_claim_without_overlap(Enum.t(String.t()), grid()) :: String.t()
  def find_claim_without_overlap(input, grid) do
    input
    |> Enum.find(fn line ->
      {start_x, start_y} = get_coords(line)
      {width, height} = get_dimensions(line)

      Enum.all?(start_x..(start_x + width - 1), fn x ->
        Enum.all?(start_y..(start_y + height - 1), fn y ->
          Map.get(grid, {x, y}) == 1
        end)
      end)
    end)
  end

  @spec get_claim_id(String.t()) :: integer()
  def get_claim_id(input) do
    input
    |> ParseHelper.get_inbetween("#", " @")
    |> String.to_integer()
  end

  def solve_b do
    grid =
      FileHelper.read_as_lines(3)
      |> squares_from_claims()

    FileHelper.read_as_lines(3)
    |> find_claim_without_overlap(grid)
    |> get_claim_id()
  end
end
