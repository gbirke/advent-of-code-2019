class Intcode(
    val memory: Memory,
    val instructionCounter: Long = 0,
    val input: List[Long] = List(),
    val output: List[Long] = List(),
    val relativeBase: Long = 0,
    val state: Int = State.RUNNING
) {

  def copy(
      memory: Memory = memory,
      instructionCounter: Long = instructionCounter,
      input: List[Long] = input,
      output: List[Long] = output,
      relativeBase: Long = relativeBase,
      state: Int = state
  ) = new Intcode(memory, instructionCounter, input, output, relativeBase, state)

  private def readMemory(offset: Int, mode: Int): Long = {
    mode match {
      case Mode.Immediate =>
        memory.read(memory.read(instructionCounter, offset))
      case Mode.Relative => memory.read( memory.read(instructionCounter, offset ) + relativeBase)
      case Mode.Parameter => memory.read(instructionCounter, offset)
    }
  }

  private def writeMemory(value: Long, offset: Int, mode: Int): Memory = {
    mode match {
      // Treat immediate as Parameter - immediate doesn't make sense in a write context
      case Mode.Immediate => memory.write( memory.read( instructionCounter + offset), value )
      case Mode.Relative => memory.write( memory.read( instructionCounter + offset) + relativeBase, value )
      case Mode.Parameter => memory.write( memory.read( instructionCounter + offset), value )
    }
  }

  private def op_add(param1Mode: Int, param2Mode: Int, param3Mode: Int): Intcode = {
    val p1 = readMemory(1, param1Mode)
    val p2 = readMemory(2, param2Mode)
    copy(
      writeMemory(p1 + p2, 3, param3Mode),
      instructionCounter + 4
    )
  }

  private def op_multiply(param1Mode: Int, param2Mode: Int, param3Mode: Int): Intcode = {
    val p1 = readMemory(1, param1Mode)
    val p2 = readMemory(2, param2Mode)
    copy(
      writeMemory(p1 * p2, 3, param3Mode),
      instructionCounter + 4
    )
  }

  private def op_write_input(param1Mode: Int): Intcode = {
    if (input.length > 0) {
      copy(
        writeMemory(input.head, 1, param1Mode),
        instructionCounter + 2,
        input.tail
      )
    } else {
      copy(state = State.WAIT_FOR_INPUT)
    }
  }

  private def op_output(param1Mode: Int): Intcode = {
    val value: Long = readMemory(1, param1Mode)
    copy(
      instructionCounter = instructionCounter + 2,
      output = output.::(value)
    )
  }

  private def op_jumpIfTrue(param1Mode: Int, param2Mode: Int): Intcode = {
    val value: Long = readMemory(1, param1Mode)
    copy(
      instructionCounter =
        if (value > 0) readMemory(2, param2Mode) else instructionCounter + 3
    )
  }

  private def op_jumpIfFalse(param1Mode: Int, param2Mode: Int): Intcode = {
    val value: Long = readMemory(1, param1Mode)
    copy(
      instructionCounter =
        if (value == 0) readMemory(2, param2Mode) else instructionCounter + 3
    )
  }

  private def op_lessThan(param1Mode: Int, param2Mode: Int, param3Mode: Int): Intcode = {
    val p1 = readMemory(1, param1Mode)
    val p2 = readMemory(2, param2Mode)
    copy(
      writeMemory( if (p1 < p2) 1 else 0, 3, param3Mode ),
      instructionCounter + 4
    )
  }

  private def op_equals(param1Mode: Int, param2Mode: Int, param3Mode: Int): Intcode = {
    val p1 = readMemory(1, param1Mode)
    val p2 = readMemory(2, param2Mode)
    copy(
      writeMemory( if (p1 == p2) 1 else 0, 3, param3Mode ),
      instructionCounter + 4
    )
  }

  private def op_adjustRelativeBase(param1Mode: Int):Intcode = {
    val p1 = readMemory(1, param1Mode)
    copy( 
      relativeBase = relativeBase + p1,
      instructionCounter = instructionCounter + 2
    )
  }

  private def op_halt(): Intcode = {
    copy(state = State.FINISHED)
  }

  // This acts as a kind of guard clause agains invalid address modes
  private def modeStrToMode(modeStr: Char): Int = modeStr match {
    case '0' => Mode.Immediate
    case '1' => Mode.Parameter
    case '2' => Mode.Relative
  }

  private def splitOpcode(opcode: Long):(Int,Int,Int,Int) = {
    val opcodeParts = f"${opcode}%05d"
    (
      opcodeParts.slice(3, 5).toInt,
      modeStrToMode(opcodeParts.charAt(2)),
      modeStrToMode(opcodeParts.charAt(1)),
      modeStrToMode(opcodeParts.charAt(0))
    )
  }

  private def nextInstruction(): Intcode = {
    if (state != State.RUNNING) {
      return this
    }
    val opcode = memory.read(instructionCounter)
    splitOpcode(opcode) match {
      case (99, _, _, _)  => { op_halt().nextInstruction() }
      case (1, p1, p2, p3) => { op_add(p1, p2, p3).nextInstruction() }
      case (2, p1, p2, p3) => { op_multiply(p1, p2, p3).nextInstruction() }
      case (3, p1, _, _)  => { op_write_input(p1).nextInstruction() }
      case (4, p1, _, _)  => { op_output(p1).nextInstruction() }
      case (5, p1, p2, _) => { op_jumpIfTrue(p1, p2).nextInstruction() }
      case (6, p1, p2, _) => { op_jumpIfFalse(p1, p2).nextInstruction() }
      case (7, p1, p2, p3) => { op_lessThan(p1, p2, p3).nextInstruction() }
      case (8, p1, p2, p3) => { op_equals(p1, p2, p3).nextInstruction() }
      case (9, p1, _, _)  => { op_adjustRelativeBase(p1).nextInstruction() }
      case (_, _, _, _)   => copy(state = State.INVALID_OPCODE)
    }
  }

  def continueWithInput(input: List[Long]) =
    copy(input = input, state = State.RUNNING).nextInstruction()
}

object Intcode {
  def runProgram(program: List[Long], input: List[Long] = List()) =
    new Intcode(Memory.loadProgram(program), 0, input).nextInstruction()
}

object Mode {
  val Immediate = 0
  val Parameter = 1
  val Relative  = 2
}

object State {
  val RUNNING = 0
  val FINISHED = 99
  val WAIT_FOR_INPUT = 1
  val INVALID_OPCODE = 666
}
