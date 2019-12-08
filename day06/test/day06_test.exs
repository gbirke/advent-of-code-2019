defmodule Day06Test do
  use ExUnit.Case
  doctest Day06

  test "add entry to orbit map" do
    assert Day06.add_to_orbit_map("a)b", %{}) == %{ a: [:b], b: [] }
    assert Day06.add_to_orbit_map("ab", %{}) == %{}
    assert Day06.add_to_orbit_map("", %{}) == %{}
  end

  test "build a map of orbits" do
    assert Day06.build_orbit_map(["a)b", "b)c", "c)d", "c)e", "b)f"]) == %{
      a: [:b],
      b: [:c, :f],
      c: [:d, :e],
      d: [],
      e: [],
      f: []
    }
  end

  test "get orbit count" do
    assert Day06.orbit_count(%{
      a: [:b],
      b: [:c, :f],
      c: [:d, :e],
      d: [],
      e: [],
      f: []
    }, :a) == %{a: 0, b: 1, c: 2, d: 3, e: 3, f: 2 }
  end
end
