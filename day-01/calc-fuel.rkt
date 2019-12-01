#lang racket/base

; Calculate the fuel for a given mass
(define (calc-fuel module-mass) 
  (- 
	(floor (/ module-mass 3)) 
	2))

; Calculate the fuel for a given mass, incorporating the mass of the fuel
(define (calc-complete-fuel mass)
  (let ([fuel (calc-fuel mass)])
	(if (<= fuel 0)
	  0
	  (+ fuel (calc-complete-fuel fuel)))))

; Calculate the sum of needed fuel, without the additional fuel mass
(define (calc-overall-fuel module-masses) 
  (apply + (map calc-fuel module-masses)))

; Calculate the sum of needed fuel, with the additional fuel mass
(define (calc-overall-complete-fuel module-masses) 
  (apply + (map calc-complete-fuel module-masses)))

(provide calc-fuel
		 calc-complete-fuel
		 calc-overall-fuel
		 calc-overall-complete-fuel)
