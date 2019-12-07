#lang racket/base

(require rackunit
		 racket/list
         "intcode.rkt")


(check-equal? (run-program '(3 0 3 1 99) 0 '(42 23)) '(() () (42 23 3 1 99)) "Input writes input at address")
(check-equal? (run-program '(4 0 4 4 99)) '((99 4) () (4 0 4 4 99)) "Output reads from address")
(check-equal? (run-program '(104 0 4 4 99)) '((99 0) () (104 0 4 4 99)) "Output reads immediate from address")

(check-equal? (run-program '(101 4 0 0 99)) '(() () (105 4 0 0 99)) "run-program can handle p1 immediate addition")
(check-equal? (run-program '(1001 0 3 0 99)) '(() () (1004 0 3 0 99)) "run-program can handle p2 immediate addition")
(check-equal? (run-program '(1101 12 30 0 99)) '(() () (42 12 30 0 99)) "run-program can handle immediate addition")

(check-equal? (run-program '(102 4 0 0 99)) '(() () (408 4 0 0 99)) "run-program can handle p1 immediate addition")
(check-equal? (run-program '(1002 0 3 0 99)) '(() () (3006 0 3 0 99)) "run-program can handle p2 immediate addition")
(check-equal? (run-program '(1102 12 30 0 99)) '(() () (360 12 30 0 99)) "run-program can handle immediate addition")

