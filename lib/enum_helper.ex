defmodule EnumHelper do
  @doc """

  Count's all the differences of two lists.
  Order matters!

  ## Examples
    iex> EnumHelper.count_diffs([1, 2], [1, 2])
    0

    iex> EnumHelper.count_diffs(['a', 'b'], ['a'])
    1

    iex> EnumHelper.count_diffs([1, 2], [2, 1])
    2
  """
  def count_diffs(list1, list2) do
    diffs =
      list1
      |> Enum.zip(list2)
      |> Enum.count(fn {a, b} ->
        a != b
      end)

    diffs + abs(length(list1) - length(list2))
  end

  @doc """

  Returns the list that you get by taking only every
  element that is in both lists at the same position.

  ## Examples
    iex> EnumHelper.merge_overlap([1,2,3], [1,4,3])
    [1,3]

  """
  def merge_overlap(first_string, second_string) do
    Enum.zip(first_string, second_string)
    |> Enum.filter(fn {first_string, second_string} -> first_string == second_string end)
    |> Enum.map(fn {first, _} -> first end)
  end
end
