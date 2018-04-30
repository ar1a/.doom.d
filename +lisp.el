;;;  -*- lexical-binding: t; -*-
(require 'rainbow-delimiters) ;; gotta require it because the function
;; it calls isn't autoloaded

(def-package! parinfer
  :config
  (setq parinfer-extensions
        '(defaults
           evil
           pretty-parens
           smart-tab
           smart-yank))
  (setq parinfer-auto-switch-indent-mode t
        parinfer-auto-switch-indent-mode-when-closing t)
  (add-hook! emacs-lisp-mode #'parinfer-mode)
  (add-hook! clojure-mode #'parinfer-mode))
