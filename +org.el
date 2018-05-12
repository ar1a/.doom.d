;;;  -*- lexical-binding: t; -*-

(setq +todo-file "~/org/todo.org")

(after! org
  (map! :map evil-org-mode-map
        :localleader
        :desc "Create/Edit Todo" :nve "t" #'org-todo
        :desc "Schedule" :nve "s" #'org-schedule
        :desc "Refile" :nve "r" #'org-refile))

(defun +open-todo-file ()
    (interactive)
    "Opens the todo file"
    (find-file +todo-file))

(map!
    (:leader
        :desc "Open todo file" :nvm "O" #'+open-todo-file))

(map! :leader
 (:prefix "o"
   :nvm "a" (lambda! (org-agenda nil "a"))))

