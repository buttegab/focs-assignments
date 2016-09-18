#lang racket

;;; Student Name: Frankly Olin [change to your name]
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___


(define (run-repl)
  (display "welcome to my repl.  type some scheme-ish:(operation) (variable look-up list if aplicable, else ())")
  (repl '()))

(define (repl curr_list)
  (display "> ")
  (display (calculate (read) curr_list))
  (newline)
  (repl '()))

(define operator-list
  (list (list 'ADD +)
        (list 'SUB -)
        (list 'MUL *)
        (list 'DIV /)
        (list 'GT >)
        (list 'LT <)
        (list 'GE >=)
        (list 'LE <=)
        (list 'EQ =)
        (list 'NEQ (lambda (x y) (not (= x y))))
        (list 'ANND (lambda (x y) (and x y)))
        (list 'ORR (lambda (x y) (or x y)))
        (list 'NOTT not)))

(define (assq key opList)
  ;(display (first(first opList)))) (newline)
  (display "got here") (newline)
  (if (eq? opList '()) #f (if (eq? (second key) (first opList)) (list (first key) (second opList) (third key)) (if (eq? (third key) (first opList)) 
  	(list (first key) (second key) (second opList)) (assq key (rest opList))))))
  

; (assq 'SUB operator-list) ;--> '(ADD #<procedure:+>)

(define (calculate x [look-up '()])
  (display x) (newline)
  (if (eq? look-up '()) (if (eq? (first x) 'DEFINE) (definer (second x) (third x)) (if (eq? (first x) 'ADD) (my_addition (rest x)) (if (eq? (first x) 'MUL) (my_multiplication (rest x)) (if (eq? (first x) 'SUB)
   (my_subtraction (rest x)) (if (eq? (first x) 'DIV) (my_division (rest x)) (if (eq? (first x) 'GT) (greater_than (rest x))
   (if (eq? (first x) 'LT) (less_than (rest x)) (if (eq? (first x) 'EQ) (equal_to (rest x)) (if (eq? (first x) 'ANND)
   (ander (rest x)) (if (eq? (first x) 'ORR) (orer (rest x)) (if (eq? (first x) 'NOTT) (noter (rest x)) (ifer (rest x))))))))))))) (calculate (assq x look-up))))

(define (my_addition x)
  (display "my addition: ")
  (display x) (newline)
  (if (integer? (first x)) (if (eq? (rest x) '()) (first x) (+ (first x) (my_addition (rest x)))) (if (eq? (rest x) '()) (calculate (first x))
  (+ (calculate (first x)) (if (integer? (first(rest x))) (first(rest x)) (calculate (first(rest x))))))))

(define (my_multiplication x)
  (if (integer? (first x)) (if (eq? (rest x) '()) (first x) (* (first x) (my_multiplication (rest x)))) (if (eq? (rest x) '()) (calculate (first x))
   (* (calculate (first x)) (if (integer? (first(rest x))) (first(rest x)) (calculate (first(rest x))))))))

(define (my_subtraction x)
  (if (integer? (first x)) (if (eq? (rest x) '()) (first x) (- (first x) (my_subtraction (rest x)))) (if (eq? (rest x) '()) (calculate (first x))
  (- (calculate (first x)) (if (integer? (first(rest x))) (first(rest x)) (calculate (first(rest x))))))))

(define (my_division x)
  (if (integer? (first x)) (if (eq? (rest x) '()) (first x) (/ (first x) (my_division (rest x)))) (if (eq? (rest x) '()) (calculate (first x))
  (/ (calculate (first x)) (if (integer? (first(rest x))) (first(rest x)) (calculate (first(rest x))))))))

(define (greater_than x)
  (if (integer? (first x)) (if (eq? (rest x) '()) (first x) (> (first x) (greater_than (rest x)))) (if (eq? (rest x) '()) (calculate (first x))
  (> (calculate (first x)) (if (integer? (first(rest x))) (first(rest x)) (calculate (first(rest x))))))))

(define (less_than x)
  (if (integer? (first x)) (if (eq? (rest x) '()) (first x) (< (first x) (less_than (rest x)))) (if (eq? (rest x) '()) (calculate (first x))
  (< (calculate (first x)) (if (integer? (first(rest x))) (first(rest x)) (calculate (first(rest x))))))))

(define (equal_to x)
  (if (integer? (first x)) (if (eq? (rest x) '()) (first x) (= (first x) (equal_to (rest x)))) (if (eq? (rest x) '()) (calculate (first x))
  (= (calculate (first x)) (if (integer? (first(rest x))) (first(rest x)) (calculate (first(rest x))))))))

(define (ander x)
  (if (integer? (first x)) (if (eq? (rest x) '()) (first x) (and (first x) (ander (rest x)))) (if (eq? (rest x) '()) (calculate (first x))
  (and (calculate (first x)) (if (integer? (first(rest x))) (first(rest x)) (calculate (first(rest x))))))))

(define (orer x)
  (if (integer? (first x)) (if (eq? (rest x) '()) (first x) (or (first x) (orer (rest x)))) (if (eq? (rest x) '()) (calculate (first x))
  (or (calculate (first x)) (if (integer? (first(rest x))) (first(rest x)) (calculate (first(rest x))))))))

(define (noter x)
  (if (integer? (first x)) (if (eq? (rest x) '()) (first x) (not (first x) (noter (rest x)))) (if (eq? (rest x) '()) (calculate (first x))
  (not (calculate (first x)) (if (integer? (first(rest x))) (first(rest x)) (calculate (first(rest x))))))))

(define (ifer x)
  (if (calculate (list-ref x 0)) (calculate (list-ref x 1)) (calculate(list-ref x 2))))

(define (definer var expression)
  ; (display expression) (newline) 
  (repl (list var (calculate expression)))
  
  )
  

(run-repl)
;(DEFINE x (ADD 1 2))  ;; adds a binding x --> 3
;(ADD x 3)