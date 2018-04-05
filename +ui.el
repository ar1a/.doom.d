;;;  -*- lexical-binding: t; -*-

;; Fonts
;; https://github.com/adobe-fonts/source-code-pro/releases/tag/variable-fonts
(setq doom-font (font-spec :family "Source Code Variable" :size 13))
(setq doom-variable-pitch-font (font-spec :family "Source Code Variable"))
(setq doom-unicode-font (font-spec :family "Source Code Variable"))
(setq doom-big-font (font-spec :family "Source Code Variable" :size 19))

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
