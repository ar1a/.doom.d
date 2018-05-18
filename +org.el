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

  ;; Normally its only like 3 lines tall, too hard to see anything.
  (set! :popup "^\\*Org Agenda"
    '((size . 15))
    '((transient) (quit) (select . t)))
  ;; Move the agenda to show the previous 3 days and the next 7 days for a bit
  ;; better context instead of just the current week which is a bit confusing
  ;; on, for example, a sunday
  (setq org-agenda-span 10
        org-agenda-start-on-weekday nil
        org-agenda-start-day "-3d"))

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
        :nvm "a" (lambda! (org-agenda nil "a")))
      (:when (featurep! :completion helm)
        :nv "X" #'helm-org-capture-templates))

