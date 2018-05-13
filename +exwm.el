;;;  -*- lexical-binding: t; -*-
(after! evil
  (require 'exwm)
  (require 'exwm-config)
  (require 'exwm-systemtray)
  (exwm-systemtray-enable)
  (setq exwm-input--line-mode-passthrough t)

  ;; Set the initial workspace number.
  (setq exwm-workspace-number 4)
  ;; Make class name the buffer name
  (add-hook 'exwm-update-class-hook
            (lambda ()
              (setq exwm-input--line-mode-passthrough t)
              (exwm-workspace-rename-buffer exwm-class-name)))

  (defun +exwm-bind-command (key command &rest bindings)
    (while key
      (exwm-input-set-key (kbd key)
                          `(lambda ()
                             (interactive)
                             (start-process-shell-command ,command nil ,command)))
      (setq key (pop bindings)
            command (pop bindings))))
  (+exwm-bind-command "<s-return>" "urxvt")
  (+exwm-bind-command "s-X" "betterlockscreen -l blur")


  (exwm-input-set-key (kbd "s-w") #'exwm-workspace-switch)
  (exwm-input-set-key (kbd "s-1") (lambda! (exwm-workspace-switch 0)))
  (exwm-input-set-key (kbd "s-2") (lambda! (exwm-workspace-switch 1)))
  (exwm-input-set-key (kbd "s-3") (lambda! (exwm-workspace-switch 2)))
  (exwm-input-set-key (kbd "s-4") (lambda! (exwm-workspace-switch 3)))
  ;; s-h, s-j, s-k, s-l: move around
  (exwm-input-set-key (kbd "s-h") #'evil-window-left)
  (exwm-input-set-key (kbd "s-j") #'evil-window-down)
  (exwm-input-set-key (kbd "s-k") #'evil-window-up)
  (exwm-input-set-key (kbd "s-l") #'evil-window-right)
  ;; Moving windows
  (exwm-input-set-key (kbd "s-H") #'evil-window-move-far-left)
  (exwm-input-set-key (kbd "s-J") #'evil-window-move-very-bottom)
  (exwm-input-set-key (kbd "s-K") #'evil-window-move-very-top)
  (exwm-input-set-key (kbd "s-L") #'evil-window-move-far-right)
  ;; Resizing windows
  (exwm-input-set-key (kbd "M-s-h") #'shrink-window-horizontally)
  (exwm-input-set-key (kbd "M-s-j") #'shrink-window)
  (exwm-input-set-key (kbd "M-s-k") #'enlarge-window)
  (exwm-input-set-key (kbd "M-s-l") #'enlarge-window-horizontally)
  ;; Prefix input
  (push ?\M-m exwm-input-prefix-keys)
  ;; Universal get me outta here
  (push ?\C-g exwm-input-prefix-keys)
  ;; C-c, C-x are needed for c+p
  (delete ?\C-x exwm-input-prefix-keys)
  (delete ?\C-c exwm-input-prefix-keys)
  ;; We can use `M-m h' to access help
  (delete ?\C-h exwm-input-prefix-keys)


  ;; 's-SPC': Launch application
  (exwm-input-set-key (kbd "s-S-SPC") #'counsel-linux-app)
  (exwm-input-set-key (kbd "s-SPC")
                      (lambda (command)
                        (interactive (list (read-shell-command "$ ")))
                        (start-process-shell-command command nil command)))

  ;; Enable EXWM
  (exwm-enable))
