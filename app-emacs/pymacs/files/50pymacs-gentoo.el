
;;; pymacs site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
