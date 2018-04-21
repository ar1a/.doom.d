;;;  -*- lexical-binding: t; -*-

;; Load snippets
(after! yasnippet
  (push (expand-file-name "snippets/" doom-private-dir) yas-snippet-dirs))

(after! js2-mode
  ;; use eslintd-fix so when i save it fixes dumb shit
  (add-hook 'js2-mode-hook #'eslintd-fix-mode)
  ;; Indent shit
  (setq js2-basic-offset 2)
  )

;; Flycheck when you hit escape in insert mode not only normal mode
(add-hook 'evil-insert-state-exit-hook #'+syntax-checkers|flycheck-buffer)

;; Modules
;; (load! +web)
(load! +ruby)
;; (load! +lsp)
(load! +ui)
