(asdf:defsystem "cl-fastdata"
  :description "Fast Data Structures and Algorithms (inspired by Java Fastuils)"
  :author "David Clark <daveloper9000@gmail.com>"
  :license  "Apache 2"
  :version "0.0.1"
  :pathname "src/"
  :depends-on ("alexandria")
  :components ((:file "package")
               (:file "sorting")))

(asdf:defsystem "cl-fastdata/test"
  :depends-on ("cl-fastdata" "fiasco" "alexandria")
  :pathname "test/"
  :components ((:file "package-test")
               (:file "sorting-test")))
