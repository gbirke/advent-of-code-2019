class Intcode(
    val memory: Memory,
    val instructionCounter: Int = 0,
    input: List[Int] = List(),
    val output: List[Int] = List()
) {

  def copy(
    memory: Memory = memory,
    instructionCounter: Int = instructionCounter,
    input: List[Int] = input,
    output: List[Int] = output
) = new Intcode( memory, instructionCounter, input, output )

  private def getParameter(offset: Int, mode: Int): Int = {
    mode match {
      case Mode.Immediate =>
        memory.read(memory.read(instructionCounter, offset))
      case Mode.Parameter => memory.read(instructionCounter, offset)
    }
  }

  private def op_add(param1Mode: Int, param2Mode: Int): Intcode = {
    val p1 = getParameter(1, param1Mode)
    val p2 = getParameter(2, param2Mode)
    val target = getParameter(3, Mode.Parameter)
    copy( 
      memory.write(target, p1 + p2),
      instructionCounter + 4 
    )
  }

  private def op_multiply(param1Mode: Int, param2Mode: Int): Intcode = {
    val p1 = getParameter(1, param1Mode)
    val p2 = getParameter(2, param2Mode)
    val target = getParameter(3, Mode.Parameter)
    copy(
      memory.write(target, p1 * p2),
      instructionCounter + 4,
    )
  }

  private def op_write_input(): Intcode = {
    val target = getParameter(1, Mode.Parameter)
    copy(
      memory.write(target, input.head),
      instructionCounter + 2,
      input.tail,
    )
  }

  private def op_output(param1Mode: Int): Intcode = {
    val value: Int = getParameter(1, param1Mode)
    copy( 
      instructionCounter = instructionCounter + 2, 
      output = output.::(value)
    )
  }

  private def op_jumpIfTrue(param1Mode: Int, param2Mode: Int): Intcode = {
    val value: Int = getParameter(1, param1Mode)
    copy(
      instructionCounter = if (value > 0) getParameter(2, param2Mode) else instructionCounter + 3
    )
  }

  private def op_jumpIfFalse(param1Mode: Int, param2Mode: Int): Intcode = {
    val value: Int = getParameter(1, param1Mode)
    copy(
      instructionCounter = if (value == 0) getParameter(2, param2Mode) else instructionCounter + 3
    )
  }

  private def op_lessThan(param1Mode: Int, param2Mode: Int): Intcode = {
    val p1 = getParameter(1, param1Mode)
    val p2 = getParameter(2, param2Mode)
    val target: Int = getParameter(3, Mode.Parameter)
    copy(
      if (p1 < p2) memory.write(target, 1) else memory.write(target, 0),
      instructionCounter + 4,
    )
  }

  private def op_equals(param1Mode: Int, param2Mode: Int): Intcode = {
    val p1 = getParameter(1, param1Mode)
    val p2 = getParameter(2, param2Mode)
    val target: Int = getParameter(3, Mode.Parameter)
    copy(
      if (p1 == p2) memory.write(target, 1) else memory.write(target, 0),
      instructionCounter + 4,
    )
  }

  private def modeStrToMode(modeStr: Char): Int = modeStr match {
    case '0' => Mode.Immediate
    case '1' => Mode.Parameter
  }

  private def splitOpcode(opcode: Int) = {
    val opcodeParts = f"${opcode}%04d"
    (
      opcodeParts.slice(2, 4).toInt,
      modeStrToMode(opcodeParts.charAt(1)),
      modeStrToMode(opcodeParts.charAt(0))
    )
  }

  // TODO use success and failure to abort on invalid opcodes and avoid warning
  private def nextInstruction(): Intcode = {
    val opcode = memory.read(instructionCounter)
    splitOpcode(opcode) match {
      case (99, _, _)  => this
      case (1, p1, p2) => { op_add(p1, p2).nextInstruction() }
      case (2, p1, p2) => { op_multiply(p1, p2).nextInstruction() }
      case (3, _, _)   => { op_write_input().nextInstruction() }
      case (4, p1, _)  => { op_output(p1).nextInstruction() }
      case (5, p1, p2) => { op_jumpIfTrue(p1, p2).nextInstruction() }
      case (6, p1, p2) => { op_jumpIfFalse(p1, p2).nextInstruction() }
      case (7, p1, p2) => { op_lessThan(p1, p2).nextInstruction() }
      case (8, p1, p2) => { op_equals(p1, p2).nextInstruction() }
    }
  }
}

object Intcode {
  def runProgram(program: List[Int], input: List[Int] = List()) =
    new Intcode(Memory.loadProgram(program), 0, input).nextInstruction()
}

object Mode {
  val Immediate = 0
  val Parameter = 1
}
