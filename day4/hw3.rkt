#lang racket

;;; Student Name: Gabriel Butterick
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [x] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___I don't know if this counts, but I used the provided operator-list code

;;;;;;;;;;;
;; 1. assq

;; `assq` is a function that takes a key and an association list.
;;
;; It returns the corresponding key/value pair from the list
;; (*i.e.*, the pair whose key is *eq?* to the one it is given).
;;
;; If the key is not found in the list, `assq` returns `#f`.
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
  (if (eq? opList '()) #f (if (eq? key (first(first opList))) (second (first opList)) (assq key (rest opList)))))

(assq 'SUB operator-list) ;--> '(ADD #<procedure:+>)

(define (calculate x look-up)
  ;(display x) (newline)
  (if (eq? look-up '()) (if (eq? (first x) 'ADD) (my_addition (rest x)) (if (eq? (first x) 'MUL) (my_multiplication (rest x)) (if (eq? (first x) 'SUB)
   (my_subtraction (rest x)) (if (eq? (first x) 'DIV) (my_division (rest x)) (if (eq? (first x) 'GT) (greater_than (rest x))
   (if (eq? (first x) 'LT) (less_than (rest x)) (if (eq? (first x) 'EQ) (equal_to (rest x)) (if (eq? (first x) 'ANND)
   (ander (rest x)) (if (eq? (first x) 'ORR) (orer (rest x)) (if (eq? (first x) 'NOTT) (noter (rest x)) (ifer (rest x)))))))))))) (assq x look-up)))
(define (my_addition x)
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

;if calculate x[0] then calculate x[1] else calulate x[2]
(define (ifer x)
  (if (calculate (list-ref x 0)) (calculate (list-ref x 1)) (calculate(list-ref x 2))))
;;;;;;;;;;;
;; 2. lookup-list

;; Add the ability to look up symbols to your evaluator.
;;
;; Add the `lookup-list` argument to your hw2 evaluator (or ours, from the solution set).
;; `(evaluate 'foo lookup-list)` should return whatever `'foo` is associated with in `lookup-list`.

(calculate 'y '((x 3) (y 12) (z 2)))
