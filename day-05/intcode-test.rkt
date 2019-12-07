#lang racket/base

(require rackunit
		 racket/list
         "intcode.rkt")


(check-equal? (run-program '(3 0 3 1 99) '(42 23)) '(() () (42 23 3 1 99)) "Input writes input at address")
(check-equal? (run-program '(4 0 4 4 99)) '((99 4) () (4 0 4 4 99)) "Output reads from address")

(check-equal? (nth-digit 789 1) 9)
(check-equal? (nth-digit 789 2) 8)
(check-equal? (nth-digit 789 3) 7)

(check-equal? (run-op (op-addition '(1 1 2 0) 0)) '(3 1 2 0) "Parameter mode for both params of addition")
(check-equal? (run-op (op-addition '(101 5 4 0 2) 0)) '(7 5 4 0 2) "Immediate mode for param 1 of addition")
(check-equal? (run-op (op-addition '(1001 4 5 0 5) 0)) '(10 4 5 0 5) "Immediate mode for param 2 of addition")
(check-equal? (run-op (op-addition '(1101 12 30 0) 0)) '(42 12 30 0) "Immediate mode for both params of addition")


(check-equal? (run-op (op-multiplication '(2 2 2 0) 0)) '(4 2 2 0) "Parameter mode for both params of multiplication")
(check-equal? (run-op (op-multiplication '(102 5 4 0 2) 0)) '(10 5 4 0 2) "Immediate mode for param 1 of multiplication")
(check-equal? (run-op (op-multiplication '(1002 4 5 0 5) 0)) '(25 4 5 0 5) "Immediate mode for param 2 of multiplication")
(check-equal? (run-op (op-multiplication '(1102 12 30 0) 0)) '(360 12 30 0) "Immediate mode for both params of multiplication")


(check-equal? (run-program '(101 4 0 0 99)) '(() () (105 4 0 0 99)) "run-program can handle p1 immediate addition")
(check-equal? (run-program '(1001 0 3 0 99)) '(() () (1004 0 3 0 99)) "run-program can handle p2 immediate addition")
(check-equal? (run-program '(1101 12 30 0 99)) '(() () (42 12 30 0 99)) "run-program can handle immediate addition")

(check-equal? (run-program '(102 4 0 0 99)) '(() () (408 4 0 0 99)) "run-program can handle p1 immediate addition")
(check-equal? (run-program '(1002 0 3 0 99)) '(() () (3006 0 3 0 99)) "run-program can handle p2 immediate addition")
(check-equal? (run-program '(1102 12 30 0 99)) '(() () (360 12 30 0 99)) "run-program can handle immediate addition")

