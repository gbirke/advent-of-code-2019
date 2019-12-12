input_planets = [
  [-6, 2, -9,0,0,0],
  [12, -14, -4,0,0,0],
  [9, 5, -6,0,0,0],
  [-1, -4, 9,0,0,0],
]

IO.puts "Total energy after 1000 rotations"
IO.puts Day12.total_energy(Day12.time_steps( input_planets, 1000))
