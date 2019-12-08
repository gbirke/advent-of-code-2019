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

  def pixel_color(pixels) do
    no_transparent = Enum.filter(pixels, fn p -> p != 2 end)

    case no_transparent do
      [] -> 2
      _ -> hd(no_transparent)
    end
  end

  def combine_layers(layers) do
    combined_layers = Enum.map(Enum.zip(layers), &Tuple.to_list/1)
    Enum.map(combined_layers, &Day08.pixel_color/1)
  end

  def char_for_color(c) do
    case c do
      # black
      0 -> "█"
      # white
      1 -> " "
      # transparent
      2 -> "."
      # Should never happen
      _ -> "E"
    end
  end

  def image_line(pixels) do
    Enum.join(Enum.map(pixels, &Day08.char_for_color/1), "")
  end

  def pixels_to_image(pixels, width) do
    lines = Enum.chunk_every(pixels, width)
    Enum.join(Enum.map(lines, &Day08.image_line/1), "\n")
  end
end
