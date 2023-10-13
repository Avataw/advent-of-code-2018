defmodule StringHelperTest do
  use ExUnit.Case

  test "get occurences of letters" do
    occs = StringHelper.count_letters("abcbcc")
    assert occs == %{"a" => 1, "b" => 2, "c" => 3}
  end
end
