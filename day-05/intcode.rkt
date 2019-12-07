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

(define p1-digit 3)
(define p2-digit 4)

(define (nth-digit num n)
  (floor (/
		   (modulo num (expt 10 n ))
		   (expt 10 (- n 1))
		   )))


(define (get-mode opcode mode-position)
  (let ([mode-digit (nth-digit opcode mode-position)])
	(cond 
	  [(= 0 mode-digit) read-memory-pointer]
	  [(= 1 mode-digit) read-memory]
	)
  ))

(define (op-addition memory address input output)
  (let* ([opcode (read-memory memory address)]
		 [p1 (get-mode opcode p1-digit)]
		 [p2 (get-mode opcode p2-digit)])
	(list 
	  (write-to-memory
		memory 
		(read-memory memory (+ address 3))
		(+
			(p1 memory (+ address 1))
			(p2 memory (+ address 2))
		)
	   )
	   (+ address 4)
	   input
	   output
	)
))

(define (op-multiplication memory address input output)
  (let* ([opcode (read-memory memory address)]
		 [p1 (get-mode opcode p1-digit)]
		 [p2 (get-mode opcode p2-digit)])
	(list 
	  (write-to-memory
		memory 
		(read-memory memory (+ address 3))
		(*
			(p1 memory (+ address 1))
			(p2 memory (+ address 2))
		)
	   )
	   (+ address 4)
	   input
	   output
	)
))

(define (op-input memory address input output)
  (list
	(write-to-memory
	  memory
	  (read-memory memory (+ address 1))
	  (first input)
	)
	(+ address 2)
	(rest input)
	output
))

(define (op-output memory address input output)
  (let* ([opcode (read-memory memory address)]
		 [p1 (get-mode opcode p1-digit)])
  	(list
	  memory
	  (+ address 2 )
	  input
	  (cons (p1 memory (+ address 1)) output)
)))

(define (op-jump-if-true memory address input output)
  (let* ([opcode (read-memory memory address)]
		 [p1 (get-mode opcode p1-digit)]
		 [p2 (get-mode opcode p2-digit)])
	(if (eq? 0 (p1 memory (+ address 1)))
	  (list memory (+ address 3) input output )
	  (list memory (p2 memory (+ address 2)) input output )
	)
))

(define (op-jump-if-zero memory address input output)
  (let* ([opcode (read-memory memory address)]
		 [p1 (get-mode opcode p1-digit)]
		 [p2 (get-mode opcode p2-digit)])
	(if (eq? 0 (p1 memory (+ address 1)))
	  (list memory (p2 memory (+ address 2)) input output )
	  (list memory (+ address 3) input output )
	)
))

(define (run-program memory [instruction-pointer 0] [input '()] [output '()] )
  (let ([opcode (read-memory memory instruction-pointer)])
	(cond
			[(= 99 opcode) (list output input memory)]
			[(= 1 (nth-digit opcode 1)) (apply run-program (op-addition memory instruction-pointer input output))]
			[(= 2 (nth-digit opcode 1)) (apply run-program (op-multiplication memory instruction-pointer input output))]
			[(= 3 opcode)               (apply run-program (op-input memory instruction-pointer input output))]
			[(= 4 (nth-digit opcode 1)) (apply run-program (op-output memory instruction-pointer input output))]
			[(= 5 (nth-digit opcode 1)) (apply run-program (op-jump-if-true memory instruction-pointer input output))]
			[(= 6 (nth-digit opcode 1)) (apply run-program (op-jump-if-zero memory instruction-pointer input output))]
			[else (printf "Unkown opcode ~a at counter ~a~n" opcode instruction-pointer)]
	     ))
	
	)
(trace run-program)

(define (read-program str)
  (map string->number (map string-trim (string-split str ","))))

(provide op-addition
		 op-multiplication
		 run-program
		 read-program
		 nth-digit
		 )
