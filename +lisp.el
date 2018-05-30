;;;  -*- lexical-binding: t; -*-
(require 'rainbow-delimiters) ;; gotta require it because the function
;; it calls isn't autoloaded

(def-package! parinfer
  :commands (parinfer-mode)
  :init
  (defun +disable-yas ()
    "Disable yasnippet so parinfer works."
    (yas-minor-mode -1)
    (parinfer-mode))

  (add-hook! (emacs-lisp-mode
              clojure-mode
              common-lisp-mode
              scheme-mode
              lisp-mode)
    #'+disable-yas)
  :config
  (setq parinfer-extensions
        '(defaults
           evil
           pretty-parens
           smart-tab
           smart-yank)
        parinfer-auto-switch-indent-mode t
        parinfer-auto-switch-indent-mode-when-closing t)
  ;; FIXME Parinfer isn't being mapped
  (map! :map parinfer-mode-map
        :localleader
        :nv "m" #'parinfer-toggle-mode))

