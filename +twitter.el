;;;  -*- lexical-binding: t; -*-


(after! twittering-mode
  (setq twittering-initial-timeline-spec-string '(":home" ":mentions")
        twittering-timer-interval 300) ;; 5 seems like a reasonable refresh
                                       ;;considering you can hit "r" to refresh
  (map! :map twittering-mode-map
        "c" #'twittering-native-retweet
        "C" #'twittering-organic-retweet
        "d" #'twittering-delete-status
        "g" #'twittering-goto-first-status
        "j" #'twittering-goto-next-status
        "k" #'twittering-goto-previous-status ;; Use tab to jump to links
        "o" #'twittering-update-status-interactive
        "O" #'twittering-enter
        "C-o" #'twittering-direct-message ;; Needed a third to do things. I guess C-o?
        "r" #'twittering-current-timeline ;; This should be refresh
        "w" #'twittering-visit-timeline
        "W" (lambda! (twittering-visit-timeline ":home"))
        "y" #'twittering-push-uri-onto-kill-ring ;; URL under cursor or link to tweet
        "Y" #'twittering-push-tweet-onto-kill-ring)) ;; Tweet content
