#lang racket/base

(require rackunit
		 racket/list
         "intcode.rkt")

(let ([start-io (create-io '(42 23))])
  (check-equal? (apply (first start-io) '() ) '((42 23) ()) "starts with empty io" )
  (apply (second start-io) (list (lambda (first-input-io input-value) 
	  (check-equal? input-value 42 "First input value" )
	  (check-equal? (apply (first first-input-io) '() ) '((23) ()) "reads io")
	  (let ([first-output-io (apply (third first-input-io) (list (lambda () 4711)))])
		  (check-equal? (apply (first first-output-io) '() ) '((23) (4711)) "appends to output" )
		  (let ([second-output-io (apply (third first-output-io) (list (lambda () 128)))])
			  (check-equal? (apply (first second-output-io) '() ) '((23) (128 4711)) "appends to output" )
		  )
	  )
	  (apply (second first-input-io) (list (lambda (second-input-io input-value)
    	  (check-equal? input-value 23 "Second input value" )
		  (check-equal? (apply (first second-input-io) '() ) '(() ()) "reads io" )
	  )))
  )))
  ; Check without apply
  (io-get-input start-io (lambda (first-input-io input-value)
	(check-equal? input-value 42 "First input value")
	(check-equal? (io-get-state first-input-io) '((23) ()))
  ))
)

(let ([opcode (op-input '(3 2 0) 0 42)])
	(check-equal? (run-op opcode) '(3 2 42) "Input writes signified address")
)

(let ([opcode (op-output '(4 2 0) 0)])
	(check-equal? (run-op opcode) '(4 2 0) "output leaves memory as-is")
)
(check-equal? (run-program '(3 0 3 1 99) (create-io '(42 23))) '(() () (42 23 3 1 99)) "Input writes input at address")
(check-equal? (run-program '(4 0 4 4 99) (create-io '())) '((99 4) () (4 0 4 4 99)) "Output reads from address")


