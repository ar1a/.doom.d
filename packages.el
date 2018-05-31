;;;  -*- no-byte-compile: t; -*-

;; Ruby stuff
(package! enh-ruby-mode)
(package! rbenv) ; i use rbenv
(package! yard-mode)
(package! rinari)
(package! rubocop)

;; lsp stuff
;; (package! lsp-mode)
;; (package! lsp-ui)
;; (package! company-lsp)
;; (package! lsp-javascript-typescript)

;; JS stuff
(package! prettier-js)
(package! pkgbuild-mode)

;; Lisp stuff
(package! parinfer)

;; Fuzzy searching
(package! flx)

;; Music stuff
(package! google-play-music :recipe (:fetcher github :repo "merrickluo/google-play-music.el"))

;; Filestuff
(package! ranger)

;; Reasonml stuff
(package! reason-mode)

;; Email stuff
(package! notmuch)
(if (featurep! :completion ivy)
    (package! counsel-notmuch)
  (package! helm-notmuch))
(package! org-mime)
