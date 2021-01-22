(defpackage :cl-fastdata
  (:use :cl)
  (:import-from :alexandria :once-only :with-unique-names)
  (:export :quick-sort! :sorted-p))

