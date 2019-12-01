#lang racket

(require "calc-fuel.rkt")

(display "Overall fuel required: ")
(displayln (calc-overall-fuel (map string->number (file->lines "input.txt"))))


