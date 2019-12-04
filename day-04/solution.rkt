#lang racket/base

(require racket/list
         "digits.rkt")

(define (b2i b)
  (if b 1 0))

(define (collect-digits)
  (for/sum ([n (in-range 272091 815432)])
	(b2i (check-digit n))))

(printf "found ~a matching digits ~n" (collect-digits) )


