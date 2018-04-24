;;;  -*- lexical-binding: t; -*-

(require 'flow-minor-mode)
(require 'company-flow)
(require 'prettier-js)

;; stop fucking indexing node_modules
(setq projectile-globally-ignored-directories '("node_modules"))

;; Load snippets
(after! yasnippet
  (push (expand-file-name "snippets/" doom-private-dir) yas-snippet-dirs))

(after! tide
  (set! :company-backend 'tide-mode 'company-flow 'company-tide)
  (setq tide-completion-detailed t
        tide-always-show-documentation t)
  )

(defun setup-prettier-js ()
  "Sets up arguments and the mode."
  (interactive)
  (setq prettier-js-args '(
                           "--single-quote"
                           ))
  (prettier-js-mode)
  )

(defun enable-minor-mode (my-pair)
  "Enable minor mode if filename matches the regexp. MY-PAIR is a cons cell (regexp . minor-mode)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
          (funcall (cdr my-pair))))
  )

(after! web-mode
  (add-hook! web-mode (enable-minor-mode '("\\.tsx\\'" . setup-prettier-js)))
  )

(after! typescript-mode
  (defun tslint-fix-file ()
    "Tslint fix file."
    (interactive)
    (message (concat "tslint --fixing the file " (buffer-file-name)))
    (shell-command (concat "tslint --fix " (buffer-file-name))))

  (defun tslint-fix-file-and-revert ()
    "Format the current file with Tslint."
    (interactive)
    (when (eq major-mode 'typescript-mode)
      (if (executable-find "tslint")
          (tslint-fix-file)
        (message "Tslint not found."))))

  (add-hook 'after-save-hook #'tslint-fix-file-and-revert)
  (add-hook 'typescript-mode-hook #'flycheck-mode)
  ;; Prettier shit
  (add-hook 'typescript-mode-hook #'setup-prettier-js)
  (setq typescript-indent-level 2)
  )

(after! js2-mode
  ;; use eslintd-fix so when i save it fixes dumb shit
  (add-hook 'js2-mode-hook #'eslintd-fix-mode)

  ;; FLOW STUFF
  (add-hook 'js2-mode-hook #'flow-minor-enable-automatically)

  ;; Prettier shit
  (add-hook 'js2-mode-hook #'setup-prettier-js)

  ;; Indent shit
  (setq js2-basic-offset 2)
  )

(after! web-mode
  (add-hook 'web-mode-hook #'flycheck-mode)
  )

;; Flycheck when you hit escape in insert mode not only normal mode
(add-hook 'evil-insert-state-exit-hook #'+syntax-checkers|flycheck-buffer)

;; Modules
;; (load! +web)
(load! +ruby)
;; (load! +lsp)
(load! +ui)

(setq-default company-frontends '(company-pseudo-tooltip-frontend company-echo-metadata-frontend))
