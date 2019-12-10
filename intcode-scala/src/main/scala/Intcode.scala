class Intcode(val memory: Memory, val instructionCounter: Int = 0) {

	private def getParameter(offset: Int, mode: Int): Int = {
		mode match {
			case Mode.Immediate => memory.read( memory.read(instructionCounter, offset) )
			case Mode.Parameter => memory.read(instructionCounter, offset)
		}
	}

	private def op_add(): Intcode = {
		val p1 = getParameter(1, Mode.Immediate)
		val p2 = getParameter(2, Mode.Immediate)
		val target = getParameter(3, Mode.Parameter)
		new Intcode(
			memory.write(target, p1 + p2),
			instructionCounter + 4
		)
	}

	private def op_multiply():Intcode = {
		val p1 = getParameter(1, Mode.Immediate)
		val p2 = getParameter(2, Mode.Immediate)
		val target = getParameter(3, Mode.Parameter)
		new Intcode(
			memory.write(target, p1 * p2),
			instructionCounter + 4
		)
	}

	private def nextInstruction(): Intcode = {
		val opcode = memory.read(instructionCounter)
		opcode match {
			case 99 => this
			case 1  => { op_add().nextInstruction() }
			case 2  => { op_multiply().nextInstruction() }
		}
	}
}

object Intcode {
	def runProgram(program: List[Int]) = new Intcode(Memory.loadProgram(program), 0).nextInstruction()
}

object Mode {
	val Immediate = 0
	val Parameter = 1
}
