object Day13 {
  def main(args: Array[String]): Unit = {
    val program = ProgramLoader.loadProgram("input_day13.txt")
    val pinball = Intcode.runProgram(program)
    val tiles = pinball.output.sliding(3, 3)
    val blockTiles = tiles.filter( t => t.head == 2 )
    //println(tiles.toList);
    //println(s"Number tiles: ${tiles.length}")
    println(s"Number of block tiles: ${blockTiles.length}")
  }
}
