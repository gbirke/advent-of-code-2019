#lang racket/base

(require racket/file
		 racket/list
         "intcode.rkt"
         "amplifiers.rkt")

(let ([program-code (read-program (first (file->lines "input.txt")))])
	(display "Max thrust: ")
	(displayln (first (sort (map (lambda (input) (amplifier-cascade input program-code) ) (all-cascade-combinations) ) >)))

)
