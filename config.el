;;;  -*- lexical-binding: t; -*-
(require 'flow-minor-mode)
(require 'company-flow)
(require 'prettier-js)
(require 'flycheck-flow)

(setq-default evil-shift-width 2) ;; I normally use 2wide for my projects.

(setq user-mail-address "aria@ar1as.space"
      user-full-name "Aria Edm")

;; Load snippets
(after! yasnippet
  (push (expand-file-name "snippets/" doom-private-dir) yas-snippet-dirs))

;; Use fuzzy searching for finding files
(after! ivy
  (setq ivy-re-builders-alist
        '((t . ivy--regex-fuzzy))))

(after! tide
  (set! :company-backend 'tide-mode 'company-flow 'company-tide))
(defun setup-prettier-js ()
  "Sets up arguments and the mode."
  (interactive)
  (setq prettier-js-args '("--single-quote"))

  (prettier-js-mode))


(defun enable-minor-mode (my-pair)
  "Enable minor mode if filename matches the regexp.
  MY-PAIR is a cons cell (regexp . minor-mode)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
          (funcall (cdr my-pair)))))


;; Prettier in .tsx
(after! web-mode
  (add-hook! web-mode (enable-minor-mode '("\\.tsx\\'" . setup-prettier-js))))

;; Fix an upstream bug in rjsx-mode
(after! rjsx-mode
  (defun +javascript|reparse (n)
    (if (= n 1)
        (rjsx-maybe-reparse))))

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
  (setq typescript-indent-level 2))


(after! js2-mode
  ;; use eslintd-fix so when i save it fixes dumb shit
  (add-hook 'js2-mode-hook #'eslintd-fix-mode)

  ;; FLOW STUFF
  (add-hook 'js2-mode-hook #'flow-minor-enable-automatically)

  ;; Prettier shit
  (add-hook 'js2-mode-hook #'setup-prettier-js)

  ;; Indent shit
  (setq js2-basic-offset 2))


(after! web-mode
  (add-hook 'web-mode-hook #'flycheck-mode)

  (setq web-mode-markup-indent-offset 2 ;; Indentation
        web-mode-code-indent-offset 2
        web-mode-enable-auto-quoting nil ;; disbale adding "" after an =
        web-mode-auto-close-style 2)) ;; Close on > and </ not just </

(after! elm
  (setq elm-tags-on-save t
        elm-sort-imports-on-save t))

;; (def-package! elcord
;;   :commands elcord-mode
;;   :init
;;   (setq-default elcord-display-buffer-details nil)
;;   (elcord-mode))

(when (and (executable-find "fish")
           (require 'fish-completion nil t))
  (global-fish-completion-mode))

(after! helm
  ;; helm disables fuzzy matching but actually I want that
  (setq
        helm-mode-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-apropos-fuzzy-match t
        helm-M-x-fuzzy-match t
        helm-recentf-fuzzy-match t
        helm-projectile-fuzzy-match t)
  ;; I want backspace to go up a level, like ivy
  (if (boundp 'helm-find-files-map)
    (map! :map helm-find-files-map
          "<DEL>" #'helm-find-files-up-one-level))
  (map! :leader
        (:prefix "/"
          ;; This is bound to ivy project search in :config default +bindings
          :nv "p" #'helm-do-ag-project-root)))

(after! eshell
  (add-hook! eshell-mode
    (eshell-cmpl-initialize)
    (map! :map eshell-mode-map
          [remap eshell-pcomplete] #'helm-esh-pcomplete
          "M-p" #'helm-eshell-history))
  (load! eshell-completion))

;; Set twitter edit buffer to be 15 lines high so I can actually see what im
;; editing. FIXME this will be fixed upstream, remove me when it is
(after! twittering-mode
  (set! :popup "^\\*twittering-edit"
    '((size . 15))
    '((transient) (quit) (select . t))))

;; Modules
(load! +ruby) ;; Custom ruby mode. Make sure you disable ruby in init.el
(load! +ui) ;; My ui mods. Also contains ligature stuff.
(load! +lisp) ;; Addon for lisp* modes. Check out https://shaunlebron.github.io/parinfer/
(load! +music) ;; Music stuff, visible through SPC-a-m. Not perfect.
(load! +ranger) ;; File manager stuff
(load! +reason) ;; ReasonML stuff
(load! +mail) ;; Mail stuff
(load! +org) ;; Org mode stuff like todos and rebindings
(load! +irc) ;; Irc config
(load! +twitter) ;; Twittering binds.
(load! +exwm) ;; Emacs as a window manager!
