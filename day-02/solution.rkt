#lang racket

(require "intcode.rkt")

(let ([program-code (read-program (first (file->lines "input.txt")))])
	(display "First value of executed program: ")
	(displayln (first (run-program program-code)))

	(define (try-with-program noun verb)
	  (try-program noun verb program-code))

	(let ([winning-pair (brute-force-solutions 19690720 try-with-program)])
		(display "Params that produce the output: ")
		(displayln winning-pair)
		(display "Solution number: ")
		(displayln (+ (* (first winning-pair) 100) (second winning-pair)))
	)
)


