
#lang racket/base

(require rackunit
         "wires.rkt")


(check-equal? (create-line (posn 0 0) "R" 5) (line (posn 0 0) (posn 5 0) "R") "Right")
(check-equal? (create-line (posn 5 1) "R" 5) (line (posn 5 1) (posn 10 1) "R") "Right")
(check-equal? (create-line (posn 0 0) "L" 5) (line (posn -5 0) (posn 0 0) "L") "Left")
(check-equal? (create-line (posn 5 1) "L" 5) (line (posn 0 1) (posn 5 1) "L") "Left")
(check-equal? (create-line (posn 0 0) "U" 5) (line (posn 0 0) (posn 0 5) "U") "Up")
(check-equal? (create-line (posn 5 1) "U" 5) (line (posn 5 1) (posn 5 6) "U") "Up")
(check-equal? (create-line (posn 0 0) "D" 5) (line (posn 0 -5) (posn 0 0) "D") "Down")
(check-equal? (create-line (posn 5 1) "D" 5) (line (posn 5 -4) (posn 5 1) "D") "Down")

(check-equal? (new-origin (line (posn 0 0) (posn 5 0) "R")) (posn 5 0) "New orgin right line")
(check-equal? (new-origin (line (posn 0 0) (posn 5 0) "L")) (posn 0 0) "New orgin left line")
(check-equal? (new-origin (line (posn 0 0) (posn 0 5) "U")) (posn 0 5) "New orgin up line")
(check-equal? (new-origin (line (posn 0 0) (posn 0 5) "D")) (posn 0 0) "New orgin down line")

(check-equal? (create-instructions "R5,U5,L2,D20") (list 
	(cons "R" 5)
	(cons "U" 5)
	(cons "L" 2)
	(cons "D" 20)
													 ) "Instructions")
(check-equal? (create-lines (list (cons "R" 10 ))) (list
	(line (posn 0 0) (posn 10 0) "R")) "First line has 0 0 origin")
(check-equal? (create-lines (list (cons "R" 10 ) (cons "U" 7))) (list
	(line (posn 0 0) (posn 10 0) "R")
	(line (posn 10 0) (posn 10 7) "U")) "Second line has first lin origin")
;(check-equal? (create-lines (create-instructions "R5,U5,L2,D20")) (list
;	(line (posn 0 0) (posn 5 0) "R")
;	(line (posn 0 5) (posn 5 5) "U")
;	(line (posn 3 5) (posn 5 5) "L")
;	(line (posn 3 -15) (posn 3 5) "D20")
;	) "Create lines from string" )
;	
