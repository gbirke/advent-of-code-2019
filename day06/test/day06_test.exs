defmodule Day06Test do
  use ExUnit.Case
  doctest Day06

  test "build inverted map of orbits" do
    assert Day06.build_orbit_map(["a)b", "b)c", "c)d", "c)e", "b)f"]) == %{
             b: :a,
             c: :b,
             d: :c,
             e: :c,
             f: :b
           }
  end

  test "build orbit tree" do
    assert Day06.build_orbit_tree(%{
             b: :a,
             c: :b,
             d: :c,
             e: :c,
             f: :b
           }) == %{
             a: [:b],
             b: [:c, :f],
             c: [:d, :e],
             d: [],
             e: [],
             f: []
           }
  end

  test "get orbit count" do
    assert Day06.orbit_count(
             %{
               a: [:b],
               b: [:c, :f],
               c: [:d, :e],
               d: [],
               e: [],
               f: []
             },
             :a
           ) == %{a: 0, b: 1, c: 2, d: 3, e: 3, f: 2}
  end

  test "get orbit path" do
    assert Day06.orbit_path(
             %{
               b: :a,
               c: :b,
               d: :c,
               e: :c,
               f: :b
             },
             :e,
             :a
           ) == [:a, :b, :c, :e]

    assert Day06.orbit_path(%{b: :a}, :b, :x) == []
    assert Day06.orbit_path(%{b: :a}, :x, :a) == []
  end

  test "find_common_ancestor" do
    assert Day06.common_ancestor([:a, :b, :c, :d, :e], [:a, :b, :c, :f, :g, :h, :i]) == :c
    assert Day06.common_ancestor([:a, :b], [:c, :f, :g, :h, :i]) == nil
  end
end
