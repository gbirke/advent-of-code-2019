{:ok, orbitstr} = File.read("input.txt")

counts = Day06.build_orbit_map( String.split(orbitstr, "\n")) |>
Day06.orbit_count( :COM )

IO.puts "Number of orbits: "
IO.puts Enum.sum(Map.values(counts))
