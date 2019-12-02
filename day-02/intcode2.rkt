#lang racket/base

(require racket/list
		 racket/string
		 racket/function
		 racket/trace)

(define (update-list op memory address)
  (list-set 
	memory 
	(list-ref memory (+ address 3))
	(run-op op memory)
	))

(define (op-addition address memory)
  (list 
	+ 
	(list-ref memory (+ address 1))
	(list-ref memory (+ address 2))
))

(define (op-multiplication address memory)
  (list 
	*
	(list-ref memory (+ address 1))
	(list-ref memory (+ address 2))
))

(define (get-parameter-values addresses memory)
  (map 
	  (lambda (address) (list-ref memory address))
	  addresses
  ))
	

(define (run-op opcode memory)
  (apply 
	(first opcode)
	(get-parameter-values (rest opcode) memory)
))

(define (run-program memory [instruction-pointer 0])
  (define (run-instruction opcode)
	(run-program 
	  (update-list opcode memory instruction-pointer)
	  (+ instruction-pointer (length opcode) 1) ; +1 because the update address is not part of the opcode
	  ))
  (let ([opcode (list-ref memory instruction-pointer)])
	(cond
			[(= opcode 99) memory]
			[(= opcode 1) (run-instruction (op-addition instruction-pointer memory))]
			[(= opcode 2) (run-instruction (op-multiplication instruction-pointer memory ))]
	     ))
	
	)

(define (try-program noun verb memory)
  (first (run-program (list-set (list-set memory 1 noun) 2 verb) )))

(define (read-program str)
  (map string->number (map string-trim (string-split str ","))))

(define (brute-force-solutions expected-result solution-function)
  (first (filter identity (for*/list ([noun (in-range 99)]
		 [verb (in-range 99)])
	(if (= expected-result (solution-function noun verb))
	  (list noun verb)
	  #f
	)
	))))

(provide update-list
		 op-addition
		 op-multiplication
		 run-op
		 run-program
		 read-program
		 try-program
		 brute-force-solutions)
