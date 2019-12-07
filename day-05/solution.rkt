#lang racket/base

(require racket/file
		 racket/list
         "intcode.rkt")

(let ([program-code (read-program (first (file->lines "input.txt")))])
	(display "Output of test program with input 1: ")
	(displayln (run-program program-code 0 '(1)))

	(display "Output of test program with input 5: ")
	(displayln (run-program program-code 0 '(5)))
)
