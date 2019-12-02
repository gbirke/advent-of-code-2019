# Solutions for Advent of Code 2019

These are my solutions for the [Advent of Code](https://adventofcode.com) puzzles.

To run them with your own input, you need to place a file called `input.txt` in the respective directory.

| Name | Solution | Language |
|---|---|---|
| [Day 1: The Tyranny of the Rocket Equation](https://adventofcode.com/2019/day/1) | [calc-fuel](day-01/calc-fuel.rkt) | Racket |
| [Day 2: 1202 Program Alarm](https://adventofcode.com/2019/day/2) | [intcode](day-02/intcode.rkt) | Racket |

## Development tip
To run the tests whenever a file changes use [`entr`](http://eradman.com/entrproject/). Here is an example to run Racket:

```bash
ls day-02/*.rkt | entr -s 'racket day-02/my-module-test.rkt'
```
