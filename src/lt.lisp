(in-package #:lt)

(defun get-gender-code (gender year)
  (case gender
    (0 (cond ((<= 1900 year 1999) 4)
             ((<= 2000 year 2099) 6)))
    (1 (cond ((<= 1900 year 1999) 3)
             ((<= 2000 year 2099) 5)))))

(defun get-control-number (code)
  (let ((icode (mapcar #'digit-char-p (coerce code 'list)))
        (b 1)
        (c 3)
        (d 0)
        (e 0))
    (loop for i from 0 below 10
          for n in icode
          do
             (setf d (+ d (* n b)))
             (setf e (+ e (* n c)))
             (setf b (if (= b 9) 1 (1+ b)))
             (setf c (if (= c 9) 1 (1+ c))))
    (let ((d (mod d 11))
          (e (mod e 11)))
      (if (< d 10)
          d
          (if (< e 10)
              e
              0)))))

(defun generate ()
  (setf *random-state* (make-random-state t))
  (let* ((gender (random 2))
         (year (+ (random 101) 1900 (- (local-time:timestamp-year (local-time:today)) 2000)))
         (month (+ 1 (random 12)))
         (day (1+ (random (1- (local-time:days-in-month month year)))))
         (gender-code (get-gender-code gender year))
         (serial-number (random 1000))
         (code (format nil "~d~d~2,'0d~2,'0d~3,'0d" gender-code (mod year 100) month day serial-number)))
    (format nil "~a~d" code (get-control-number code))))
