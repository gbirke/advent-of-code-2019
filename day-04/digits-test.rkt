#lang racket/base

(require rackunit
		 racket/list
         "digits.rkt")


(check-equal? (check-digit 122345) #t "ascending and duplicate digits")
(check-equal? (check-digit 123456) #f "only ascending and no duplicate digits")
(check-equal? (check-digit 322345) #f "descending and duplicate digits")
(check-equal? (check-digit 323457) #f "descending and no duplicate digits")

(check-equal? (add-repeating 1 '()) '((1)) "Add to empty list")
(check-equal? (add-repeating 1 '((1))) '((1 1)) "Add to existing list")
(check-equal? (add-repeating 1 '((1 1))) '((1 1 1)) "Add to existing list")
(check-equal? (add-repeating 2 '((1))) '((2)(1)) "Add to existing list")
