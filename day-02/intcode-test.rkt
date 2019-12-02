
#lang racket/base

(require rackunit
         "intcode.rkt")


(check-equal? (intcode + 0 '(1 2 3 3)) 6 "Apply operation to position 1 and 2, start at 0")
(check-equal? (intcode * 1 '(1 2 3 3)) 9 "Apppy operation to position 1 and 2, start at 1")

(check-equal? (update-list + '(1 2 1 0)) '(3 2 1 0) "Updates list at position, start at 0")
(check-equal? (update-list * '(1 2 3 3 0) 1) '(9 2 3 3 0) "Updates list at position, start at 1")

(check-equal? (run-program '(99)) '(99) "Stops at opcode 99")
(check-equal? (run-program '(1 4 0 0 99)) '(100 4 0 0 99) "Runs addition")
(check-equal? (run-program '(2 4 0 0 99)) '(198 4 0 0 99) "Runs multiplication")
(check-equal? (run-program '(1 9 10 3 2 3 11 0 99 30 40 50)) '(3500 9 10 70 2 3 11 0 99 30 40 50) "Example")

(check-equal? (read-program "1,2,3, 4, 5") '(1 2 3 4 5) "Read program")

(check-equal? (try-program 0 0 '(1 9 10 3 2 3 11 0 99 30 40 50)) 100 "Returns result for 0 0")
(check-equal? (try-program 1 2 '(1 9 10 3 2 3 11 0 99 30 40 50)) 150 "Returns result for 1 2")

(define (test-multi noun verb)
  (* noun verb))

(check-equal? (brute-force-solutions 188 test-multi) '(2 94) "Iterates functions until solution is found")
