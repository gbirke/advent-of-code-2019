defmodule Day06 do
  @moduledoc """
  Documentation for Day06.
  """

  def add_to_orbit_map( orbit, orbit_map ) do
    if String.contains?( orbit, ")" ) do
      [o1, o2] = Enum.map( String.split(orbit, ")"), &String.to_atom/1 )
      orbit_list = Map.get( orbit_map, o1, [] )
      Map.put(orbit_map, o1, orbit_list ++ [o2]) |>
      Map.put_new( o2, [] )
    else
      orbit_map
    end
  end

  def build_orbit_map(orbit_list) do
    Enum.reduce( orbit_list, %{}, &Day06.add_to_orbit_map/2 )
  end

  def orbit_count(orbit_map, entry, count_map \\ %{}, depth \\ 0 ) do
    count_map = Map.put(count_map, entry, depth)
    Enum.reduce( 
      Map.get(orbit_map, entry, []), 
      count_map, 
      fn orbit, acc_count -> orbit_count(orbit_map, orbit, acc_count, depth + 1) end
    )
  end
end
