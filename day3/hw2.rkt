#lang racket

;;; Student Name: Gabriel Butterick
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [x] I completed this assignment with assistance from Joe Sutker, who helped me find a bug in problem 2.
;;;     and/or using these external resources: ___

;;; 1.  Create a calculator that takes one argument: a list that represents an expression.

(define (calculate x)
  ;(display x) (newline)
  (if (eq? (first x) 'ADD) (my_addition (rest x)) (if (eq? (first x) 'MUL) (my_multiplication (rest x)) (if (eq? (first x) 'SUB)
   (my_subtraction (rest x)) (if (eq? (first x) 'DIV) (my_division (rest x)) (if (eq? (first x) 'GT) (greater_than (rest x))
   (if (eq? (first x) 'LT) (less_than (rest x)) (if (eq? (first x) 'EQ) (equal_to (rest x)) (if (eq? (first x) 'ANND)
   (ander (rest x)) (if (eq? (first x) 'ORR) (orer (rest x)) (if (eq? (first x) 'NOTT) (noter (rest x)) (ifer (rest x)))))))))))))
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




(calculate '(ADD 3 4)) ;; --> 7

;;; 2. Expand the calculator's operation to allow for arguments that are themselves well-formed arithmetic expressions.



	(calculate '(GT (ADD 3 4) (MUL 5 6))) ;; --> #f
	(calculate '(LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6))))) ;; --> #t

;;; 4. Add boolean operations ANND, ORR, NOTT

(calculate '(ANND (GT (ADD 3 4) (MUL 5 6)) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6)))))) ;; --> #f
<<<<<<< HEAD
=======
(calculate '(NOTT (ANND (GT (ADD 3 4) (MUL 5 6)) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6))))))) ;; --> #t
>>>>>>> 57dba957e7d9e8a93ae37001b2768555208e796e

;;; 5. Add IPH

(calculate '(IPH (GT (ADD 3 4) 7) (ADD 1 2) (ADD 1 3))) ;; -> 4
