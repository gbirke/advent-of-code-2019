
#lang racket/base

(require rackunit
		 racket/list
         "intcode2.rkt")


;(check-equal? (run-op (list + 0 1 2) '(1 3 2) ) 6 "Run-op applies op function ")
;(check-equal? (run-op (list * 2 4) '(1 3 2 8 66) ) 132 "Run-op applies op function ")

(let ([opcode (op-addition '(1 2 1 0) 0)])
	(check-equal? (rest opcode) '(1 2 0 ) "Addition params read memory pointers")
    (check-equal? (apply (first opcode) (rest opcode)) '(3 2 1 0 ) "Addition writes added value to memory address")
  )

(let ([opcode (op-multiplication '(0 2 2 2 0) 1)])
	(check-equal? (rest opcode) '(2 2 0 ) "Multiplication reads memory pointers")
	(check-equal? (apply (first opcode) (rest opcode)) '(4 2 2 2 0 ) "Multiplication writes multiplied value to memory address")
)
(check-equal? (run-program '(99)) '(99) "Stops at opcode 99")
(check-equal? (run-program '(1 4 0 0 99)) '(100 4 0 0 99) "Runs addition")
(check-equal? (run-program '(2 4 0 0 99)) '(198 4 0 0 99) "Runs multiplication")
(check-equal? (run-program '(1 9 10 3 2 3 11 0 99 30 40 50)) '(3500 9 10 70 2 3 11 0 99 30 40 50) "Intro Example")
(check-equal? (run-program '(1 0 0 0 99)) '(2 0 0 0 99) "Example 1")
(check-equal? (run-program '(2 3 0 3 99)) '(2 3 0 6 99) "Example 2")
(check-equal? (run-program '(2 4 4 5 99 0)) '(2 4 4 5 99 9801) "Example 3")
(check-equal? (run-program '(1 1 1 4 99 5 6 0 99)) '(30 1 1 4 2 5 6 0 99) "Example 4")

(check-equal? (read-program "1,2,3, 4, 5") '(1 2 3 4 5) "Read program")

(check-equal? (try-program 0 0 '(1 9 10 3 2 3 11 0 99 30 40 50)) 100 "Returns result for 0 0")
(check-equal? (try-program 1 2 '(1 9 10 3 2 3 11 0 99 30 40 50)) 150 "Returns result for 1 2")

(define (test-multi noun verb)
  (* noun verb))

(check-equal? (brute-force-solutions 188 test-multi) '(2 94) "Iterates functions until solution is found")
