defmodule Day08 do
  @moduledoc """
  Documentation for Day08.
  """

  def digit_string_to_number(s) do
    Enum.filter(
      Enum.map(to_charlist(s), fn c -> c - 48 end),
      fn n -> n >= 0 && n < 10 end
    )
  end

  def layers(num_list, width, height) do
    Enum.chunk_every(num_list, width * height)
  end

  defp count_digits_fn(digit) do
    fn x -> x == digit end
  end

  def count_digits_in_layer(digit, layer) do
    Enum.count(layer, count_digits_fn(digit))
  end

  def fewest_zeroes(layers) do
    Enum.min_by(layers, fn l -> count_digits_in_layer(0, l) end)
  end

  def digit_product(layer) do
    count_digits_in_layer(1, layer) * count_digits_in_layer(2, layer)
  end
end
