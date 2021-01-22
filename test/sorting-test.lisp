;; sorting test

(in-package :cl-fastdata/test)

(deftest test-base-quick-sort ()
  (let ((vec (make-array 10 :element-type 'fixnum :initial-contents '(1 2 3 4 5 6 7 8 9 10)))
        (cmp #'-))
    (shuffle vec)
    (is (not (sorted-p vec cmp)))
    (is (sorted-p (quick-sort! vec cmp) cmp))))
