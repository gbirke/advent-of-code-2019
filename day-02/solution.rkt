#lang racket

(require "intcode.rkt")

(let ([program-code (read-program (first (file->lines "input.txt")))])
	(display "First value of executed program: ")
	(displayln (first (run-program program-code)))
)


