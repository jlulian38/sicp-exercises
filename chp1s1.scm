;; Exercise 1.1

10 ; 10
(+ 5 3 4) ; 12
(- 9 1) ; 8
(/ 6 2) ; 3
(+ (* 2 4) (- 4 6)) ; 10
(define a 3) ; Value: a
(define b (+ a 1)) ; Value: b
(+ a b (* a b)) ; 19
(= a b) ; #f
(if (and (> b a) (< b (* a b))) ; 4
    b
    a)
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a)) ; 16
      (else 25))
(+ 2 (if (> b a) b a)) ; 6
(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1)) ; 16

;; <- xscheme doesn't indent these!
;; Learned a little bit about the MIT Scheme REPL here

;; Exercise 1.2

(/
 (+ 5 4
    (- 2
       (- 3
          (+ 6
             (/ 4 5)))))
 (* 3
    (- 6 2)
    (- 2 7)))

;; Exercise 1.3

(define (sum-of-squares a b c)
  (+ (* a a) (* b b) (* c c)))

;;return me if in top two
;; otherwise 0
(define (am-top-two? me a b)
  (if (or (> me a) (> me b)) me 0))

;; This is the definition I'd like to use...
;; But I don't know anything about lists yet
;; (define (sum-of-squares-of-max a b c)
;;  (sum-of-squares (max-two a b c)))

(define (sum-of-squares-of-max a b c)
  (sum-of-squares
   (am-top-two? a b c)
   (am-top-two? b a c)
   (am-top-two? c a b)))

;; (sum-of-squares-of-max 1 2 3)
;; Value: 13
;; :+1: !


;; Exercise 1.4

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;; The first S-exp evaluates to a function!  And so we get the
;; behavior we expect giving the function name a + |b|

;; Exercise 1.5


(define (p) (p)) ; This is obviously ill-formed
;; The difference between a definition and a function definition is
;; subtle but seemingly important

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))

;; In MIT-Scheme this results in an infinite recursing loop!
;; Oopsie!

;; w/ Applicative order we see this non-terminating behavior
;; w/ Normal order never evaluates expr (p)


;; Section 1.1.7 Square root by newton's method


(define (square x) (* x x))


(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

;; Exercise 1.6

(define (new-if predicate
                then-clause
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (new-sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (new-sqrt-iter (improve guess x) x)))

;; new-sqrt-iter will not terminate because of applicative-order
;; evaluation in Scheme. The invocation of new-sqrt-iter will be
;; evaluated whether or not the predicate returns true and so it will
;; recurse forever.

;; Exercise 1.7

;; The good-enough? test does not perform well for small numbers
;; because we're looking at absolute error rather than relative error

;; A series of tests for small numbers
;; x | (/ 1.0 x)  | (sqrt (/ 1.0 (square x))
;; 1 | 1 | 1
;; 2 | .707107 | .5
;; 4 | .25 | .500152
;; 16 | .0625 | .250141
;; 256 | .00390625 | .0648198 :: starting to diverge
;; 65536 | .0000152587890625 | .03141243300537024 :: off by an order of magnitude!

;; It also does not perform well for large numbers because again we're
;; looking at absolute error, when it's actually relative to our input
;; size And so we actually never meet the good-enough? bounds. As
;; evidence by the non-terminating example below

;; For large numbers
;; x | (sqrt x))
;; 2.56e22 | 160000000000.
;; 6.556e44 | 2.56e22
;; 4.294967296e89 | not terminating

;; Implement approximation method looking for roots of derivative


;; What's a reasonable value for our error here?
(define (deriv-near-zero? guess last-guess x)
  (<
   (/
    (abs (- guess last-guess))
    guess)
   0.000001))


(define (sqrt-deriv-iter guess last-guess x)
  (if (deriv-near-zero? guess last-guess x)
      guess
      (sqrt-deriv-iter (improve guess x) guess x)))

(define (sqrt-deriv x)
  (sqrt-deriv-iter 1.0 0.0 x))

(sqrt-deriv (/ 1.0 65536.0))
;; Value: 3.906250000000099e-3
;; Much better performance!

(sqrt-deriv 4.294967296e89)
;; Value: 6.55360000000001e44 !

;; Exercise 1.8

;; Per the footnote it would be nice to implement this using a
;; higher-order abstraction...

(define (cb-improve guess x)
  (/ (+ (/ x
           (square guess))
        (* 2 guess))
     3))

(define (cbrt-deriv-iter guess last-guess x)
  (if (deriv-near-zero? guess last-guess x)
      guess
      (cbrt-deriv-iter (cb-improve guess x) guess x)))

(define (cbrt-deriv x)
  (cbrt-deriv-iter 1.0 0.0 x))

(cbrt-deriv 27.0)
;Value: 3.0000000000000977
