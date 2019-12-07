#lang racket/base

(require racket/list
		 racket/string
		 racket/function
		 racket/trace)

(define (read-memory memory address)
  (list-ref memory address))

(define (read-memory-pointer memory address)
  (list-ref memory (list-ref memory address)))

(define (write-to-memory memory address value)
  (list-set memory address value))

(define (op-addition memory address)
  (list 
	(lambda (v1 v2 write-address) (write-to-memory memory write-address (+ v1 v2)))
	(read-memory-pointer memory (+ address 1))
	(read-memory-pointer memory (+ address 2))
	(read-memory memory (+ address 3))
))

(define (op-multiplication memory address)
  (list 
	(lambda (v1 v2 write-address) (write-to-memory memory write-address (* v1 v2)))
	(read-memory-pointer memory (+ address 1))
	(read-memory-pointer memory (+ address 2))
	(read-memory memory (+ address 3))
))

(define (run-op opcode)
  (apply (first opcode) (rest opcode )))

(define (run-program memory [instruction-pointer 0])
  (define (run-instruction opcode)
	(run-program 
	  (run-op opcode)
	  (+ instruction-pointer (length opcode) )
	  ))
  (let ([opcode (list-ref memory instruction-pointer)])
	(cond
			[(= opcode 99) memory]
			[(= opcode 1) (run-instruction (op-addition memory instruction-pointer))]
			[(= opcode 2) (run-instruction (op-multiplication memory instruction-pointer))]
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

(provide op-addition
		 op-multiplication
		 run-op
		 run-program
		 read-program
		 try-program
		 brute-force-solutions)
