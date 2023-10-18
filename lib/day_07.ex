defmodule Day07 do
  def parse_instruction(string) do
    before = ParseHelper.get_inbetween(string, "Step ", " must ")
    step = ParseHelper.get_inbetween(string, "step ", " can")

    {before, step}
  end

  def remove_step({step, requirements}, next_step) do
    {step, Enum.filter(requirements, &(&1 != next_step))}
  end

  def remove_instruction(instructions, step) do
    instructions
    |> Map.delete(step)
    |> Map.new(&remove_step(&1, step))
  end

  def get_instructions do
    FileHelper.read_as_lines(7)
    |> Enum.map(&parse_instruction/1)
    |> Enum.reduce(%{}, fn {before, step}, acc ->
      acc
      |> Map.update(step, [before], fn reqs -> reqs ++ [before] end)
      |> Map.put_new(before, [])
    end)
  end

  def get_currently_worked_steps(workers) do
    workers
    |> Map.values()
    |> Enum.map(fn {step, _, _} -> step end)
  end

  def get_next_step(instructions, currently_worked_steps) do
    instructions
    |> Map.to_list()
    |> Enum.find(fn {key, value} ->
      !Enum.member?(currently_worked_steps, key) && Enum.empty?(value)
    end)
  end

  def get_duration(letter) do
    duration = String.to_charlist(letter) |> hd()
    duration - 5
  end

  def work(workers, worker) do
    {id, {step, seconds, _}} = worker

    if seconds > 1 do
      Map.update!(workers, id, fn _ -> {step, seconds - 1, :working} end)
    else
      Map.update!(workers, id, fn _ -> {step, 0, :done} end)
    end
  end

  def sort_by_state(workers) do
    workers
    |> Map.to_list()
    |> Enum.sort_by(fn {_, {_, _, state}} ->
      case state do
        :done -> 0
        :working -> 1
        :ready -> 2
      end
    end)
  end

  def get_next_instructions(next_instructions, next_workers, worker, next_result, duration_method) do
    {id, _} = worker

    next_step = get_next_step(next_instructions, get_currently_worked_steps(next_workers))

    if next_step != nil do
      {next_step, _} = next_step

      {next_instructions,
       Map.update!(next_workers, id, fn _ ->
         {next_step, duration_method.(next_step), :working}
       end), next_result}
    else
      {next_instructions, Map.update!(next_workers, id, fn _ -> {nil, nil, :ready} end),
       next_result}
    end
  end

  def solve(instructions, workers, result, seconds, duration_method) do
    {next_instructions, next_workers, next_result} =
      workers
      |> sort_by_state()
      |> Enum.reduce({instructions, workers, result}, fn worker, acc ->
        {cur_instructions, next_workers, next_result} = acc
        {_, {step, _, state}} = worker

        case state do
          :working ->
            {cur_instructions, work(next_workers, worker), next_result}

          :done ->
            remove_instruction(cur_instructions, step)
            |> get_next_instructions(next_workers, worker, next_result <> step, duration_method)

          :ready ->
            cur_instructions
            |> get_next_instructions(next_workers, worker, next_result, duration_method)
        end
      end)

    if Kernel.map_size(next_instructions) == 0 do
      {next_result, seconds}
    else
      solve(next_instructions, next_workers, next_result, seconds + 1, duration_method)
    end
  end

  def workers(amount) do
    1..amount
    |> Enum.map(&{&1, {nil, nil, :ready}})
    |> Enum.into(%{})
  end

  def solve_a do
    get_instructions()
    |> solve(workers(1), "", 0, fn _ -> 1 end)
    |> elem(0)
  end

  def solve_b do
    get_instructions()
    |> solve(workers(5), "", 0, &get_duration/1)
    |> elem(1)
  end
end
