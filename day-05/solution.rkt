#lang racket/base

(require racket/file
		 racket/list
         "intcode.rkt")

(let ([program-code (read-program (first (file->lines "input.txt")))])
	(display "Output of test program: ")
	(displayln (run-program program-code '(1)))

)
