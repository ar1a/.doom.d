;;;  -*- lexical-binding: t; -*-

;; don't forget to npm i -g javascript-typescript-langserver

(def-package! lsp-mode)

(def-package! lsp-ui
  :after lsp-mode
  :config
  (add-hook! 'lsp-mode-hook #'lsp-ui-mode))

(def-package! company-lsp
  :after lsp-mode
  :config
  (push 'company-lsp company-backends))

(def-package! lsp-javascript-typescript
  :after lsp-mode
  :config
  (add-hook! js-mode #'lsp-javascript-typescript-enable)
  (add-hook! typescript-mode #'lsp-javascript-typescript-enable)
  (add-hook! rjsx-mode #'lsp-javascript-typescript-enable)
  )
