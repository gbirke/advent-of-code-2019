import org.scalatest.FunSuite

class IntcodeTests extends FunSuite {

  test("it can run exit program") {
    val i = Intcode.runProgram(List(99))
    assert(i.memory.read(0) == 99)
  }

  test("it can run addition program") {
    val i = Intcode.runProgram(List(1, 1, 2, 0, 99))
    assert(i.memory.read(0) == 3)
  }

  test("it can run addition program in parameter mode") {
    val i = Intcode.runProgram(List(1101, 5, 6, 0, 99))
    assert(i.memory.read(0) == 11)
  }

  test("it can run multiplication program") {
    val i = Intcode.runProgram(List(2, 2, 4, 0, 99))
    assert(i.memory.read(0) == 396)
  }

  test("it can run multiplication program in parameter mode") {
    val i = Intcode.runProgram(List(1102, 7, 6, 0, 99))
    assert(i.memory.read(0) == 42)
  }

  test("it can run example program from Day 02") {
    val i = Intcode.runProgram(List(1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50))
    assert(i.memory.read(0) == 3500)
  }

  test("it can read input in program") {
    val i = Intcode.runProgram(List(3, 0, 99), List(55))
    assert(i.memory.read(0) == 55)
  }

  test("it writes to output in program") {
    val i = Intcode.runProgram(List(4, 0, 4, 1, 99))
    assert(i.output == List(0, 4))
  }

  test("it writes to output in program, parameter mode") {
    val i = Intcode.runProgram(List(104, 66, 99))
    assert(i.output == List(66))
  }

  test("jump-if-true jumps") {
    val programWithJump =
      Intcode.runProgram(List(5, 1, 5, 104, 1, 6, 104, 0, 99), List())
    val programWithoutJump =
      Intcode.runProgram(List(5, 6, 5, 104, 1, 104, 0, 99), List())
    assert(programWithJump.output == List(0))
    assert(programWithoutJump.output == List(0, 1))
  }

  test("jump-if-true jumps in parameter mode") {
    val programWithJump =
      Intcode.runProgram(List(1105, 1, 5, 104, 1, 104, 0, 99), List())
    val programWithoutJump =
      Intcode.runProgram(List(1105, 0, 5, 104, 1, 104, 0, 99), List())
    assert(programWithJump.output == List(0))
    assert(programWithoutJump.output == List(0, 1))
  }

  test("jump-if-false jumps") {
    val programWithJump =
      Intcode.runProgram(List(6, 7, 5, 104, 1, 6, 104, 0, 99), List())
    val programWithoutJump =
      Intcode.runProgram(List(6, 1, 5, 104, 1, 104, 0, 99), List())
    assert(programWithJump.output == List(0))
    assert(programWithoutJump.output == List(0, 1))
  }

  test("jump-if-false jumps in parameter mode") {
    val programWithJump =
      Intcode.runProgram(List(1106, 0, 5, 104, 1, 104, 0, 99), List())
    val programWithoutJump =
      Intcode.runProgram(List(1106, 1, 5, 104, 1, 104, 0, 99), List())
    assert(programWithJump.output == List(0))
    assert(programWithoutJump.output == List(0, 1))
  }

  test("less-than writes 1 and 0 depending on value") {
    val programWithParameterLessThan =
      Intcode.runProgram(List(7, 1, 2, 5, 104, 5, 99), List())
    val programWithoutParameterLessThan =
      Intcode.runProgram(List(7, 4, 2, 5, 104, 5, 99), List())
    assert(programWithParameterLessThan.output == List(1))
    assert(programWithoutParameterLessThan.output == List(0))
  }

  test("less-than writes 1 and 0 depending on value in parameter mode") {
    val programWithParameterLessThan =
      Intcode.runProgram(List(1107, 1, 2, 5, 104, 5, 99), List())
    val programWithoutParameterLessThan =
      Intcode.runProgram(List(1107, 4, 2, 5, 104, 5, 99), List())
    assert(programWithParameterLessThan.output == List(1))
    assert(programWithoutParameterLessThan.output == List(0))
  }

  test("equals writes 1 and 0 depending on value") {
    val programWithParameterLessThan =
      Intcode.runProgram(List(8, 1, 1, 5, 104, 5, 99), List())
    val programWithoutParameterLessThan =
      Intcode.runProgram(List(8, 4, 2, 5, 104, 5, 99), List())
    assert(programWithParameterLessThan.output == List(1))
    assert(programWithoutParameterLessThan.output == List(0))
  }

  test("equals writes 1 and 0 depending on value in parameter mode") {
    val programWithParameterLessThan =
      Intcode.runProgram(List(1108, 1, 1, 5, 104, 5, 99), List())
    val programWithoutParameterLessThan =
      Intcode.runProgram(List(1108, 4, 2, 5, 104, 5, 99), List())
    assert(programWithParameterLessThan.output == List(1))
    assert(programWithoutParameterLessThan.output == List(0))
  }

  test("it can run example program from day 5") {
    val program: List[Long] = List(3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20,
      1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1,
      46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99)
    val below8 = Intcode.runProgram(program, List(7))
    val exactly8 = Intcode.runProgram(program, List(8))
    val above8 = Intcode.runProgram(program, List(9))
    assert(below8.output == List(999))
    assert(exactly8.output == List(1000))
    assert(above8.output == List(1001))
  }

  test("it has state finished when it halts") {
    assert(Intcode.runProgram(List(99)).state == State.FINISHED)
  }

  test("it has state invalid opcode when it encounters invalid opcodes") {
    assert(Intcode.runProgram(List(0)).state == State.INVALID_OPCODE)
  }

  test("it halts execution when waiting for input") {
    val start = Intcode.runProgram(List(3, 0, 4, 0, 99))
    assert(start.state == State.WAIT_FOR_INPUT)
    assert(start.instructionCounter == 0)
    val continued = start.continueWithInput(List(42))
    assert(continued.state == State.FINISHED)
    assert(continued.output == List(42))
  }

  test("continueWithInput keeps program state when not waiting for input") {
    val haltedProgram = Intcode.runProgram(List(99)).continueWithInput(List(1,2,3))
    val invalidPrgram = Intcode.runProgram(List(0)).continueWithInput(List(1,2,3))
    assert(haltedProgram.state == State.FINISHED)
    assert(invalidPrgram.state == State.INVALID_OPCODE)
  }

  test("continueWithInput keeps input values when not waiting for input") {
    val haltedProgram = Intcode.runProgram(List(99)).continueWithInput(List(1,2,3))
    val invalidPrgram = Intcode.runProgram(List(0)).continueWithInput(List(1,2,3))
    assert(haltedProgram.input == List(1,2,3))
    assert(invalidPrgram.input == List(1,2,3))
  }
}
