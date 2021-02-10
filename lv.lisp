(in-package #:lv)

(defun get-control-number (code)
  (let* ((multiplier '(1 6 3 7 9 10 5 8 4 2))
         (icode (mapcar #'digit-char-p (coerce code 'list)))
         (total (loop for n in icode
                      for m in multiplier
                      summing (* m n))))
    (mod (- 1101 total) 11)))

(defun generate ()
  (setf *random-state* (make-random-state t))
  (let* ((year (+ (random 101) 1900 (- (local-time:timestamp-year (local-time:today)) 2000)))
         (month (+ 1 (random 12)))
         (day (1+ (random (1- (local-time:days-in-month month year)))))
         (first-part (format nil "~d~2,'0d~2,'0d" day month (mod year 100)))
         (second-part (format nil "1~d" (+ 100 (random 900))))
         (code (format nil "~a~a" first-part second-part)))
    (format nil "~a-~a~d" first-part second-part (get-control-number code))))
