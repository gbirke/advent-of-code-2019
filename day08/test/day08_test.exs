defmodule Day08Test do
  use ExUnit.Case
  doctest Day08

  test "converts digit string to number list" do
    assert Day08.digit_string_to_number("1234567890") == [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
  end

  test "get layers from string list" do
    assert Day08.layers([1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2], 3, 2) == [
             [1, 2, 3, 4, 5, 6],
             [7, 8, 9, 0, 1, 2]
           ]

    assert Day08.layers([1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2], 2, 2) == [
             [1, 2, 3, 4],
             [5, 6, 7, 8],
             [9, 0, 1, 2]
           ]
  end

  test "get layer with fewest 0" do
    assert Day08.fewest_zeroes([
             [1, 0, 3, 4],
             [5, 0, 0, 8],
             [9, 0, 1, 2],
             [1, 4, 3, 4],
             [5, 6, 7, 8],
             [5, 6, 0, 8],
             [0, 0, 0, 0]
           ]) == [1, 4, 3, 4]
  end

  test "one digit and two digit count product" do
    assert Day08.digit_product([1, 2, 2, 2, 1, 1]) == 9
    assert Day08.digit_product([1, 2, 2, 1, 1, 1]) == 8
    assert Day08.digit_product([1, 2, 3, 4, 5, 6]) == 1
    assert Day08.digit_product([1, 1, 1, 1, 1, 1]) == 0
    assert Day08.digit_product([2, 2, 2, 2, 2, 2]) == 0
  end

  test "determine pixel color from layer pixels" do
    assert Day08.pixel_color([1,2,0,1]) == 1
    assert Day08.pixel_color([2,0,1,1]) == 0
    assert Day08.pixel_color([2,2,2,2]) == 2
    assert Day08.pixel_color([2,2,2,1]) == 1
    assert Day08.pixel_color([2,2,2,0]) == 0
  end

  test "map layers to final image" do
    assert Day08.combine_layers([
      [0,2,2,2],
      [1,1,2,2],
      [2,2,1,2],
      [0,0,0,0]]) == [0,1,1,0]
  end

  test "pixels to image" do
    assert Day08.pixels_to_image([0,1,1,0,2,1], 2 ) == "█ \n █\n. "
  end
end
