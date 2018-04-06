;;;  -*- lexical-binding: t; -*-

;; Fonts
;; https://github.com/adobe-fonts/source-code-pro/releases/tag/variable-fonts
(setq doom-font (font-spec :family "Source Code Variable" :size 15))
(setq doom-variable-pitch-font (font-spec :family "Source Code Variable"))
(setq doom-unicode-font (font-spec :family "Source Code Variable"))
(setq doom-big-font (font-spec :family "Source Code Variable" :size 24))

;; Change theme.
;; Nord is pretty cool: https://github.com/arcticicestudio/nord
;; A nice alternative (although brighter) could be: nova - https://trevordmiller.com/projects/nova
(setq doom-theme 'doom-nord)

;; Magit rules
;; Keeps it on the side
;; Thanks to https://github.com/fuxialexander/doom-emacs-private-xfu
(after! magit
  (set! :popup "^\\(?: ?\\*\\)?magit.*: "
    '((slot . -1) (side . right) (size . 80))
    '((select . t) (quit . nil)))
  (set! :popup "^\\*magit.*popup\\*"
    '((slot . 0) (side . right))
    '((select . t)))
  (set! :popup "^\\(?: ?\\*\\)?magit-revision:.*"
    '((slot . 2) (side . right) (window-height . 0.6))
    '((select . t)))
  (set! :popup "^\\(?: ?\\*\\)?magit-diff:.*"
    '((slot . 2) (side . right) (window-height . 0.6))
    '((select . nil)))
  )


;; Thanks to bitwalker for this
(after! neotree
  ;; When switching to a file in the current project, expand the directory
  ;; tree to the new file buffer
  (add-hook! 'find-file-hook
    (if (and (buffer-file-name) (neo-global--window-exists-p))
        ;; And only if the file is a child of the current neotree root
        (if (neo-global--file-in-root-p (buffer-file-name))
            ;; We need to trigger neotree-find then switch back to the buffer we just opened
            (save-current-buffer (neotree-find))
            ))
    ))
