;;;  -*- lexical-binding: t; -*-

;; Bind C-/ to emmet expand because what monster uses M-e?
;; TODO make this tab
(map! :map emmet-mode-keymap
    :i "C-/" #'emmet-expand-yas)

(load! +ruby)

