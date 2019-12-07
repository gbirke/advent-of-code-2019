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

(define (op-input memory address value)
  (list
	(lambda (write-address) (write-to-memory memory write-address value))
	(read-memory memory (+ address 1))
))

(define (op-output memory address)
  (list
	(lambda (output-address) memory)
	(read-memory memory (+ address 1))
))

(define (run-op opcode)
  (apply (first opcode) (rest opcode )))

(define (run-program memory io [instruction-pointer 0])
  (define (run-instruction opcode new-io)
	(run-program 
	  (run-op opcode)
	  new-io
	  (+ instruction-pointer (length opcode) )
	  ))
  (let ([opcode (list-ref memory instruction-pointer)])
	(cond
			[(= opcode 99) (let ([state (io-get-state io )]) (append (reverse state) (list memory)))]
			[(= opcode 1) (run-instruction (op-addition memory instruction-pointer io))]
			[(= opcode 2) (run-instruction (op-multiplication memory instruction-pointer io))]
			[(= opcode 3) (io-get-input io (lambda (new-io input-value)
							(run-instruction 
							  (op-input memory instruction-pointer input-value)
							  new-io))) ]
			[(= opcode 4) (let ([op (op-output memory instruction-pointer)])
							 (run-instruction 
							   op 
							   (io-write-output io (lambda () 
													 (read-memory memory (second op)) )
								))
							 )]
	     ))
	
	)

; Wrap input and output state in callbacks
(define (create-io [current-input '()] [current-output '()] )
  (define (read-input fn)
	(fn (create-io (rest current-input) current-output) (first current-input))
  )
  (define (write-output fn)
	(create-io current-input (cons (apply fn '()) current-output))
  )
  (define (current) (list current-input current-output))
  (list current read-input write-output)
)

(define (io-get-state io) (apply (first io) '()))

(define (io-get-input io fn) 
	(apply (second io) (list fn)))

(define (io-write-output io fn) 
	(apply (third io) (list fn)))

(define (read-program str)
  (map string->number (map string-trim (string-split str ","))))

(provide op-addition
		 op-multiplication
		 op-input
		 op-output
		 run-op
		 run-program
		 read-program
		 create-io
		 io-get-input
		 io-get-state
		 )
