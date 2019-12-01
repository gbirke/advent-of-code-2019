#lang racket

(require "calc-fuel.rkt")

(let ([module-masses (map string->number (file->lines "input.txt"))])
	(display "Base fuel required for module mass:          ")
	(displayln (calc-overall-fuel module-masses))

	(display "Fuel required for module mass and fuel mass: ")
	(displayln (calc-overall-complete-fuel module-masses))
)


