;;;  -*- lexical-binding: t; -*-

;; Load snippets
(after! yasnippet
  (push (expand-file-name "snippets/" doom-private-dir) yas-snippet-dirs))

;; Modules
(load! +web)
(load! +ruby)
(load! +lsp)
(load! +ui)
