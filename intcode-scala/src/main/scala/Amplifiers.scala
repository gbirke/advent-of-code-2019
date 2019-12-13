class Amplifier(program: List[Int], phaseSetting: Int) {
  private var computer = Intcode.runProgram(program, List(phaseSetting))
  
  def processInput(input: List[Int]): List[Int] = {
    computer = computer.continueWithInput(input)
    computer.output
  }

  def programHasStopped() = {
    computer.state == State.FINISHED
  }

  def output(): List[Int] = {
    computer.output
  }
}

class AmplifierChain(program: List[Int], phaseSettings: List[Int]) {
  private val amplifiers = phaseSettings.map( ps => new Amplifier(program, ps)).toVector

  def runChainOnce(lastOutput:List[Int]=List(0), currentIndex: Int = 0): List[Int] = {
    if (currentIndex >= amplifiers.length ) {
      lastOutput
    }
    else {
      val currentAmplifier = amplifiers(currentIndex)
      runChainOnce( currentAmplifier.processInput(lastOutput), currentIndex + 1 )
    }
  }

  def runChainWithFeedback(lastOutput: List[Int]=List(0), currentIndex: Int = 0): Int = {
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
