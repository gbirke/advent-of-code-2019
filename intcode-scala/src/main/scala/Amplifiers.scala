class Amplifier(program: List[Long], phaseSetting: Long) {
  private var computer = Intcode.runProgram(program, List(phaseSetting))
  
  def processInput(input: List[Long]): List[Long] = {
    computer = computer.continueWithInput(input)
    computer.output
  }

  def programHasStopped() = {
    computer.state == State.FINISHED
  }

  def output(): List[Long] = {
    computer.output
  }
}

class AmplifierChain(program: List[Long], phaseSettings: List[Long]) {
  private val amplifiers = phaseSettings.map( ps => new Amplifier(program, ps)).toVector

  def runChainOnce(lastOutput:List[Long]=List(0), currentIndex: Int = 0): List[Long] = {
    if (currentIndex >= amplifiers.length ) {
      lastOutput
    }
    else {
      val currentAmplifier = amplifiers(currentIndex)
      runChainOnce( currentAmplifier.processInput(lastOutput), currentIndex + 1 )
    }
  }

  def runChainWithFeedback(lastOutput: List[Long]=List(0), currentIndex: Int = 0): Long = {
      val currentAmplifier = amplifiers(currentIndex % amplifiers.length)
      val output = currentAmplifier.processInput(lastOutput)
      if (amplifiers.last.programHasStopped) {
        amplifiers.last.output.head
      } else {
        // Use only the last output, the other outputs just repeat the previous output while the program iterates
        runChainWithFeedback(List(output.head), currentIndex + 1)
      }
  }
}
