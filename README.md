# Solutions for Advent of Code 2019

These are my solutions for the [Advent of Code](https://adventofcode.com) puzzles.

To run them with your own input, you need to place a file called `input.txt` in the respective directory.

| Name | Solution | Language |
|---|---|---|
| [Day 1: The Tyranny of the Rocket Equation](https://adventofcode.com/2019/day/1) | [calc-fuel](day-01/calc-fuel.rkt) | Racket |
| [Day 2: 1202 Program Alarm](https://adventofcode.com/2019/day/2) | First try: [intcode](day-02/intcode.rkt)<br>More abstracted, domain-oriented solution: [intcode2](day-02/intcode2.rkt)  | Racket |
| [Day 4: Secure Container](https://adventofcode.com/2019/day/4)| [digits](day-04/digits.rkt) | Racket |
| [Day 5: Sunny with a Chance of Asteroids](https://adventofcode.com/2019/day/5)| [intcode](day-05/intcode.rkt) | Racket |
| [Day 6: Universal Orbit Map](https://adventofcode.com/2019/day/6) | [day06](day06/lib/day06.ex) | Elixir |
| [Day 7: Amplification Circuit](https://adventofcode.com/2019/day/7)| [intcode](day-07/amplifiers.rkt) | Racket |
| [Day 8: Space Image Format](https://adventofcode.com/2019/day/8) | [day08](day08/lib/day08.ex) | Elixir |
| [Day 12: The N-Body Problem](https://adventofcode.com/2019/day/12) | 1st puzzle [day12](day12/lib/day12.ex) | Elixir |


## Development tip
To run the tests whenever a file changes use [`entr`](http://eradman.com/entrproject/). Here is an example to run Racket:

```bash
ls day-02/*.rkt | entr -s 'racket day-02/my-module-test.rkt'
```
