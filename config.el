;;;  -*- lexical-binding: t; -*-

;; Bind TAB to emmet expand because what monster uses M-e?

;; Author: hlissner
(defun emmet-or-snippet-expand ()
  (interactive)
  (call-interactively
   (cond ((and (bound-and-true-p yas-minor-mode)
               (yas--templates-for-key-at-point))
          #'yas-expand)
         ((emmet-expr-on-line)
          (if (bound-and-true-p yas-minor-mode)
              #'emmet-expand-yas
            #'emmet-expand-line))
         (#'indent-for-tab-command))))

(map! :after rjsx-mode
      :map rjsx-mode-map
      :i "TAB" #'emmet-or-snippet-expand)
(map! :after web-mode
      :map web-mode-map
      :i "TAB" #'emmet-or-snippet-expand)

;; Readd in rjsx's autotag shit
(map! :after rjsx-mode
      :map rjsx-mode-map
      "<" #'rjsx-electric-lt
      "C-d" #'rjsx-delete-creates-full-tag)

;; Load snippets
(after! yasnippet
  (push (expand-file-name "snippets/" doom-private-dir) yas-snippet-dirs))

;; Load web mode instead of js2-mode by default
(push '("\\.js$" . web-mode) auto-mode-alist)
(push '("\\.jsx$" . web-mode) auto-mode-alist)

(after! web-mode

  ;; TODO removed me one hlissner does it
  (remove-hook 'web-mode-hook #'turn-off-smartparens-mode)

  ;; Indent settings
  (defun my-web-mode-hook()
    "Hooks for Web mode."
    (setq
     web-mode-markup-indent-offset 2
     web-mode-css-indent-offset 2
     web-mode-code-indent-offset 2)
    )
  (add-hook 'web-mode-hook 'my-web-mode-hook)
  (setq
   ;; JSX in .js files
   web-mode-content-types-alist
   '(("jsx" . "\\.js[x]?\\'"))
   )

  ;; Disable jshint so we get eslint checking
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))

  ;; use eslint with web-mode
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  )

;; Modules
(load! +ruby)
(load! +lsp)
(load! +ui)
