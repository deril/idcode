(load "quicklisp/setup")
(ql:quickload "idcode")

(sb-ext:save-lisp-and-die "idcode"
                          :toplevel #'idcode:main
                          :executable t)
