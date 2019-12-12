defmodule Day12 do
  @moduledoc """
  Documentation for Day12.
  """

  def gravity( coordinate1, coordinate2) do
    Enum.map( Enum.zip(coordinate1, coordinate2 ), fn {c1, c2} -> 
      if c1 == c2 
        do 0 
      else if c1 < c2 
        do 
        1 
      else 
      -1 
      end 
      end end )
  end

  def velocity(planet, other_planets) do
    coordinates = Enum.take( planet, 3)
    gravities = Enum.map( other_planets, fn p -> gravity( coordinates, Enum.take(p, 3)) end )
    coordinates ++ Enum.reduce( gravities, Enum.take(planet, -3), fn [x,y,z], [ax,ay,az] -> [ax+x,ay+y,az+z] end )
  end

  def velocity_planets(planets, start_list \\ 0) do
    if start_list >= length(planets) do
      planets
    else
      updated_planet = velocity( Enum.at(planets, start_list), List.delete_at(planets, start_list))
      velocity_planets(List.replace_at(planets, start_list, updated_planet ), start_list + 1 )
    end
  end

  def update_position([x,y,z,vx,vy,vz]) do 
    [x+vx, y+vy, z+vz, vx, vy, vz]
  end

  def time_step(planets) do
    Enum.map( velocity_planets( planets ), &Day12.update_position/1 )
  end

  def time_steps(planets, num_steps) do
    if (num_steps <= 0) do
      planets
    else
      time_steps(time_step(planets), num_steps -  1)
    end
  end

  def total_energy_for_planet(planet) do
    abs_planet = Enum.map( planet, &Kernel.abs/1 )
    Enum.sum( Enum.take(abs_planet, 3) ) * Enum.sum( Enum.take(abs_planet, -3) )
  end

  def total_energy(planets) do 
    Enum.sum( Enum.map(planets, &Day12.total_energy_for_planet/1 ))
  end

end
