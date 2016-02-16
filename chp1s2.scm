;; Section 2 Procedures and The Processes They Generate

;; Exercise 1.9

;; a
(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

;; a
(+ 4 5)
(if (= 4 0)
    5
    (inc (+ (dec 4) 5)))

(if (= 4 0)
    5
    (inc (+ 3 5)))

(if (= 4 0)
    5
    (inc (+
          ((if (= 3 0)
               5
               (+ (dec 3) 5))))))

(if (= 4 0)
    5
    (inc (+
          ((if (= 3 0)
               5
               (+ 2 5))))))

(if (= 4 0)
    5
    (inc (if (= 3 0)
              5
              (inc (if (= 2 0)
                       5
                       (inc (+ (dec 2) 5)))))))

(if (= 4 0)
    5
    (inc (if (= 3 0)
              5
              (inc (if (= 2 0)
                       5
                       (inc (+ (dec 2) 5)))))))

(if (= 4 0)
    5
    (inc (if (= 3 0)
              5
              (inc (if (= 2 0)
                       5
                       (inc (+ 1 5)))))))

(if (= 4 0)
    5
    (inc (if (= 3 0)
              5
              (inc (if (= 2 0)
                       5
                       (inc (if (= 1 0)
                                5
                                (inc (+ (dec 1) 5)))))))))

(if (= 4 0)
    5
    (inc (if (= 3 0)
              5
              (inc (if (= 2 0)
                       5
                       (inc (if (= 1 0)
                                5
                                (inc (+ 0 5)))))))))

(if (= 4 0)
    5
    (inc (if (= 3 0)
              5
              (inc (if (= 2 0)
                       5
                       (inc (if (= 1 0)
                                5
                                (inc (if (= 0 0)
                                         5
                                         (inc (+ (dec 0) 5)))))))))))

;; and now back again...

(if (= 4 0)
    5
    (inc (if (= 3 0)
              5
              (inc (if (= 2 0)
                       5
                       (inc (if (= 1 0)
                                5
                                (inc 5))))))))

(if (= 4 0)
    5
    (inc (if (= 3 0)
              5
              (inc (if (= 2 0)
                       5
                       (inc (if (= 1 0)
                                5
                                6)))))))

(if (= 4 0)
    5
    (inc (if (= 3 0)
              5
              (inc (if (= 2 0)
                       5
                       (inc 6))))))

(if (= 4 0)
    5
    (inc (if (= 3 0)
              5
              (inc (if (= 2 0)
                       5
                       7)))))

(if (= 4 0)
    5
    (inc (if (= 3 0)
              5
              (inc 7))))

(if (= 4 0)
    5
    (inc (if (= 3 0)
              5
              8)))


(if (= 4 0)
    5
    (inc 8))

(if (= 4 0)
    5
    9)

9

;; That was painful

;; b
(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

;; b

(+ 4 5)

(if (= 4 0)
    5
    (+ (dec 4) (inc 5)))

(if (= 4 0)
    5
    (+ 3 6))

;; We're going to behave tail-recursively and throw away the function
;; context that we don't need...
(if (= 3 0)
    6
    (+ (dec 3) (inc 6)))

(if (= 3 0)
    6
    (+ 2 7))

;; call
(if (= 2 0)
    7
    (+ (dec 2) (inc 7)))

(if (= 2 0)
    7
    (+ 1 8))

;; call
(if (= 1 0)
    8
    (+ (dec 1) (inc 8)))

(if (= 1 0)
    8
    (+ 0 9))

;; call
(if (= 0 0)
    9
    (+ (dec 0) (inc 9)))

9

;; Which is to say
;; a is a linearly recursive definition
;; b is a linearly iterative definition

;; Excercise 1.10

;; Ackerman's function

;; x, y form a complete state description
;; so this is an iterative process
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(A 1 10) ; 1024
;; 1 10
;; 0 (A 1 9)
;;    (A 0 (A 1 8))
;;     ... and so on 8 more times
;; 2 ^ 10 == 1024

(A 2 4) ; 65536
;; (A 1 (A 2 3))
;; (A 1 2^4)
;; (A 0 2^4)
;; 2^(2^4)

(A 3 3) ; 65536
;; 2^(2^(2^3))

(define (f n) (A 0 n)) ; = 2n
(define (g n) (A 1 n)) ; = 2^n
(define (h n) (A 2 n)) ; = 2^(2^n)
(define (k n) (* 5 n n)) ; As stated (k n) = 5n^2

;; My understanding differs from wikipedia
;; https://en.wikipedia.org/wiki/Ackermann_function
;; But perhaps their definition is different?
