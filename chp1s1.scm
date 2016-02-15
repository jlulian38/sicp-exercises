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

;; The first S-exp evaluates to a function!
;; And so we get the behavior we expect giving the function name
;; a + |b|

;; Exercise 1.5


(define (p) (p)) ; This is obviously ill-formed
;; The difference between a definition and a function definition
;; is subtle but seemingly important

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))

;; In MIT-Scheme this results in an infinite recursing loop!
;; Oopsie!

;; w/ Applicative order we see this non-terminating behavior
;; w/ Normal order never evaluates expr (p)
