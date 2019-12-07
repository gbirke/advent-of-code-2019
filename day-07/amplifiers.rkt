#lang racket/base

(require racket/file
		 racket/list
		 racket/trace
         "intcode.rkt")

(define (program-output code input)
  (first (run-program code 0 input)))

(define (amplifier-cascade input code)
  (define (one-amp phase input) (first (program-output code (list phase input ))))
  ;(trace one-amp)
  (foldl one-amp ;(lambda 
		 ;  (phase last-output) (first (program-output code (list phase last-output))))
		 0
		 input
		 ))



(define (all-cascade-combinations)
 (filter (lambda (phase-settings) (= (length phase-settings) (length (remove-duplicates phase-settings) )) ) (for*/list (
			  [a (in-range 5 )]
			  [b (in-range 5 )]
			  [c (in-range 5 )]
			  [d (in-range 5 )]
			  [e (in-range 5 )]
			  )
  (list a b c d e))))


(provide amplifier-cascade
		 all-cascade-combinations)
