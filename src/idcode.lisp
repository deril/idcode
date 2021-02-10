(in-package #:idcode)

(defmacro when-arg (arg &body body)
  `(let ((it (member ,arg (uiop:command-line-arguments) :test #'string-equal)))
     (when it
       ,@body)))

(defun main ()
  (when-arg "ee" (format t "~a" (ee:generate)))
  (when-arg "lv" (format t "~a" (lv:generate)))
  (when-arg "lt" (format t "~a" (lt:generate))))
