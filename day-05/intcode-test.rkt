#lang racket/base

(require rackunit
		 racket/list
         "intcode.rkt")


(check-equal? (run-program '(3 0 3 1 99) '(42 23)) '(() () (42 23 3 1 99)) "Input writes input at address")
(check-equal? (run-program '(4 0 4 4 99)) '((99 4) () (4 0 4 4 99)) "Output reads from address")


