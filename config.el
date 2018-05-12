;;;  -*- lexical-binding: t; -*-

(require 'flow-minor-mode)
(require 'company-flow)
(require 'prettier-js)
(require 'flycheck-flow)

(setq evil-shift-width 2) ;; I normally use 2wide for my projects.

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

(after! irc
  (defun fetch-password (&rest params)
    "Fetch a password from auth-source"
    (require 'auth-source)
    (let ((match (car (apply 'auth-source-search params))))
      (if match
          (let ((secret (plist-get match :secret)))
            (if (functionp secret)
                (funcall secret)
              secret))
        (error "Password not found for %S" params))))

  (defun irc-password (server)
    (fetch-password :user "ar1a" :host server))

  ;; Freenode
  (set! :irc "irc.freenode.net"
    '(:use-tls t
           :port 6697
           :nick "ar1a"
           :sasl-username "ar1a"
           :sasl-password irc-password
           :channels ("#emacs"))))


(map! :leader
      (:prefix "o"
        (:nve "I" #'=irc)))

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


(after! web-mode
  (add-hook! web-mode (enable-minor-mode '("\\.tsx\\'" . setup-prettier-js))))


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

(def-package! elcord
  :commands elcord-mode
  :init
  (setq-default elcord-display-buffer-details nil)
  (elcord-mode))


;; Modules
(load! +ruby) ;; Custom ruby mode. Make sure you disable ruby in init.el
(load! +ui) ;; My ui mods. Also contains ligature stuff.
(load! +lisp) ;; Addon for lisp* modes. Check out https://shaunlebron.github.io/parinfer/
(load! +music) ;; Music stuff, visible through SPC-a-m. Not perfect.
(load! +ranger) ;; File manager stuff
(load! +reason) ;; ReasonML stuff
(load! +mail) ;; Mail stuff
