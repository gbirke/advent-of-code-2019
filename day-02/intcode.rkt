#lang racket/base

(require racket/list
		 racket/string
		 racket/function)

(define (intcode op pos lst)
  	; Uncomment to debug
  	;(printf "accessing ~a ~a~n" (+ pos 1) (+ pos 2))
  	;(printf "at indexes ~a ~a~n" (list-ref lst (+ pos 1)) (list-ref lst (+ pos 2)) )
  	;(printf "doing ~a for (~a ~a)~n" op (list-ref lst (list-ref lst (+ pos 1))) (list-ref lst (list-ref lst (+ pos 2))) )
	(op 
	  (list-ref lst (list-ref lst (+ pos 1)))
	  (list-ref lst (list-ref lst (+ pos 2)))
	))

(define (update-list op lst [pos 0])
  (list-set 
	lst 
	(list-ref lst (+ pos 3))
	(intcode op pos lst)
	))


(define (run-program lst [pos 0])
  (let ([opcode (list-ref lst pos)])
	  (cond
		[(= opcode 99) lst]
		[(= opcode 1) (run-program (update-list + lst pos) (+ pos 4) )]
		[(= opcode 2) (run-program (update-list * lst pos) (+ pos 4) )]
	  )))

(define (try-program noun verb lst)
  (first (run-program (list-set (list-set lst 1 noun) 2 verb) )))

(define (read-program str)
  (map string->number (map string-trim (string-split str ","))))

(define (brute-force-solutions expected-result solution-function)
  (first (filter identity (for*/list ([noun (in-range 99)]
		 [verb (in-range 99)])
	(if (= expected-result (solution-function noun verb))
	  (list noun verb)
	  #f
	)
	))))

(provide intcode
		 update-list
		 run-program
		 read-program
		 try-program
		 brute-force-solutions)
