;;;  -*- lexical-binding: t; -*-

(def-package! parinfer
  :config
  (setq parinfer-extensions
        '(defaults
           evil
           smart-tab
           smart-yank))
  (setq parinfer-auto-switch-indent-mode t
        parinfer-auto-switch-indent-mode-when-closing t)
  (add-hook! emacs-lisp-mode #'parinfer-mode))
