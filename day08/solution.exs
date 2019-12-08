{:ok, pixelstr} = File.read("input.txt")

IO.puts Day08.digit_string_to_number(pixelstr) |> 
  Day08.layers( 25, 6) |>
  Day08.fewest_zeroes |>
  Day08.digit_product

