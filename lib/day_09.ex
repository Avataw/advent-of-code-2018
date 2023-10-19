defmodule LinkedListItem do
  defstruct value: nil, previous_index: nil, next_index: nil
end

defmodule LinkedList do
  defstruct items: %{}, current: nil, current_id: nil

  def new(value) do
    current_id = 0

    %LinkedList{
      items: %{
        current_id => %LinkedListItem{
          value: value,
          previous_index: current_id,
          next_index: current_id
        }
      },
      current: current_id,
      current_id: current_id + 1
    }
  end

  def add_right_by_two(%LinkedList{items: items, current: current, current_id: current_id}, value) do
    target_index = Map.get(items, current).next_index

    previous = Map.get(items, target_index)

    to_add = %LinkedListItem{
      value: value,
      previous_index: target_index,
      next_index: previous.next_index
    }

    to_add_index = current_id

    items =
      Map.put(items, to_add_index, to_add)
      |> Map.update!(target_index, fn item ->
        %LinkedListItem{item | next_index: to_add_index}
      end)
      |> Map.update!(previous.next_index, fn item ->
        %LinkedListItem{item | previous_index: to_add_index}
      end)

    %LinkedList{items: items, current: to_add_index, current_id: current_id + 1}
  end

  def remove_left_by_seven(%LinkedList{items: items, current: current, current_id: current_id}) do
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
        %LinkedListItem{item | next_index: to_remove.next_index}
      end)
      |> Map.update!(to_remove.next_index, fn item ->
        %LinkedListItem{item | previous_index: to_remove.previous_index}
      end)

    {%LinkedList{items: items, current: to_remove.next_index, current_id: current_id},
     to_remove.value}
  end
end

defmodule Day09 do
  def parse(input) do
    player_count = input |> ParseHelper.get_before(" players") |> String.to_integer()
    turns = input |> ParseHelper.get_inbetween("worth ", " points") |> String.to_integer()

    {player_count, turns}
  end

  def solve_a do
    {player_count, turns} = FileHelper.read_as_word(9) |> parse()

    players =
      1..player_count
      |> Enum.map(fn id -> {id, 0} end)
      |> Enum.into(%{})

    1..player_count
    |> Stream.cycle()
    |> Enum.take(turns)
    |> Enum.with_index()
    |> Enum.reduce({LinkedList.new(0), players}, fn {player_id, marble}, {marbles, players} ->
      marble = marble + 1

      case rem(marble, 23) do
        0 ->
          {marbles, second_marble} = LinkedList.remove_left_by_seven(marbles)

          players =
            Map.update!(players, player_id, fn player_score ->
              player_score + marble + second_marble
            end)

          {marbles, players}

        _ ->
          {LinkedList.add_right_by_two(marbles, marble), players}
      end
    end)
    |> elem(1)
    |> Map.to_list()
    |> Enum.max_by(fn {_, score} -> score end)
    |> elem(1)
  end

  def solve_b do
    {player_count, turns} = FileHelper.read_as_word(9) |> parse()

    players =
      1..player_count
      |> Enum.map(fn id -> {id, 0} end)
      |> Enum.into(%{})

    1..player_count
    |> Stream.cycle()
    |> Enum.take(turns * 100)
    |> Enum.with_index()
    |> Enum.reduce({LinkedList.new(0), players}, fn {player_id, marble}, {marbles, players} ->
      marble = marble + 1

      case rem(marble, 23) do
        0 ->
          {marbles, second_marble} = LinkedList.remove_left_by_seven(marbles)

          players =
            Map.update!(players, player_id, fn player_score ->
              player_score + marble + second_marble
            end)

          {marbles, players}

        _ ->
          {LinkedList.add_right_by_two(marbles, marble), players}
      end
    end)
    |> elem(1)
    |> Map.to_list()
    |> Enum.max_by(fn {_, score} -> score end)
    |> elem(1)
  end
end
