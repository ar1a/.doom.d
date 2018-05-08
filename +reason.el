;;;  -*- lexical-binding: t; -*-

(def-package! reason-mode
  :mode "\\.rei?$"
  :commands (reason-mode)
  :config
  (let* (
         (refmt-bin (shell-command-to-string "readlink -f $(which refmt)"))
         (merlin-bin (shell-command-to-string "ocamlmerlin ----where"))
         (merlin-base-dir (when merlin-bin
                            (replace-regexp-in-string "bin/ocamlmerlin$" "" merlin-bin))))
    ;; Add npm merlin.el to the emacs load path and tell emacs where to find ocamlmerlin
    (when merlin-bin
      (add-to-list 'load-path (concat merlin-base-dir "share/emacs/site-lisp/"))
      (setq merlin-command merlin-bin))

    (when refmt-bin
      (setq refmt-command refmt-bin))
    (add-hook! reason-mode
        (add-hook 'before-save-hook #'refmt-before-save nil t))
    (require 'merlin)
    (merlin-mode)
    (setq merlin-ac-setup t)))
