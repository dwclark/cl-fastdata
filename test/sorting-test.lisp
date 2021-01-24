;; sorting test

(in-package :cl-fastdata/test)

(defun fill-random (vec)
  (loop for i from 0 below (array-dimension vec 0)
        do (setf (aref vec i) (random 100000))
        finally (return vec)))

(deftest test-time-sorts ()
  (let ((vec (make-array 10000 :element-type 'fixnum)))
    (time (dotimes (n 5000)
            (fill-random vec)
            (sort vec #'<)))))

(define-quick-sort! fixnum-quick-sort! (:cmp - :element-type fixnum))

(deftest test-fixnum-quick-sort ()
  (let ((vec1 (make-array 10 :element-type 'fixnum :initial-contents '(1 3 5 7 9 0 2 4 6 8)))
        (vec2 (fill-random (make-array 10000 :element-type 'fixnum))))
    (fixnum-quick-sort! vec1)
    (is (sorted-p vec1 #'-))
    (fixnum-quick-sort! vec2)
    (is (sorted-p vec2 #'-))))

(deftest test-time-fixnum-quick-sort ()
  (let ((vec (make-array 10000 :element-type 'fixnum)))
    (time (dotimes (n 5000)
            (fill-random vec)
            (fixnum-quick-sort! vec)))))

(define-insertion-sort! double-insertion-sort! (:cmp - :element-type double-float))

(deftest test-double-float-insertion-sort ()
  (let ((vec (make-array 10 :element-type 'double-float :initial-contents '(1.23d0 5.67d0 2.37d0 9.99d0 5.66d0 4.33d0 1.22d0 8.0d0 8.1d0 7.9d0))))
    (double-insertion-sort! vec)
    (is (sorted-p vec #'-))))
