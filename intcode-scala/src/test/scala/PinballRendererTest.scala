import org.scalatest.FunSuite

class PinballRendererTests extends FunSuite {

  test("it can render") {
    val r = new PinballRenderer(5,3)
    val board = r.render(List(
      (0,0,1),(1,0,2),(2,0,2),(3,0,2),(4,0,1),
      (0,1,1),(1,1,0),(2,1,4),(3,1,0),(4,1,1),
      (0,2,1),(1,2,0),(2,2,3),(3,2,0),(4,2,1),
    ))
    assert( board == "WBBBW\nW * W\nW _ W" )
  }

}
