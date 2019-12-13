object Day09 {
  def main(args: Array[String]): Unit = {
    val program = ProgramLoader.loadProgram("input_day09.txt")
    val selfTestCode = Intcode.runProgram(program, List(1)).output.head
    println( s"BOOST keycode: $selfTestCode")
    val coordinates = Intcode.runProgram(program, List(2)).output
    println( s"Coordinates: ${coordinates}")
  }
}
