;;;  -*- lexical-binding: t; -*-

(def-package! enh-ruby-mode
  :mode "\\.rb$"
  :mode "\\.rake$"
  :mode "\\.gemspec$"
  :mode "\\.\\(pry\\|irb\\)rc$"
  :mode "/\\(Gem\\|Cap\\|Vagrant\\|Rake\\|Pod\\|Puppet\\|Berks\\)file$"
  :commands (enh-ruby-mode)
  :config
  (add-hook 'enh-ruby-mode-hook #'flycheck-mode)
  )

(def-package! yard-mode :hook enh-ruby-mode)

(def-package! rbenv
  :after enh-ruby-mode
  :config
  (global-rbenv-mode))

(def-package! rubocop
  :hook (enh-ruby-mode . rubocop-mode)
  :config
  (map! :map enh-ruby-mode-map
        :localleader ; while these may look weird, they're what I used in spacemacs and are muscle memory
        :nv "rrf" #'rubocop-check-current-file
        :nv "rrF" #'rubocop-autocorrect-current-file
        :nv "rrp" #'rubocop-check-project
        :nv "rrP" #'rubocop-autocorrect-project
        )
  )
