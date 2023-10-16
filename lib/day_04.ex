defmodule Day04 do
  @spec parse_date_time(String.t()) :: DateTime.t()
  def parse_date_time(input) do
    input
    |> ParseHelper.get_inbetween("[", "]")
    |> String.split(" ")
    |> (fn [date, time] -> "#{date}T#{time}:00Z" end).()
    |> DateTime.from_iso8601()
    |> elem(1)
  end

  @spec parse_time(String.t()) :: integer()
  def parse_time(input) do
    input
    |> ParseHelper.get_inbetween(":", "]")
    |> String.to_integer()
  end

  @spec parse_guard_id(String.t()) :: integer()
  def parse_guard_id(input) do
    input
    |> ParseHelper.get_inbetween("#", " ")
    |> String.to_integer()
  end

  @spec get_record_type(String.t()) :: :asleep | :awake | :guard
  def get_record_type(input) do
    cond do
      String.contains?(input, "Guard") -> :guard
      String.contains?(input, "asleep") -> :asleep
      String.contains?(input, "wakes") -> :awake
    end
  end

  def update_map(guards, last_guard, to_add) do
    Map.update(guards, last_guard, [], fn list -> list ++ to_add end)
  end

  @spec parse_records() :: map()
  def parse_records() do
    FileHelper.read_as_lines(4)
    |> Enum.sort_by(&parse_date_time(&1), &(DateTime.compare(&1, &2) == :lt))
    |> Enum.reduce({%{}, nil, nil}, fn input, acc ->
      {guards, last_guard, start} = acc

      case get_record_type(input) do
        :guard ->
          {guards, parse_guard_id(input), nil}

        :asleep when last_guard != nil ->
          to_add = [parse_time(input)]
          {update_map(guards, last_guard, to_add), last_guard, parse_time(input)}

        :awake when last_guard != nil and start != nil ->
          to_add = Enum.to_list(start..(parse_time(input) - 1))
          {update_map(guards, last_guard, to_add), last_guard, nil}
      end
    end)
    |> elem(0)
  end

  def solve_a do
    result =
      parse_records()
      |> Enum.sort_by(fn {_, values} -> length(values) end, :desc)
      |> hd

    minute =
      result
      |> elem(1)
      |> Enum.frequencies()
      |> Enum.max_by(fn {_, value} -> value end)
      |> elem(0)

    guardId = elem(result, 0)

    guardId * minute
  end

  def solve_b do
    {guard_id, {minute, _}} =
      parse_records()
      |> Enum.map(fn {key, value} ->
        {key, EnumHelper.max_frequency(value)}
      end)
      |> Enum.max_by(fn {_, {_, frequency}} -> frequency end)

    guard_id * minute
  end
end
