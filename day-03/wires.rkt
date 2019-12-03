#lang racket/base

(require racket/list
		 racket/string
		 racket/trace)

(struct posn (x y) #:transparent )
(struct line (a b direction) #:transparent )

(define (posn-add p1 p2)
  (posn (+ (posn-x p1) (posn-x p2)) (+ (posn-y p1) (posn-y p2))))

(define (posn-sub p1 p2)
  (posn (- (posn-x p1) (posn-x p2)) (- (posn-y p1) (posn-y p2))))

(define (create-line origin direction len)
  (cond 
	[(eq? "R" direction) (line origin (posn-add origin (posn len 0)) direction) ]
	[(eq? "L" direction) (line (posn-sub origin (posn len 0)) origin direction) ]
	[(eq? "U" direction) (line origin (posn-add origin (posn 0 len)) direction) ]
	[(eq? "D" direction) (line (posn-sub origin (posn 0 len)) origin direction) ]
	))

(define (create-instructions instruction-string)
  (map (lambda (instruction) (cons
		(substring instruction 0 1 ) 
		(string->number (substring instruction 1))) )
	   (string-split instruction-string ",")))

(define (create-lines instructions [lines '()])
  (if (null? instructions) 
	(reverse lines)
	(let ([instruction (first instructions)])
		(if (null? lines)
			(create-lines (rest instructions) (list (create-line (posn 0 0) (car instruction) (cdr instruction))))
			(create-lines (rest instructions) (cons 
				(create-line (new-origin (first lines)) (car instruction) (cdr instruction))
				lines))
	  )
	) 
  ))

(define (new-origin ln)
  (cond 
	[(eq? "R" (line-direction ln)) (line-b ln)]
	[(eq? "L" (line-direction ln)) (line-a ln)]
	[(eq? "U" (line-direction ln)) (line-b ln)]
	[(eq? "D" (line-direction ln)) (line-a ln)]
	))

; TODO (define (between-x l1 l2)) check if l2.x is between l1.a.x and l1.b.x 
; TODO (define (between-y l1 l2)) check if l2.y is between l1.a.y and l1.b.y 
;
; TODO Intersection (l1 l2) R,L:  cond ((and (is-vertical l2) (between-x l1 l2) (between-y l2 l1))
; TODO Intersection (l1 l2) U,D:  cond ((and (is-horizontal l2) (between-x l2 l1) (between-y l1 l2))

; TODO Interate over two lists of lines, returning a list of intersection points. Sum the x and y cooridnates of the points, pick the lowest sum as solution.

(provide

  line
  posn
  create-instructions
  create-line
  create-lines
  new-origin
  )
