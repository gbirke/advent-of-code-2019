object PinballGame {

  val renderer = new PinballRenderer(45,24)
  var ballX = 0;
  var paddleX = 0;
  var score = 0;
  var joystickMove = 0

  def tileListToTuple( tile:List[Long] ): Tuple3[Int, Int, Int ] = {
    tile match {
      case List(x, y, t) => (x.toInt, y.toInt, t.toInt)
      case _ => (0,0,0)
    }
  }

  def outputToTiles(out: List[Long] ) = {
    out.reverse.sliding(3, 3).map( tileListToTuple )
  }

  def getScore( t: Tuple3[Int, Int, Int] ): Option[Int] = {
    t match {
      case ( -1, 0, score ) => Some(score)
      case _ => None
    } 
  }

  def getInterestingValue( t: Tuple3[Int, Int, Int]): Option[Tuple2[Int, Int]] = {
    t match {
      case ( -1, 0, score ) => Some((100, score))
      case ( x, _, 3 ) => Some((3, x)) // Paddle
      case ( x, _, 4 ) => Some((4, x)) // Ball
      case _ => None
    }
  }

  def updateState( t:Option[Tuple2[Int,Int]] ) = {
    t match {
      case Some((3,x)) => paddleX = x
      case Some((4,x)) => ballX = x
      case Some((100,s)) => score = s
      case _ => None
    }
  }

  def updateGameState(out: List[Long]): String = {
    val tiles = outputToTiles(out).toList
    
    // map with side effect to update state :(
    tiles.map( getInterestingValue ).filter( _.isDefined ).map( updateState )

    joystickMove = if ( paddleX > ballX ) -1 else if ( paddleX < ballX ) 1 else 0

    renderer.render( tiles.filterNot( getScore(_).isDefined ) ) + 
    s"\nBall X: $ballX Paddle X $paddleX Score: $score                     \n" 
  }

  def main(args: Array[String]): Unit = {
    val program = ProgramLoader.loadProgram("input_day13.txt")
    var pinball = Intcode.runProgram(List(2L) ++ program.tail)
    print("\u001B[0;0H")
    println( updateGameState(pinball.output))
    while( pinball.state == State.WAIT_FOR_INPUT ) {
      pinball = pinball.clearOutput().continueWithInput(List(joystickMove))
      Thread.sleep(15) // for 60 fps the value would be 16.66, let's speed things up
      print("\u001B[0;0H")
      println( updateGameState(pinball.output))
    }
  }
}
