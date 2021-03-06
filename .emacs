;; Turn off the startup message
(setq inhibit-startup-message t)

;; Turn off ~ backup files
(setq make-backup-files nil)

;; Turn on line numbers
(global-linum-mode t)
(setq linum-format "%d ")

;; Turn on column numbers
(setq column-number-mode t)

;; Delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq-default show-trailing-whitespace t)

;; Insert spaces for tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default tab-stop-list (number-sequence 4 200 4))

;; No verilog auto newline
(setq verilog-auto-newline nil)

;; Setup C/C++ mode
(setq c-default-style
      '(
        (java-mode . "java")
        (awk-mode . "awk")
        (other . "stroustrup" )
        )
      )
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)) ;; Open .h files as C++
(add-to-list 'auto-mode-alist '("wscript.*" . python-mode)) ;; Open wscript files as python
(add-hook
 'c++-mode-hook
 '(lambda()
    (add-to-list 'c-offsets-alist '(innamespace . 0))
  )
)
(add-hook
 'c++-mode-hook
 '(lambda()
    ;; We could place some regexes into `c-mode-common-hook', but note that their evaluation order
    ;; matters.
    (font-lock-add-keywords
     nil '(;; complete some fundamental keywords
           ("\\<\\(void\\|unsigned\\|signed\\|char\\|short\\|bool\\|int\\|long\\|float\\|double\\)\\>" . font-lock-keyword-face)
           ;; namespace names and tags - these are rendered as constants by cc-mode
           ("\\<\\(\\w+::\\)" . font-lock-function-name-face)
           ;;  new C++11 keywords
           ("\\<\\(alignof\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>" . font-lock-keyword-face)
           ("\\<\\(char16_t\\|char32_t\\)\\>" . font-lock-keyword-face)
           ;; PREPROCESSOR_CONSTANT, PREPROCESSORCONSTANT
           ("\\<[A-Z]*_[A-Z_]+\\>" . font-lock-constant-face)
           ("\\<[A-Z]\\{3,\\}\\>"  . font-lock-constant-face)
           ;; hexadecimal numbers
           ("\\<0[xX][0-9A-Fa-f]+\\>" . font-lock-constant-face)
           ;; integer/float/scientific numbers
           ("\\<[\\-+]*[0-9]*\\.?[0-9]+\\([ulUL]+\\|[eE][\\-+]?[0-9]+\\)?\\>" . font-lock-constant-face)
           ;; c++11 string literals
           ;;       L"wide string"
           ;;       L"wide string with UNICODE codepoint: \u2018"
           ;;       u8"UTF-8 string", u"UTF-16 string", U"UTF-32 string"
           ("\\<\\([LuU8]+\\)\".*?\"" 1 font-lock-keyword-face)
           ;;       R"(user-defined literal)"
           ;;       R"( a "quot'd" string )"
           ;;       R"delimiter(The String Data" )delimiter"
           ;;       R"delimiter((a-z))delimiter" is equivalent to "(a-z)"
           ("\\(\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(\\)" 1 font-lock-keyword-face t) ; start delimiter
           (   "\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(\\(.*?\\))[^\\s-\\\\()]\\{0,16\\}\"" 1 font-lock-string-face t)  ; actual string
           (   "\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(.*?\\()[^\\s-\\\\()]\\{0,16\\}\"\\)" 1 font-lock-keyword-face t) ; end delimiter

           ;; user-defined types (rather project-specific)
           ("\\<[A-Za-z_]+[A-Za-z_0-9]*_\\(type\\|ptr\\)\\>" . font-lock-type-face)
           ("\\<\\(xstring\\|xchar\\)\\>" . font-lock-type-face)
           ))
    ) t)

;; Set frame size
(defun setCustomSize (frame)
  (when window-system
  (set-frame-height frame 51) ;; 50 rows
  (set-frame-width frame 101) ;; 100 columns
  )
)
(defun setCurrentCustomSize ()
  (setCustomSize (selected-frame))
)
(add-to-list 'after-make-frame-functions 'setCustomSize t)
(add-hook 'after-init-hook 'setCurrentCustomSize t)

;; Confirm exit to avoid accidently shutting down.
(setq confirm-kill-emacs 'yes-or-no-p)

;; Sane scrolling
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; Reload file from disk function
(defun reload-from-disk()
  "Reload file from disk."
  (interactive) (revert-buffer t t))

;; Highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "light goldenrod")
(set-face-background 'region "lawn green")
(set-face-foreground 'region "black")

;; Show both parentheses
(show-paren-mode 1)

;; Key bindings
(global-set-key "\C-c\C-s" 'save-buffer)
(global-set-key [f5] 'reload-from-disk)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
