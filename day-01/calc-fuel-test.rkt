#lang racket/base

(require rackunit
         "calc-fuel.rkt")


(check-equal? (calc-fuel 12) 2 "Mass of 12")
(check-equal? (calc-fuel 14) 2 "Mass of 14")
(check-equal? (calc-fuel 1969) 654 "Mass of 1969")
(check-equal? (calc-fuel 100756) 33583 "Mass of 100756")


(check-equal? (calc-overall-fuel '(12 14 1969 100756)) 34241 "Overall fuel calculation")
