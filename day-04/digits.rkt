#lang racket/base

(require racket/trace)


(define (get-last-digit digit)
  (modulo digit 10) )

(define (check-digit digit [has-repeating #f] [prev-digit 10])
  (if (= 0 digit)
	has-repeating
	(let ([last-digit (get-last-digit digit)])
		(if (> last-digit prev-digit )
		  #f
		  (check-digit 
			(floor (/ digit 10)) 
			(or has-repeating (eq? prev-digit last-digit ) )
			last-digit
			))
	)))


(provide check-digit)
