defmodule Player do
  defstruct score: 0

  def add(%Player{score: score}, amount) do
    %Player{score: score + amount}
  end
end

defmodule Day09 do
  def insert_between(list, element, index) do
    {pre, post} = Enum.split(list, index)
    pre ++ [element] ++ post
  end

  def place_marble(marbles, element) do
    current_marble = Enum.find_index(marbles, fn m -> elem(m, 1) == :current end)

    element = {element, :current}
    marbles = marbles |> Enum.map(fn m -> {elem(m, 0), nil} end)

    length = length(marbles)

    cond do
      current_marble == length -> insert_between(marbles, element, 2)
      current_marble == length - 1 -> insert_between(marbles, element, 1)
      true -> insert_between(marbles, element, current_marble + 2)
    end
  end

  def score_marble(marbles) do
    current_marble = Enum.find_index(marbles, fn m -> elem(m, 1) == :current end)

    length = length(marbles)

    adjusted_index = rem(current_marble - 7 + length, length)
    score = Enum.at(marbles, adjusted_index)

    marbles = List.delete(marbles, score)
    new_current = Enum.at(marbles, adjusted_index)

    marbles =
      Enum.map(marbles, fn marble ->
        if marble == new_current do
          {elem(marble, 0), :current}
        else
          {elem(marble, 0), nil}
        end
      end)

    {marbles, score}
  end

  def parse(input) do
    player_count = input |> ParseHelper.get_before(" players") |> String.to_integer()
    turns = input |> ParseHelper.get_inbetween("worth ", " points") |> String.to_integer()

    {player_count, turns}
  end

  def solve_a do
    {player_count, turns} = FileHelper.read_as_word(9) |> parse()

    players =
      1..player_count
      |> Enum.map(fn id -> {id, %Player{}} end)
      |> Enum.into(%{})

    winner =
      1..player_count
      |> Stream.cycle()
      |> Enum.take(turns)
      |> Enum.with_index()
      |> Enum.reduce({[{0, :current}], players}, fn {player_id, marble}, {marbles, players} ->
        marble = marble + 1

        if rem(marble, 23) == 0 do
          {marbles, {score, _}} = score_marble(marbles)

          players =
            Map.update!(players, player_id, fn player -> Player.add(player, score + marble) end)

          {marbles, players}
        else
          {place_marble(marbles, marble), players}
        end
      end)
      |> elem(1)
      |> Map.to_list()
      |> Enum.max_by(fn {_, score} -> score end)
      |> elem(1)

    winner.score
  end

  def solve_b do
    {player_count, turns} = FileHelper.read_as_word(9) |> parse()

    players =
      1..player_count
      |> Enum.map(fn id -> {id, %Player{}} end)
      |> Enum.into(%{})

    winner =
      1..player_count
      |> Stream.cycle()
      |> Enum.take(turns * 100)
      |> Enum.with_index()
      |> Enum.reduce({[{0, :current}], players}, fn {player_id, marble}, {marbles, players} ->
        marble = marble + 1

        if rem(marble, 23) == 0 do
          {marbles, {score, _}} = score_marble(marbles)

          players =
            Map.update!(players, player_id, fn player -> Player.add(player, score + marble) end)

          {marbles, players}
        else
          {place_marble(marbles, marble), players}
        end
      end)
      |> elem(1)
      |> Map.to_list()
      |> Enum.max_by(fn {_, score} -> score end)
      |> elem(1)

    winner.score
  end
end
