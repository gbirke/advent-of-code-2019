import org.scalatest.FunSuite

class MemoryTests extends FunSuite {

    test("it can access memory pointer at addresses") {
      val m = Memory.loadProgram(List(1,2,3))
        assert(m.read(0) == 1)
    }

    test("it returns 0 for accessing unkown addresses") {
      val m = Memory.loadProgram(List(1,2,3))
        assert(m.read(4) == 0)
    }

    test("it can access memory at addresses with offset") {
      val m = Memory.loadProgram(List(1,2,3))
        assert(m.read(0, 1) == 2)
    }

    test("it can write at memory address") {
      val m = Memory.loadProgram(List(1,2,3))
        val newMemory = m.write(1, 0)
        assert( newMemory.read(1) == 0)
        assert( newMemory != m )
    }

}
