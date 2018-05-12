;;;  -*- lexical-binding: t; -*-
(after! evil
  (require 'exwm)
  (require 'exwm-config)
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


  ;; 's-w': Switch workspace
  ;;By default the layer binds s-SPC to spacemacs/exwm-app-launcher but you can
  ;;change that to something else (I use s-m) then you need to add (push ?\s-\
  ;;exwm-input-prefix-keys) (note the two spaces between ?\s-\ and
  ;;exwm-input-prefix-keys)) so that s-SPC is passed to emacs in EXWM buffers
  ;;then in my .spacemacs I set dotspacemacs-emacs-leader-key "s-SPC" so that I
  ;;can keep SPC as my usual leader key in emacs buffers as well as having s-SPC
  ;;as my leader in EXWM buffers
  (exwm-input-set-key (kbd "s-w") #'exwm-workspace-switch)
  ;; s-h, s-j, s-k, s-l: move around
  (exwm-input-set-key (kbd "s-h") #'evil-window-left)
  (exwm-input-set-key (kbd "s-j") #'evil-window-down)
  (exwm-input-set-key (kbd "s-k") #'evil-window-up)
  (exwm-input-set-key (kbd "s-l") #'evil-window-right)
  ;; lock screen
  ;; (exwm-input-set-key (kbd "C-M-l") #'lock-screen)
  ;; (define-key global-map (kbd "C-M-l") #'lock-screen)
  (push ?\M-m exwm-input-prefix-keys)

  ;; 's-&': Launch application
  (exwm-input-set-key (kbd "s-&")
                      (lambda (command)
                        (interactive (list (read-shell-command "$ ")))
                        (start-process-shell-command command nil command)))

  ;; Enable EXWM
  (exwm-enable))
