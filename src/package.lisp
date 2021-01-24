(defpackage :cl-fastdata
  (:use :cl)
  (:import-from :alexandria :once-only :with-unique-names)
  (:export :sorted-p :define-quick-sort! :define-insertion-sort!))

