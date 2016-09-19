#lang racket

;;; Student Name: Gabriel Butterick [change to your name]
;;;
;;; Check one:
;;; [x] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___


(define (run-repl)
  (display "welcome to my repl.  type some scheme-ish:(operation) (variable look-up list if aplicable, else ())")
  (repl '()))

(define (repl curr_list)
  (display "> ")
  (display (calculate (read) curr_list))
  (newline)
  (repl curr_list))

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
  (display opList) (newline)
  (if (eq? opList '()) #f (if (eq? (second key) (first (first opList))) (list (first key) (second (first opList)) (third key)) (if (eq? (third key) (first (first opList))) 
  	(list (first key) (second key) (second (first opList))) (assq key (rest opList))))))
  

; (assq 'SUB operator-list) ;--> '(ADD #<procedure:+>)
; (and (integer? (second x)) (or (integer? (third x)) (list? (third x))))

(define (calculate x [look-up '()])
  (display x) (newline)
  (if (or (and (or (integer? (second x)) (list? (third x))) (or (integer? (third x)) (list? (third x)))) (or (eq?  (first x) 'DEFINE)) (eq?  (first x) 'LAMBDA)) (if (list? (first x)) (l-func x look-up) 
  	(if (eq? (first x) 'DEFINE) (definer (second x) (third x) look-up) (if (eq? (first x) 'ADD) (my_addition (rest x) look-up) (if (eq? (first x) 'MUL) 
  	(my_multiplication (rest x) look-up) (if (eq? (first x) 'SUB)
   (my_subtraction (rest x) look-up) (if (eq? (first x) 'DIV) (my_division (rest x)) (if (eq? (first x) 'GT) (greater_than (rest x))
   (if (eq? (first x) 'LT) (less_than (rest x)) (if (eq? (first x) 'EQ) (equal_to (rest x)) (if (eq? (first x) 'ANND)
   (ander (rest x)) (if (eq? (first x) 'ORR) (orer (rest x)) (if (eq? (first x) 'NOTT) (noter (rest x)) (ifer (rest x)))))))))))))) (calculate (assq x look-up) look-up)))

(define (my_addition x look-up)
  (display "my addition: ")
  (display x) (newline)
  (if (integer? (first x)) (if (eq? (rest x) '()) (first x) (+ (first x) (my_addition (rest x) look-up))) (if (eq? (rest x) '()) (calculate (first x) look-up)
  (+ (calculate (first x) look-up) (if (integer? (first(rest x))) (first(rest x)) (calculate (first(rest x)) look-up))))))

(define (my_multiplication x look-up)
  (if (integer? (first x)) (if (eq? (rest x) '()) (first x) (* (first x) (my_multiplication (rest x) look-up))) (if (eq? (rest x) '()) (calculate (first x) look-up)
   (* (calculate (first x) look-up) (if (integer? (first(rest x))) (first(rest x)) (calculate (first(rest x)) look-up))))))

(define (my_subtraction x look-up)
  (if (integer? (first x)) (if (eq? (rest x) '()) (first x) (- (first x) (my_subtraction (rest x) look-up))) (if (eq? (rest x) '()) (calculate (first x) look-up)
  (- (calculate (first x) look-up) (if (integer? (first(rest x))) (first(rest x)) (calculate (first(rest x)) look-up))))))

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

(define (definer var expression curr_list)
  (display "definer called") (newline) 
  (display var) (newline) 
  (display expression) (newline)
  (if (integer? expression) (repl (append curr_list (list(list var expression)))) (repl (append curr_list (list (list var (calculate expression))))))   
  )

(define (l-func x curr_list)
	(display "lambda called")
	; (append x curr_list)
	(l-repl (append curr_list (map list (second (first x)) (if (integer? (second x)) (if (integer? (third x)) (list (second x) (third x)) (list (second x) 
		(calculate (third x)))) (list (calculate (second x)) (if (integer? (third x)) (third x) (calculate (third x))))))) (third (first x)))
	)

(define (l-repl curr_list expression)
  (display curr_list) (newline)
  (display expression) (newline)
  (display (calculate expression curr_list))
  (newline)
  (repl curr_list))


(run-repl)
;(DEFINE x (ADD 1 2))  ;; adds a binding x --> 3
;(ADD x 3)
;(LAMBDA (a b) (ADD a b))
;(lambda (a b) (ADD a b) ((x 3) (y 2)))
; ((LAMBDA (x y) (ADD (MUL x x) (MUL y y))) 2 (SUB 4 1))
;13