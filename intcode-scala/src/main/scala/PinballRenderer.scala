class PinballRenderer(val width: Int, val height: Int) {
  val display = Array.ofDim[String](height, width)
  val tiles = Map[Int,String]( 0 -> " ", 1 -> "W", 2 -> "B", 3 -> "_", 4 -> "*" )

  def render(items: List[Tuple3[Int, Int,Int]]): String = {
    for (i:Tuple3[Int, Int,Int] <- items) display(i._2)(i._1) = tiles.getOrElse(i._3, " ")
    display.map( (row:Array[String]) => row.mkString ).mkString("\n")
  }

  
}
