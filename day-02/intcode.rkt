#lang racket/base

(require racket/list
		 racket/string)

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

(define (read-program str)
  (map string->number (map string-trim (string-split str ","))))

(provide intcode update-list run-program read-program)
