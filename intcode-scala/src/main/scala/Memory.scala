// Using a map because in later versions we'll have memory cells beyond the program
class Memory(val cells: Map[Int, Int] = Map()) {

  def read(address: Int, offset: Int = 0): Int =
    cells.getOrElse(address + offset, 0)
  def write(address: Int, value: Int): Memory =
    new Memory(cells + (address -> value))
  def dump() = cells.values
}

object Memory {
  def loadProgram(program: List[Int]): Memory = new Memory(
    program.zipWithIndex.map(cellAndIndex => cellAndIndex.swap).toMap
  )
}
