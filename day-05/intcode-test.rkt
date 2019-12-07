#lang racket/base

(require rackunit
		 racket/list
         "intcode.rkt")

; Tests for part 01 of the puzzle
;(check-equal? (run-program '(3 0 3 1 99) 0 '(42 23)) '(() () (42 23 3 1 99)) "Input writes input at address")
;(check-equal? (run-program '(4 0 4 4 99)) '((99 4) () (4 0 4 4 99)) "Output reads from address")
;(check-equal? (run-program '(104 0 4 4 99)) '((99 0) () (104 0 4 4 99)) "Output reads immediate from address")
;
;(check-equal? (run-program '(101 4 0 0 99)) '(() () (105 4 0 0 99)) "run-program can handle p1 immediate addition")
;(check-equal? (run-program '(1001 0 3 0 99)) '(() () (1004 0 3 0 99)) "run-program can handle p2 immediate addition")
;(check-equal? (run-program '(1101 12 30 0 99)) '(() () (42 12 30 0 99)) "run-program can handle immediate addition")
;
;(check-equal? (run-program '(102 4 0 0 99)) '(() () (408 4 0 0 99)) "run-program can handle p1 immediate addition")
;(check-equal? (run-program '(1002 0 3 0 99)) '(() () (3006 0 3 0 99)) "run-program can handle p2 immediate addition")
;(check-equal? (run-program '(1102 12 30 0 99)) '(() () (360 12 30 0 99)) "run-program can handle immediate addition")

(define (program-output code input )
  (first (run-program code 0 input)))

; Tests for part 02 of the puzzle
(check-equal? (program-output '(3 0 5 0 7 104 77 104 88 99) '(0)) '(88 77) "If-true goes to next instruction if addess is 0")
(check-equal? (program-output '(3 0 1005 0 7 104 77 104 88 99) '(1)) '(88) "If-true jumps to addess if address is non-zero")
(check-equal? (program-output '(105 1 8 104 77 104 88 99 5 ) '(0)) '(88) "If-true jumps to address if value is non-zero")

(check-equal? (program-output '(3 0 1006 0 7 104 77 104 88 99) '(0)) '(88) "If-zero jumps to address if addess is 0")
(check-equal? (program-output '(3 0 6 0 7 104 77 104 88 99) '(1)) '(88 77) "If-zero goes to next instruction if addess is 1")
(check-equal? (program-output '(106 1 8 104 77 104 88 99 5 ) '(0)) '(88 77) "If-zero to next instruction if value is 1")



