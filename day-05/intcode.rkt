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

(define (run-program memory [input '()] [output '()] [instruction-pointer 0])
  (define (run-instruction opcode)
	(run-program 
	  (run-op opcode)
	  input
	  output
	  (+ instruction-pointer (length opcode) )
	  ))
  (define (run-input)
	(run-program
	  (write-to-memory
		memory 
		(read-memory memory (+ instruction-pointer 1))
		(first input)
		)
	  (rest input)
	  output
	  (+ instruction-pointer 2 )
	))
  (define (run-output)
  	(run-program
	  memory
	  input
	  (cons (read-memory-pointer memory (+ instruction-pointer 1)) output)
	  (+ instruction-pointer 2 )
	  ))
  (let ([opcode (list-ref memory instruction-pointer)])
	(cond
			[(= opcode 99) (list output input memory)]
			[(= opcode 1) (run-instruction (op-addition memory instruction-pointer))]
			[(= opcode 2) (run-instruction (op-multiplication memory instruction-pointer))]
			[(= opcode 3) (run-input)]
			[(= opcode 4) (run-output)]
	     ))
	
	)

(define (read-program str)
  (map string->number (map string-trim (string-split str ","))))

(provide op-addition
		 op-multiplication
		 run-op
		 run-program
		 read-program
		 )
