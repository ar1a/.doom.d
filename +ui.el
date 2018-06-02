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
(load! "+magit")
