;; sorting

(in-package :cl-fastdata)

(defun sorted-p (vec cmp)
  (loop for i from 0 below (1- (length vec))
        do (if (< 0 (funcall cmp (aref vec i) (aref vec (1+ i))))
               (return nil))
        finally (return t)))

(defun random-in-interval (left right)
  (if (= left right)
      left
      (+ left (random (- right left)))))

(defun partition! (vec cmp left right pivot-index)
  (let ((pivot (aref vec pivot-index)))
    (rotatef (aref vec right) (aref vec pivot-index))
    (loop with store = left
          for idx from left below right
          do (progn
               (when (< (funcall cmp (aref vec idx) pivot) 0)
                 (rotatef (aref vec idx) (aref vec store))
                 (incf store)))
          finally (progn
                    (rotatef (aref vec right) (aref vec store))
                    (return store)))))

(defun quick-sort! (vec cmp)
  (labels 
      ((internal-quick-sort (left right)
	     (if (> right left)
             (let ((pivot-index (partition! vec cmp left right (random-in-interval left right))))
               (internal-quick-sort left (1- pivot-index))
               (internal-quick-sort (1+ pivot-index) right)))))
    
    (internal-quick-sort 0 (1- (length vec))))
  vec)
    

