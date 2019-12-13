// Using a map because in later versions we'll have memory cells beyond the program
class Memory(val cells: Map[Long, Long] = Map()) {

  def read(address: Long, offset: Int = 0): Long =
    cells.getOrElse(address + offset, 0)

  def write(address: Long, value: Long): Memory =
    new Memory(cells + (address -> value))
  
  def dump() = cells.values
}

object Memory {
  def loadProgram(program: List[Long]): Memory = new Memory(
    program.zipWithIndex.map(cellAndIndex => (cellAndIndex._2.toLong, cellAndIndex._1)).toMap[Long,Long]
  )
}
