;;;; idcode.asd

(asdf:defsystem #:idcode
  :description "Describe idcode here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:local-time)
  :components ((:file "package")
               (:file "idcode")
               (:file "ee")
               (:file "lv")
               (:file "lt")))
