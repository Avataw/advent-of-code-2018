defmodule Position do
  defstruct x: 0, y: 0

  def new([x, y]), do: %Position{x: x, y: y}

  def up(%Position{x: x, y: y}), do: %Position{x: x, y: y - 1}

  def right(%Position{x: x, y: y}), do: %Position{x: x + 1, y: y}

  def down(%Position{x: x, y: y}), do: %Position{x: x, y: y + 1}

  def left(%Position{x: x, y: y}), do: %Position{x: x - 1, y: y}

  def upLeft(position), do: position |> up() |> left()

  def upRight(position), do: position |> up() |> right()

  def downLeft(position), do: position |> down() |> left()

  def downRight(position), do: position |> down() |> right()

  def get_surrounding(position) do
    [
      upLeft(position),
      up(position),
      upRight(position),
      left(position),
      position,
      right(position),
      downLeft(position),
      down(position),
      downRight(position)
    ]
  end
end
