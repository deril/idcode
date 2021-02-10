(in-package #:ee)

(defparameter +hospitals+ '("00" "01" "02" "22" "27" "37" "42" "47" "49" "52" "57" "60" "65" "70" "95"))

(defun get-gender-code (gender year)
  (case gender
    (0 (cond ((<= 1900 year 1999) 4)
             ((<= 2000 year 2099) 6)))
    (1 (cond ((<= 1900 year 1999) 3)
             ((<= 2000 year 2099) 5)))))

(defun get-control-number (code)
  (let* ((multiplier1 '(1 2 3 4 5 6 7 8 9 1))
         (multiplier2 '(3 4 5 6 7 8 9 1 2 3))
         (icode (mapcar #'digit-char-p (coerce code 'list)))
         (total (loop for n in icode
                      for m in multiplier1
                      summing (* m n)))
         (mod-code (mod total 11)))
    (if (= mod-code 10)
        (let* ((total (loop for n in icode
                            for m in multiplier2
                            summing (* m n)))
               (mod-code (mod total 11)))
          (if (= mod-code 10) 0 mod-code))
        mod-code)))

(defun generate ()
  (setf *random-state* (make-random-state t))
  (let* ((gender (random 2))
         (year (+ (random 101) 1900 (- (local-time:timestamp-year (local-time:today)) 2000)))
         (month (+ 1 (random 12)))
         (day (1+ (random (1- (local-time:days-in-month month year)))))
         (gender-code (get-gender-code gender year))
         (hospital (nth (random (length +hospitals+)) +hospitals+))
         (number-of-birth (1+ (random 10)))
         (code (format nil "~d~d~2,'0d~2,'0d~d~d" gender-code (mod year 100) month day hospital number-of-birth)))
    (format nil "~a~d" code (get-control-number code))))
