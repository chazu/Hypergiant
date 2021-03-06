;;;; math.scm

;;;; Math utilities
;;;; Imported by hypergiant.scm

(export random-normal
        random-float
        clamp
        vclamp
        vclamp!
        v/
        vround
        vceiling
        vtruncate
        vfloor)

(use random-mtzig)

(define random-state (random-mtzig:init))

(define (random-normal #!optional (mean 0 ) (variance 1))
  (+ mean
     (* (random-mtzig:randn! random-state)
        variance)))

(define (random-float)
  (- (* 2 (f32vector-ref (random-mtzig:f32vector-randu! 1 random-state) 0))
     1))

(define (clamp x l u)
  (min (max x l) u))

;; TODO vector operations could match gl-math better: optional return arguments that dictate where the result is created
(define (vclamp v l u #!optional non-gc?)
  (make-point (clamp (point-x v) l u)
              (clamp (point-y v) l u)
              (clamp (point-z v) l u)
              non-gc?))

(define (vclamp! v l u)
  (point-x-set! (clamp (point-x v) l u))
  (point-y-set! (clamp (point-y v) l u))
  (point-z-set! (clamp (point-z v) l u)))

(define (v/ v s #!optional result)
  (let ((r (/ s)))
    (v* v r result)))

(define (vround v #!optional non-gc?)
  (make-point (round (point-x v))
              (round (point-y v))
              (round (point-z v))
              non-gc?))

(define (vfloor v #!optional non-gc?)
  (make-point (floor (point-x v))
              (floor (point-y v))
              (floor (point-z v))
              non-gc?))

(define (vceiling v #!optional non-gc?)
  (make-point (ceiling (point-x v))
              (ceiling (point-y v))
              (ceiling (point-z v))
              non-gc?))

(define (vtruncate v #!optional non-gc?)
  (make-point (truncate (point-x v))
              (truncate (point-y v))
              (truncate (point-z v))
              non-gc?))
