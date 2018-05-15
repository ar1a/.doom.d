;;;  -*- lexical-binding: t; -*-

;; From https://gist.github.com/kkatsuyuki/ede09142b817f2e3b97e87ce8bc93736

;; ============================================================
;;
;; sudo completion
;;
;; ============================================================
(defun pcomplete/sudo ()
  "Completion rules for the `sudo' command."
  (let ((pcomplete-ignore-case t))
    (pcomplete-here (funcall pcomplete-command-completion-function))
    (cond ((pcomplete-test "pacman")
           (pcomplete/pacman))
          (t (while (pcomplete-here (pcomplete-entries)))))))

;; ============================================================
;;
;; pacman completion
;;
;; ============================================================
(defvar pcomplete-pacman-installed-packages
  (split-string (shell-command-to-string "pacman -Qq"))
  "p-completion candidates for `pacman' regarding installed packages")

(defvar pcomplete-pacman-web-packages
  (split-string (shell-command-to-string "pacman -Slq"))
  "p-completion candidates for `pacman' regarding packages on the web")

(defun pcomplete/pacman ()
  "Completion rule for the `pacman' command."
  (pcomplete-opt "DFQRSUilos")
  (cond ((pcomplete-test "-[DRQ][a-z]*")
         (pcomplete-here pcomplete-pacman-installed-packages))
        ((pcomplete-test "-[FS][a-z]*")
         (pcomplete-here pcomplete-pacman-web-packages))
        (t (pcomplete-here (pcomplete-entries)))))

;; ============================================================
;;
;; systemctl completion
;;
;; ============================================================
(defcustom pcomplete-systemctl-commands
  '("disable" "enable" "status" "start" "restart" "stop")
  "p-completion candidates for `systemctl' main commands"
  :type '(repeat (string :tag "systemctl command"))
  :group 'pcomplete)

(defvar pcomplete-systemd-units
  (split-string
   (shell-command-to-string
    "(systemctl list-units --all --full --no-legend;systemctl list-unit-files --full --no-legend)|while read -r a b; do echo \" $a\";done;"))
  "p-completion candidates for all `systemd' units")

(defvar pcomplete-systemd-user-units
  (split-string
   (shell-command-to-string
    "(systemctl list-units --user --all --full --no-legend;systemctl list-unit-files --user --full --no-legend)|while read -r a b;do echo \" $a\";done;"))
  "p-completion candidates for all `systemd' user units")

(defun pcomplete/systemctl ()
  "Completion rules for the `systemctl' command."
  (pcomplete-here (append pcomplete-systemctl-commands '("--user")))
  (cond ((pcomplete-test "--user")
         (pcomplete-here pcomplete-systemctl-commands)
         (pcomplete-here pcomplete-systemd-user-units))
        (t (pcomplete-here pcomplete-systemd-units))))

;; ============================================================
;;
;; man completion
;;
;; ============================================================
(defvar pcomplete-man-user-commands
  (split-string
   (shell-command-to-string
    "apropos -s 1 .|while read -r a b; do echo \" $a\";done;"))
  "p-completion candidates for `man' command")

(defun pcomplete/man ()
    "Completion rules for the `man' command."
    (pcomplete-here pcomplete-man-user-commands))

