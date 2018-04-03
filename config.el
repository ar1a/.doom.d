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

(setq emmet-expand-jsx-className? t) ;; jsx uses className not class

;; Readd in rjsx's autotag shit
(map! :after rjsx-mode
      :map rjsx-mode-map
      "<" #'rjsx-electric-lt
      "C-d" #'rjsx-delete-creates-full-tag)


;; Load snippets
(after! yasnippet
  (push (expand-file-name "snippets/" +private-config-path) yas-snippet-dirs))

(load! +ruby)

