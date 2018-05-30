;;;  -*- lexical-binding: t; -*-

(setq +todo-file "~/org/todo.org")

(after! org
  (map! :map evil-org-mode-map
        :localleader
        :desc "Create/Edit Todo" :nve "o" #'org-todo
        :desc "Schedule" :nve "s" #'org-schedule
        :desc "Deadline" :nve "d" #'org-deadline
        :desc "Refile" :nve "r" #'org-refile
        :desc "Filter" :nve "f" #'org-match-sparse-tree
        :desc "Tag heading" :nve "t" #'org-set-tags-command)
  ;; The standard unicode characters are usually misaligned depending on the font.
  ;; This bugs me. Personally, markdown #-marks for headlines are more elegant.
  (setq org-bullets-bullet-list '("#"))

  ;; Normally its only like 3 lines tall, too hard to see anything.
  (set! :popup "^\\*Org Agenda"
    '((size . 15))
    '((transient) (quit) (select . t))))

;; org-match-sparse-tree
;; org-set-tags-command
(defun +open-todo-file ()
  (interactive)
  "Opens the todo file"
  (find-file +todo-file))

(map!
 (:leader
   :desc "Open todo file" :nvm "O" #'+open-todo-file))

(map! :leader
      (:prefix "o"
        :desc "Org Agenda" :nvm "a" (lambda! (org-agenda nil "a")))
      (:when (featurep! :completion helm)
        :nv "X" #'helm-org-capture-templates))

