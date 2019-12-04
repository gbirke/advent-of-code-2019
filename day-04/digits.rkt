#lang racket/base

(require racket/trace
		 racket/list)


(define (get-last-digit digit)
  (modulo digit 10) )

(define (has-two-elements lst)
  (eq? 2 (length lst)))

(define (add-repeating digit lst)
  (if (null? lst)
	(list (list digit))
	(let ([first-digit (first (first lst) )])
	  (if (eq? first-digit digit )
		(cons (append (list digit) (first lst)) (rest lst))
		(cons (list digit) lst)
		)
	  )
	)
  )

(define (check-digit digit [repeating '()] [prev-digit 10])
  (if (= 0 digit)
	(not (null? (filter has-two-elements repeating)))
	(let ([last-digit (get-last-digit digit)])
		(if (> last-digit prev-digit )
		  #f
		  (check-digit 
			(floor (/ digit 10))
			(add-repeating last-digit repeating)
			last-digit
			))
	)))
;(trace check-digit)

(provide add-repeating check-digit)
