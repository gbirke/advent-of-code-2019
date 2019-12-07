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


(check-equal? (program-output '(3 0 7 0 2 7 104 -1 99 ) '(8)) '(0) "Less than with 8 < 7 ")
(check-equal? (program-output '(3 0 7 0 2 7 104 -1 99 ) '(7)) '(0) "Less than with 7 < 7 ")
(check-equal? (program-output '(3 0 7 0 2 7 104 -1 99 ) '(3)) '(1) "Less than with 3 < 7 ")
(check-equal? (program-output '(3 0 107 0 2 7 104 -1 99 ) '(3)) '(1) "Less than with 0 < 107 ")
(check-equal? (program-output '(3 0 1007 0 2 7 104 -1 99 ) '(3)) '(0) "Less than with 3 < 2 ")
(check-equal? (program-output '(3 0 1107 0 2 7 104 -1 99 ) '(3)) '(1) "Less than with 0 < 2 ")

(check-equal? (program-output '(3 9 8 9 10 9 4 9 99 -1 8 ) '(3)) '(0) "Example 1 - 3 equal to 8 ")
(check-equal? (program-output '(3 9 8 9 10 9 4 9 99 -1 8 ) '(8)) '(1) "Example 1 - 8 equal to 8 ")

(check-equal? (program-output '(3 9 7 9 10 9 4 9 99 -1 8 ) '(3)) '(1) "Example 2 - 3 less than 8 ")
(check-equal? (program-output '(3 9 7 9 10 9 4 9 99 -1 8 ) '(8)) '(0) "Example 2 - 8 less then 8 ")

(check-equal? (program-output '(3 3 1108 -1 8 3 4 3 99 ) '(3)) '(0) "Example 3 - 3 equal to 8 ")
(check-equal? (program-output '(3 3 1108 -1 8 3 4 3 99 ) '(8)) '(1) "Example 3 - 8 equal to 8 ")

(check-equal? (program-output '(3 3 1107 -1 8 3 4 3 99 ) '(3)) '(1) "Example 4 - 3 equal to 8 ")
(check-equal? (program-output '(3 3 1107 -1 8 3 4 3 99 ) '(8)) '(0) "Example 4 - 8 equal to 8 ")

(check-equal? (program-output '(3 12 6 12 15 1 13 14 13 4 13 99 -1 0 1 9) '(3)) '(1) "Example 5 - 0 if input is 0")
(check-equal? (program-output '(3 12 6 12 15 1 13 14 13 4 13 99 -1 0 1 9) '(0)) '(0) "Example 5 - 0 if input is 0")

(check-equal? (program-output '(3 3 1105 -1 9 1101 0 0 12 4 12 99 1) '(3)) '(1) "Example 6 - 0 if input is 0")
(check-equal? (program-output '(3 3 1105 -1 9 1101 0 0 12 4 12 99 1) '(3)) '(1) "Example 6 - 0 if input is 0")

(let ([code '(3 21 1008 21 8 20 1005 20 22 107 8 21 20 1006 20 31 
	1106 0 36 98 0 0 1002 21 125 20 4 20 1105 1 46 104 
	999 1105 1 46 1101 1000 1 20 4 20 1105 1 46 98 99)])
	(check-equal? (program-output code '(3)) '(999) "Example 7 - 999 if input below 8")
	(check-equal? (program-output code '(8)) '(1000) "Example 7 - 999 if input equal 8")
	(check-equal? (program-output code '(9)) '(1001) "Example 7 - 999 if input above 8")
)
