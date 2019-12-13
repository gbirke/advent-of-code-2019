import scala.io.Source

object Day05 {
  def main(args: Array[String]): Unit = {
    val in = Source.fromFile("input_day05.txt").getLines.mkString.trim
    val program = in.split(",").map(str => str.toLong).toList
    val computer = Intcode.runProgram(program, List(5))
    println(computer.output)
  }
}
