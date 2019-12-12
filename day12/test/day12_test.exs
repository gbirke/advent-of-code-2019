defmodule Day12Test do
  use ExUnit.Case
  doctest Day12

  test "calculate gravity" do
    assert Day12.gravity( [-1, 0, 2], [2, 10, 7] ) == [1, 1, 1]
    assert Day12.gravity( [-1, 0, 2], [-2, -1, 1] ) == [-1, -1, -1]
    assert Day12.gravity( [-1, 0, 2], [-1, 5, -1] ) == [0, 1, -1]
  end

  test "calculate new velocity" do
    assert Day12.velocity([0,1,2,5,5,5], [[0,2,4,0,0,0],[-1,2,2,0,0,0]] ) == [0,1,2,4,7,6]
  end

  test "update velocities" do
    assert Day12.velocity_planets([
     [-1,  0,  2,  0,  0,  0],
     [2, -10, -7,  0,  0,  0],
     [4,  -8,  8,  0,  0,  0],
     [3,   5, -1,  0,  0,  0]]
    ) == [
      [ -1,  0,  2,  3, -1, -1],
      [ 2, -10, -7,   1,  3,  3],
      [ 4,  -8,  8,  -3,  1, -3],
      [ 3,   5, -1,  -1, -3,  1],
    ]
  end

  test "update position" do
    assert Day12.update_position( [ -1,  0,  2,  3, -1, -1] ) == [ 2, -1,  1,  3, -1, -1]
    assert Day12.update_position( [ 2, -10, -7,   1,  3,  3] ) == [ 3, -7, -4,  1,  3,  3]
    assert Day12.update_position( [ 4,  -8,  8,  -3,  1, -3] ) == [ 1, -7,  5, -3,  1, -3]
    assert Day12.update_position( [ 3,   5, -1,  -1, -3,  1] ) == [ 2,  2,  0, -1, -3,  1]
  end

  test "time step" do
    assert Day12.time_step([
      [-1,   0,  2,  0,  0,  0],
     [2, -10, -7,  0,  0,  0],
     [4,  -8,  8,  0,  0,  0],
     [3,   5, -1,  0,  0,  0]]
    ) == [
      [ 2, -1,  1,  3, -1, -1],
      [ 3, -7, -4,  1,  3,  3],
      [ 1, -7,  5, -3,  1, -3],
      [ 2,  2,  0, -1, -3,  1]
    ]
  end

  test "time steps" do
    assert Day12.time_steps([
      [-1,   0,  2,  0,  0,  0],
     [2, -10, -7,  0,  0,  0],
     [4,  -8,  8,  0,  0,  0],
      [3,   5, -1,  0,  0,  0]],
      10
    ) == [
      [ 2,  1, -3, -3, -2,  1],
      [ 1, -8,  0, -1,  1,  3],
      [ 3, -6,  1,  3,  2, -3],
      [ 2,  0,  4,  1, -1, -1],
    ]
    assert Day12.time_steps([
      [-8, -10, 0, 0, 0, 0],
      [5, 5, 10, 0, 0, 0],
      [2, -7, 3, 0, 0, 0],
      [9, -8, -3, 0, 0, 0],
    ], 100) == [
      [  8, -12,  -9,  -7,   3,   0],
      [ 13,  16,  -3,   3, -11,  -5],
      [-29, -11,  -1,  -3,   7,   4],
      [ 16, -13,  23,   7,   1,   1],
    ]
  end

  test "total energy" do
    assert Day12.total_energy([
      [ 2,  1, -3, -3, -2,  1],
      [ 1, -8,  0, -1,  1,  3],
      [ 3, -6,  1,  3,  2, -3],
      [ 2,  0,  4,  1, -1, -1],
    ]) == 179

    assert Day12.total_energy([
      [  8, -12,  -9,  -7,   3,   0],
      [ 13,  16,  -3,   3, -11,  -5],
      [-29, -11,  -1,  -3,   7,   4],
      [ 16, -13,  23,   7,   1,   1],
    ]) == 1940
  end


end
