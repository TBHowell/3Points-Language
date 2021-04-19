; Trent Howell
; Threepoints.scm
(define (make-point x-cor y-cor)
 (cons x-cor y-cor)
)

(define (getx p)
  (car p)
)

(define (gety p)
  (cdr p)
)

(define (distance p1 p2)
  (sqrt
    (+
      (expt (- (getx p1) (getx p2)) 2)
      (expt (- (gety p1) (gety p2)) 2)
    )
  )
)

(define (slope p1 p2)
  (if (eqv? (= (- (getx p1) (getx p2)) 0) #f)
    (/
      (- (gety p1) (gety p2))
      (- (getx p1) (getx p2))
    )
  )
)

(define (vertical p1 p2 p3)
  (if (= (getx p1) (getx p2))
    (if (= (getx p1) (getx p3))
      #t
      #f
    )
  #f
  )
)

(define (horizontal p1 p2 p3)
  (if (= (gety p1) (gety p2))
    (if (= (gety p1) (gety p3))
      #t
      #f
    )
  #f
  )
)

(define (same-slope p1 p2 p3)
  (= (slope p1 p2) (slope p2 p3))
)

(define (is-line p1 p2 p3)
  (if (eqv? (vertical p1 p2 p3) #f)
    (if (eqv? (horizontal p1 p2 p3) #f)
      (if (eqv? (same-slope p1 p2 p3) #f)
        #f
        #t
      )
    #t
    )
  #t
  )
)

(define (is-triangle p1 p2 p3)
  (if (eqv? (is-line p1 p2 p3) #f)
    #t
    #f
  )
)

(define (perimeter p1 p2 p3)
  (if (is-triangle p1 p2 p3)
    (+
      (distance p1 p2)
      (+
        (distance p2 p3)
        (distance p1 p3)
      )
    )
    0
  )
)

(define (s-perimeter p1 p2 p3)
  (/
    (perimeter p1 p2 p3)
    2
  )
)

(define (area p1 p2 p3)
  (if (is-triangle p1 p2 p3)
    (sqrt
      (*
      (s-perimeter p1 p2 p3)
        (*
          (-
            (s-perimeter p1 p2 p3)
            (distance p1 p2)
          )
          (*
            (-
              (s-perimeter p1 p2 p3)
              (distance p2 p3)
            )
            (-
              (s-perimeter p1 p2 p3)
              (distance p1 p3)
            )
          )
        )
      )
    )
    0
  )
)

(define (angle p1 p2 p3)
  (acos
    (/
      (-
        (+
          (expt (distance p2 p3) 2)
          (expt (distance p1 p2) 2)
        )
        (expt (distance p1 p3) 2)
      )
      (*
        (*
          (distance p2 p3)
          (distance p1 p2)
        )
        2
      )
    )
  )
)

(define (calculate-triangle p1 p2 p3)
  (display "Side 1 = ")
  (display (distance p1 p2))
  (newline)
  (display "Side 2 = ")
  (display (distance p2 p3))
  (newline)
  (display "Side 3 = ")
  (display (distance p3 p2))
  (newline)
  (display "Perimeter = ")
  (display (perimeter p1 p2 p3))
  (newline)
  (display "Area = ")
  (display (area p1 p2 p3))
  (newline)
  (display "Angle 1 = ")
  (display (angle p2 p3 p1))
  (display " ")
  (display (* (angle p2 p3 p1) 57.2958))
  (newline)
  (display "Angle 2 = ")
  (display (angle p3 p1 p2))
  (display " ")
  (display (* (angle p3 p1 p2) 57.2958))
  (newline)
  (display "Angle 3 = ")
  (display (angle p1 p2 p3))
  (display " ")
  (display (* (angle p1 p2 p3) 57.2958))
  (newline)
)
