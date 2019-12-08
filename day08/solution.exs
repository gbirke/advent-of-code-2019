{:ok, pixelstr} = File.read("input.txt")

layers = Day08.digit_string_to_number(pixelstr) |> 
         Day08.layers( 25, 6)

IO.puts "Solution for first part Day 08:"
IO.puts Day08.fewest_zeroes(layers) |>
  Day08.digit_product


IO.puts "Solution for second part Day 08:"
IO.puts Day08.combine_layers(layers) |>
  Day08.pixels_to_image(25)
