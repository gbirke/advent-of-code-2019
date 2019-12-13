import scala.io.Source

object ProgramLoader {
  def loadProgram(name: String):List[Long] = {
    val in = Source.fromFile(name).getLines.mkString.trim
    in.split(",").map(str => str.toLong).toList
  }
}
