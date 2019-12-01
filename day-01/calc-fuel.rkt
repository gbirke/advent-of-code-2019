#lang racket/base

(define (calc-fuel module-mass) 
  (- 
	(floor (/ module-mass 3)) 
	2))

(define (calc-overall-fuel module-masses) 
  (apply + (map calc-fuel module-masses)))

(provide calc-fuel
		 calc-overall-fuel)
