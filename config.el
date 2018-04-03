;;;  -*- lexical-binding: t; -*-

(map! :map emmet-mode-keymap
    :i "C-/" #'emmet-expand-yas)

(load! +ruby)

