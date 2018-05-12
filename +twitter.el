;;;  -*- lexical-binding: t; -*-


(after! twittering-mode
  (setq twittering-initial-timeline-spec-string '(":home" ":mentions"))
  (map! :map twittering-mode-map
        "C" #'twittering-organic-retweet
        "W" (lambda! (twittering-visit-timeline ":home"))
        "Y" #'twittering-push-tweet-onto-kill-ring ;; Tweet content
        "c" #'twittering-native-retweet
        "d" #'twittering-delete-status
        "g" #'twittering-goto-first-status
        "j" #'twittering-goto-next-status
        "k" #'twittering-goto-previous-status ;; Use tab to jump to links
        "o" #'twittering-update-status-interactive
        "O" #'twittering-enter
        "C-o" #'twittering-direct-message ;; Needed a third to do things. I guess C-o?
        "r" #'twittering-current-timeline ;; This should be refresh
        "w" #'twittering-visit-timeline
        "y" #'twittering-push-uri-onto-kill-ring)) ;; URL under cursor or link to tweet
