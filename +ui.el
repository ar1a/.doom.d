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
(set! :popup "^\\(?: ?\\*\\)?magit.*: "
  '((slot . -1) (side . right) (size . 80))
  '((select . t) (quit . nil)))

(set! :popup "^\\*magithub-dash\\*"
  '((slot . -3) (side . right) (window-height . 20))
  '((select . t)))
(def-modeline-segment! magithub-buffer-info-simple
  "magithub issue title"
  (substring (buffer-name) 11 -1))
(def-modeline-segment! magit-title
  "E N H A N C E D magit title"
  (let* ((str "M A G I T")
         (num (max 0 (/ (- (window-width
                            (selected-window)) (string-width str)) 2))))
    (concat +doom-modeline--bar-inactive (propertize (concat (make-string num ? ) str) 'face 'bold))))

(def-modeline-segment! magithub-title
  "E N H A N C E D magithub title"
  (let* ((str "D A S H B O A R D")
         (num (max 0 (/ (- (window-width
                            (selected-window)) (string-width str)) 2))))
    (concat +doom-modeline--bar-inactive (propertize (concat (make-string num ? ) str) 'face 'bold))))

(def-modeline! magit-title
  (magit-title))

(def-modeline! magithub-title
  (magithub-title))

(def-modeline! magithub
  (bar matches " " magithub-buffer-info-simple))
(set! :popup "^\\*magithub: .*\\*"
  '((slot . -2) (side . right) (window-height . 0.6))
  '((select . t)))

(defun +magithub|switch-mode-and-header-line ()
  (setq header-line-format (or (doom-modeline 'magithub) mode-line-format)
        mode-line-format nil))
(add-hook 'magithub-issue-view-mode-hook #'+magithub|switch-mode-and-header-line)

(defun +magit|switch-mode-and-header-line ()
  (setq header-line-format (or (doom-modeline 'magit-title) mode-line-format)
        mode-line-format nil))
(add-hook 'magit-status-mode-hook #'+magit|switch-mode-and-header-line)

(defun +magithub-dash|switch-mode-and-header-line ()
  (setq header-line-format (or (doom-modeline 'magithub-title) mode-line-format)
        mode-line-format nil))
(add-hook 'magithub-dash-mode-hook #'+magithub-dash|switch-mode-and-header-line)

(set! :popup "^\\*magit.*popup\\*"
  '((slot . 0) (side . right))
  '((select . t)))
(set! :popup "^\\(?: ?\\*\\)?magit-revision:.*"
  '((slot . 2) (side . right) (window-height . 0.6))
  '((select . t)))
(set! :popup "^\\(?: ?\\*\\)?magit-diff:.*"
  '((slot . 2) (side . right) (window-height . 0.6))
  '((select . nil)))

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

(load! "+symbols")
