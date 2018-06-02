;;; ~/.doom.d/+magit.el -*- lexical-binding: t; -*-

(setq +magit-hub-features t ;; I want the PR/issue stuff too!
      +magit-hub-enable-by-default t)  ;; And I want it on by default!

(after! magit
  (magit-wip-after-save-mode t)
  (magit-wip-after-apply-mode t)
  (setq magit-save-repository-buffers 'dontask
        magit-repository-directories '("/home/aria/projects/")
        magit-popup-display-buffer-action nil ;; Not sure why this is here, wonder what it does
        magit-display-file-buffer-function #'switch-to-buffer-other-window
        magithub-clone-default-directory "~/projects") ;; I want my stuff to clone to ~/projects
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
    (let* ((str "M A G I T"))
          (num (max 0 (/ (- (window-width
                              (selected-window)) (string-width str)) 2)))
      (concat +doom-modeline--bar-inactive (propertize (concat (make-string num ? ) str) 'face 'bold))))

  (def-modeline-segment! magithub-title
    "E N H A N C E D magithub title"
    (let* ((str "D A S H B O A R D"))
          (num (max 0 (/ (- (window-width
                              (selected-window)) (string-width str)) 2)))
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
    '((select . nil))))


