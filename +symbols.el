;;;  -*- lexical-binding: t; -*-

;; Make sure you have this installed - https://github.com/tonsky/FiraCode/files/412440/FiraCode-Regular-Symbol.zip

(set-fontset-font t '(#xe100 . #xe16f) "Fira Code Symbol")

(defconst fira-code-font-lock-keywords-alist
  (mapcar (lambda (regex-char-pair)
            `(,(car regex-char-pair)
              (0 (prog1 ()
                   (compose-region (match-beginning 1)
                                   (match-end 1)
                                   ;; The first argument to concat is a string containing a literal tab
                                   ,(concat "	" (list (decode-char 'ucs (cadr regex-char-pair)))))))))
          '(("\\(www\\)"                   #Xe100)
            ("[^/]\\(\\*\\*\\)[^/]"        #Xe101)
            ("\\(\\*\\*\\*\\)"             #Xe102)
            ("\\(\\*\\*/\\)"               #Xe103)
            ("\\(\\*>\\)"                  #Xe104)
            ("[^*]\\(\\*/\\)"              #Xe105)
            ("\\(\\\\\\\\\\)"              #Xe106)
            ("\\(\\\\\\\\\\\\\\)"          #Xe107)
            ("\\({-\\)"                    #Xe108)
            ("\\(\\[\\]\\)"                #Xe109)
            ("\\(::\\)"                    #Xe10a)
            ("\\(:::\\)"                   #Xe10b)
            ("[^=]\\(:=\\)"                #Xe10c)
            ("\\(!!\\)"                    #Xe10d)
            ("\\(!=\\)"                    #Xe10e)
            ("\\(!==\\)"                   #Xe10f)
            ("\\(-}\\)"                    #Xe110)
            ("\\(--\\)"                    #Xe111)
            ("\\(---\\)"                   #Xe112)
            ("\\(-->\\)"                   #Xe113)
            ("[^-]\\(->\\)"                #Xe114)
            ("\\(->>\\)"                   #Xe115)
            ("\\(-<\\)"                    #Xe116)
            ("\\(-<<\\)"                   #Xe117)
            ("\\(-~\\)"                    #Xe118)
            ("\\(#{\\)"                    #Xe119)
            ("\\(#\\[\\)"                  #Xe11a)
            ("\\(##\\)"                    #Xe11b)
            ("\\(###\\)"                   #Xe11c)
            ("\\(####\\)"                  #Xe11d)
            ("\\(#(\\)"                    #Xe11e)
            ("\\(#\\?\\)"                  #Xe11f)
            ("\\(#_\\)"                    #Xe120)
            ("\\(#_(\\)"                   #Xe121)
            ("\\(\\.-\\)"                  #Xe122)
            ("\\(\\.=\\)"                  #Xe123)
            ("\\(\\.\\.\\)"                #Xe124)
            ("\\(\\.\\.<\\)"               #Xe125)
            ("\\(\\.\\.\\.\\)"             #Xe126)
            ("\\(\\?=\\)"                  #Xe127)
            ("\\(\\?\\?\\)"                #Xe128)
            ("\\(;;\\)"                    #Xe129)
            ("\\(/\\*\\)"                  #Xe12a)
            ("\\(/\\*\\*\\)"               #Xe12b)
            ("\\(/=\\)"                    #Xe12c)
            ("\\(/==\\)"                   #Xe12d)
            ("\\(/>\\)"                    #Xe12e)
            ("\\(//\\)"                    #Xe12f)
            ("\\(///\\)"                   #Xe130)
            ;; ("\\(&&\\)"                    #Xe131) ;; disabled because it conflicts with `prettify-symbols-mode'
            ;; ("\\(||\\)"                    #Xe132) ;; see above
            ("\\(||=\\)"                   #Xe133)
            ("[^|]\\(|=\\)"                #Xe134)
            ("\\(|>\\)"                    #Xe135)
            ("\\(\\^=\\)"                  #Xe136)
            ("\\(\\$>\\)"                  #Xe137)
            ("\\(\\+\\+\\)"                #Xe138)
            ("\\(\\+\\+\\+\\)"             #Xe139)
            ("\\(\\+>\\)"                  #Xe13a)
            ("\\(=:=\\)"                   #Xe13b)
            ("[^!/]\\(==\\)[^>]"           #Xe13c)
            ("\\(===\\)"                   #Xe13d)
            ("\\(==>\\)"                   #Xe13e)
            ("[^=]\\(=>\\)"                #Xe13f)
            ("\\(=>>\\)"                   #Xe140)
            ("\\(<=\\)"                    #Xe141)
            ("\\(=<<\\)"                   #Xe142)
            ("\\(=/=\\)"                   #Xe143)
            ("\\(>-\\)"                    #Xe144)
            ("\\(>=\\)"                    #Xe145)
            ("\\(>=>\\)"                   #Xe146)
            ("[^-=]\\(>>\\)"               #Xe147)
            ("\\(>>-\\)"                   #Xe148)
            ("\\(>>=\\)"                   #Xe149)
            ("\\(>>>\\)"                   #Xe14a)
            ("\\(<\\*\\)"                  #Xe14b)
            ("\\(<\\*>\\)"                 #Xe14c)
            ("\\(<|\\)"                    #Xe14d)
            ("\\(<|>\\)"                   #Xe14e)
            ("\\(<\\$\\)"                  #Xe14f)
            ("\\(<\\$>\\)"                 #Xe150)
            ("\\(<!--\\)"                  #Xe151)
            ("\\(<-\\)"                    #Xe152)
            ("\\(<--\\)"                   #Xe153)
            ("\\(<->\\)"                   #Xe154)
            ("\\(<\\+\\)"                  #Xe155)
            ("\\(<\\+>\\)"                 #Xe156)
            ("\\(<=\\)"                    #Xe157)
            ("\\(<==\\)"                   #Xe158)
            ("\\(<=>\\)"                   #Xe159)
            ("\\(<=<\\)"                   #Xe15a)
            ("\\(<>\\)"                    #Xe15b)
            ("[^-=]\\(<<\\)"               #Xe15c)
            ("\\(<<-\\)"                   #Xe15d)
            ("\\(<<=\\)"                   #Xe15e)
            ("\\(<<<\\)"                   #Xe15f)
            ("\\(<~\\)"                    #Xe160)
            ("\\(<~~\\)"                   #Xe161)
            ("\\(</\\)"                    #Xe162)
            ("\\(</>\\)"                   #Xe163)
            ("\\(~@\\)"                    #Xe164)
            ("\\(~-\\)"                    #Xe165)
            ("\\(~=\\)"                    #Xe166)
            ("\\(~>\\)"                    #Xe167)
            ("[^<]\\(~~\\)"                #Xe168)
            ("\\(~~>\\)"                   #Xe169)
            ("\\(%%\\)"                    #Xe16a)
            ;;("\\(x\\)"                     #Xe16b)
            ("[^:=]\\(:\\)[^:=]"           #Xe16c)
            ("[^\\+<>]\\(\\+\\)[^\\+<>]"   #Xe16d)
            ("[^\\*/<>]\\(\\*\\)[^\\*/<>]" #Xe16f))))

(defun add-fira-code-symbol-keywords ()
  (font-lock-add-keywords nil fira-code-font-lock-keywords-alist))

(add-hook 'prog-mode-hook
          #'add-fira-code-symbol-keywords)


(load! prettify-utils) ;; https://github.com/Ilazki/prettify-utils.el/blob/master/prettify-utils.el

;; Grabbed this from https://github.com/ekaschalk/.spacemacs.d/blob/master/layers/display/local/pretty-code/pretty-code.el
(defvar pretty-code-choices
  (-flatten
   (prettify-utils-generate
    ;; Functional
    (:lambda      "λ")
    (:def         "ƒ")
    (:composition "∘")

    ;; Types
    (:null        "∅")
    (:true        "𝕋") (:false       "𝔽")
    (:int         "ℤ") (:float       "ℝ")
    (:str         "𝕊")
    (:bool        "𝔹")

    ;; Flow
    (:not         "￢")
    (:in          "∈") (:not-in      "∉")
    (:and         "∧") (:or          "∨")
    (:for         "∀")
    (:some        "∃")
    (:return     "⟼") (:yield      "⟻")

    ;; Other
    (:tuple       "⨂")
    (:pipe        "")))

  "Options plist for `pretty-code-get-pairs'.")

;;; Core

(defun pretty-code-get-pairs (kwds)
  "Build an alist for prettify-symbols-alist from components from KWDS."
  (-non-nil
   (--map (when-let (major-mode-symbol (plist-get kwds it))
           (list major-mode-symbol
                 (plist-get pretty-code-choices it)))
         pretty-code-choices)))

(defun pretty-code-set-pairs (hook-pairs-alist)
  "Add hooks setting `prettify-symbols-alist' for many modes"
  (-each hook-pairs-alist
    (-lambda ((hook pretty-pairs))
      (add-hook hook
                (lambda ()
                  (setq prettify-symbols-alist pretty-pairs)
                  (prettify-symbols-mode 1))))))

;; Init the stuff

(setq js2-pretty-pairs
      (pretty-code-get-pairs
       '(
         ;; Functional
         :def
         "function"
         ;; :lambda "() =>" ;; Disabled because it conflicts with the ligatures
         ;; but I don't want to disable => because its used elsewhere

         ;; Types
         :null "null"
         :true "true" :false "false"

         ;; Flow
         :not "!"
         :and "&&" :or "||"
         :for "for"
         :return "return"

         ;; Other
         :yield "import"))

      c-pretty-pairs
      (pretty-code-get-pairs
       '( ;; Functional
         ;; :def
         ;; "void "

         ;; Types
         :null "nullptr"
         :true "true" :false "false"
         :int "int" :float "float"
         :str "std::string"
         :bool "bool"

         ;; Flow
         :not "!"
         :and "&&" :or "||"
         :for "for"
         :return "return"
         :yield "#require")))


(pretty-code-set-pairs `((js2-mode-hook ,js2-pretty-pairs)
                         (web-mode-hook ,js2-pretty-pairs)
                         (c-mode-hook ,c-pretty-pairs)
                         (c++-mode-hook ,c-pretty-pairs)))

;; When you get to the right edge, it goes back to how it normally prints
(setq prettify-symbols-unprettify-at-point 'right-edge)
