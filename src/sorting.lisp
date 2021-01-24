;; sorting

(in-package :cl-fastdata)

(defun sorted-p (vec cmp)
  (loop for i from 0 below (1- (length vec))
        do (if (< 0 (funcall cmp (aref vec i) (aref vec (1+ i))))
               (return nil))
        finally (return t)))

(defmacro random-in-interval (left right)
  (once-only (left right)
    `(if (= ,left ,right)
         ,left
         (+ ,left (random (- ,right ,left))))))

(defmacro partition! (vec cmp left right pivot-index)
  (once-only (left right pivot-index)
    (with-unique-names ((pivot "pivot"))
      `(let ((,pivot (aref ,vec ,pivot-index)))
         (rotatef (aref ,vec ,right) (aref ,vec ,pivot-index))
         (loop with store = ,left
               for idx from ,left below ,right
               do (when (< (,cmp (aref ,vec idx) ,pivot) 0)
                    (rotatef (aref ,vec idx) (aref ,vec store))
                    (incf store))
               finally (progn
                         (rotatef (aref ,vec ,right) (aref ,vec store))
                         (return store)))))))

(defmacro define-quick-sort! (name (&key cmp element-type))
  `(progn
     (declaim (ftype (function ((simple-array ,element-type *)) (simple-array ,element-type *)) ,name))
     (defun ,name (vec)
       (declare (optimize speed (safety 0)))
       (labels 
           ((internal-quick-sort (left right)
              (declare (fixnum left right))
              (if (< left right)
                  (let ((pivot-index (partition! vec ,cmp left right (random-in-interval left right))))
                    (internal-quick-sort left (1- pivot-index))
                    (internal-quick-sort (1+ pivot-index) right)))))
         
         (internal-quick-sort 0 (1- (length vec))))
       vec)))

(declaim (ftype (function ((simple-array fixnum *) (function (fixnum fixnum) fixnum) &key (:start fixnum) (:end fixnum))) insertion-sort!))
(defun insertion-sort! (vec cmp &key (start 1) (end (length vec)))
  (loop for j fixnum from start below end
        do (loop with i fixnum = (1- j)
                 with value = (aref vec j)
                 while (and (> i -1) (< (funcall cmp value (aref vec i)) 0))
                 do (progn
                      (setf (aref vec (1+ i)) (aref vec i))
                      (decf i))
                 finally (setf (aref vec (1+ i)) value)))
  vec)

(defmacro define-insertion-sort! (name (&key cmp element-type))
  `(progn
     (declaim (ftype (function ((simple-array ,element-type *) &key (:start fixnum) (:end fixnum))) ,name))
     (defun ,name (vec &key (start 1) (end (length vec)))
       (declare (optimize speed (safety 0)))
       (loop for j fixnum from start below end
             do (loop with i fixnum = (1- j)
                      with value ,element-type = (aref vec j)
                      while (and (> i -1) (< (,cmp value (aref vec i)) 0))
                      do (progn
                           (setf (aref vec (1+ i)) (aref vec i))
                           (decf i))
                      finally (setf (aref vec (1+ i)) value)))
       vec)))

