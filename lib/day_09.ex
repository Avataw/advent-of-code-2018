defmodule LinkedMapItem do
  defstruct value: nil, previous_index: nil, next_index: nil
end

defmodule LinkedMap do
  defstruct items: %{}, current: nil, unique_id: nil

  def new(value) do
    unique_id = 0

    %LinkedMap{
      items: %{
        unique_id => %LinkedMapItem{
          value: value,
          previous_index: unique_id,
          next_index: unique_id
        }
      },
      current: unique_id,
      unique_id: unique_id + 1
    }
  end

  def add_right_by_two(%LinkedMap{items: items, current: current, unique_id: unique_id}, value) do
    target_index = Map.get(items, current).next_index

    previous = Map.get(items, target_index)

    to_add = %LinkedMapItem{
      value: value,
      previous_index: target_index,
      next_index: previous.next_index
    }

    to_add_index = unique_id

    items =
      Map.put(items, to_add_index, to_add)
      |> Map.update!(target_index, fn item ->
        %LinkedMapItem{item | next_index: to_add_index}
      end)
      |> Map.update!(previous.next_index, fn item ->
        %LinkedMapItem{item | previous_index: to_add_index}
      end)

    %LinkedMap{items: items, current: to_add_index, unique_id: unique_id + 1}
  end

  def remove_left_by_seven(%LinkedMap{items: items, current: current, unique_id: unique_id}) do
    target_index =
      1..6
      |> Enum.reduce(Map.get(items, current), fn _, item ->
        Map.get(items, item.previous_index)
      end)
      |> Map.get(:previous_index)

    to_remove = Map.get(items, target_index)

    items =
      items
      |> Map.update!(to_remove.previous_index, fn item ->
        %LinkedMapItem{item | next_index: to_remove.next_index}
      end)
      |> Map.update!(to_remove.next_index, fn item ->
        %LinkedMapItem{item | previous_index: to_remove.previous_index}
      end)

    {%LinkedMap{items: items, current: to_remove.next_index, unique_id: unique_id},
     to_remove.value}
  end
end

defmodule Day09 do
  def parse(input) do
    player_count = input |> ParseHelper.get_before(" players") |> String.to_integer()
    turns = input |> ParseHelper.get_inbetween("worth ", " points") |> String.to_integer()

    {player_count, turns}
  end

  def initialize_players(player_count) do
    1..player_count
    |> Enum.map(fn id -> {id, 0} end)
    |> Enum.into(%{})
  end

  def get_player_turns(player_count, turns) do
    1..player_count
    |> Stream.cycle()
    |> Enum.take(turns)
    |> Enum.with_index()
  end

  def play_game(player_turns, players) do
    Enum.reduce(player_turns, {LinkedMap.new(0), players}, fn {player_id, marble},
                                                              {marbles, players} ->
      marble = marble + 1

      case rem(marble, 23) do
        0 ->
          {marbles, second_marble} = LinkedMap.remove_left_by_seven(marbles)

          players =
            Map.update!(players, player_id, fn player_score ->
              player_score + marble + second_marble
            end)

          {marbles, players}

        _ ->
          {LinkedMap.add_right_by_two(marbles, marble), players}
      end
    end)
  end

  def highest_score(game_state) do
    game_state
    |> elem(1)
    |> Enum.max_by(fn {_, score} -> score end)
    |> elem(1)
  end

  def solve_a do
    {player_count, turns} = FileHelper.read_as_word(9) |> parse()

    players = initialize_players(player_count)

    get_player_turns(player_count, turns)
    |> play_game(players)
    |> highest_score()
  end

  def solve_b do
    {player_count, turns} = FileHelper.read_as_word(9) |> parse()

    players = initialize_players(player_count)

    get_player_turns(player_count, turns * 100)
    |> play_game(players)
    |> highest_score()
  end
end
