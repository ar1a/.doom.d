;;;  -*- lexical-binding: t; -*-

;; Fonts
(setq doom-font (font-spec :family "Iosevka" :size 15))
(setq doom-big-font (font-spec :family "Iosevka" :size 21))

;; Dash highlighting
(after! dash (dash-enable-font-lock))

;; Change theme.
;; Nord is pretty cool: https://github.com/arcticicestudio/nord
;; A nice alternative (although brighter) could be: nova - https://trevordmiller.com/projects/nova
(setq doom-theme 'doom-tomorrow-night)

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
    '((select . nil))))



;; Thanks to bitwalker for this
(after! neotree
  ;; When switching to a file in the current project, expand the directory
  ;; tree to the new file buffer
  (add-hook! 'find-file-hook
    (if (and (buffer-file-name) (neo-global--window-exists-p))
        ;; And only if the file is a child of the current neotree root
        (if (neo-global--file-in-root-p (buffer-file-name))
            ;; We need to trigger neotree-find then switch back to the buffer we just opened
            (save-current-buffer (neotree-find))))))

(def-package! posframe
  :after helm)

(after! helm
  ;; Posframe!
  ;; https://www.reddit.com/r/emacs/comments/80bdck/using_a_posframe_to_show_ivys_candidate_menu/dvcsarc
  (defvar helm-posframe-buffer nil)

  (defun helm-posframe-display (buffer &optional _resume)
    (posframe-show
      (setq helm-posframe-buffer buffer)
      :poshandler #'posframe-poshandler-frame-bottom-left-corner
      :left-fringe 10
      :width (frame-width)
      :height 16 ;; ivy/+childframe uses 16
      :respect-header-line t))

  (defun helm-posframe-cleanup ()
    (posframe-hide helm-posframe-buffer))

  (add-hook! 'helm-cleanup-hook #'helm-posframe-cleanup)
  (setq helm-display-function #'helm-posframe-display))

(load! "+symbols")
