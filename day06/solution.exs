{:ok, orbitstr} = File.read("input.txt")

orbit_map = Day06.build_orbit_map( String.split(orbitstr, "\n"))

counts = Day06.build_orbit_tree(orbit_map) |>
Day06.orbit_count( :COM )

orbit_sum = IO.puts Enum.sum(Map.values(counts))

IO.puts "Number of orbits: #{orbit_sum}"

you_path = Day06.orbit_path(orbit_map, :YOU, :COM )
san_path = Day06.orbit_path(orbit_map, :SAN, :COM )

common_planet = Day06.common_ancestor(you_path, san_path )

IO.puts "Common planet: #{common_planet}"
distance_from_com = Map.get(counts, common_planet)

IO.puts "Distance from COM: #{distance_from_com}"

path_length = Map.get(counts, :YOU) + Map.get(counts, :SAN) - ( 2 * distance_from_com) - 2 # -2 to subtract the orbits from YOU and SAN 

IO.puts "Path length: #{path_length}"
