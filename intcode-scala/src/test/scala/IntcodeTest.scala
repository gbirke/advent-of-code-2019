import org.scalatest.FunSuite

class IntcodeTests extends FunSuite {

    test("it can run exit program") {
        val i = Intcode.runProgram(List(99))
        assert(i.memory.read(0) == 99)
    }

    test("it can run addition program") {
        val i = Intcode.runProgram(List(1,1,2,0,99))
        assert(i.memory.read(0) == 3)
    }

    test("it can run multiplication program") {
      val i = Intcode.runProgram(List(2,2,4,0,99))
        assert(i.memory.read(0) == 396)
    }

    test("it can run example program") {
        val i = Intcode.runProgram(List(1,9,10,3,2,3,11,0,99,30,40,50))
        assert(i.memory.read(0) == 3500)

    }
}
