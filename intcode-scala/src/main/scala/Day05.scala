object Day05 {
  def main(args: Array[String]): Unit = {
    val program = ProgramLoader.loadProgram("input_day05.txt")
    val computer = Intcode.runProgram(program, List(5))
    println(computer.output)
  }
}
