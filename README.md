# Solutions for Advent of Code 2019

These are my solutions for the [Advent of Code](https://adventofcode.com) puzzles.

| Name | Solution | Language |
|---|---|---|
| [Day 1: The Tyranny of the Rocket Equation](https://adventofcode.com/2019/day/1) | [calc-fuel](day-01/calc-fuel.rkt) | Racket |

## Development tip
To run the tests whenever a file changes use [`entr`](http://eradman.com/entrproject/). Here is an example to run Racket:

```bash
ls day-02/*.rkt | entr -s 'racket day-02/my-module-test.rkt'
```
