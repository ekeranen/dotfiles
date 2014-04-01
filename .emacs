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
(setq c-default-style '((java-mode . "java") (awk-mode . "awk") (other . "stroustrup" )))

;; Set frame size
(defun setCustomSize (frame)
  (set-frame-height frame 51) ;; 50 rows
  (set-frame-width frame 101) ;; 100 columns
)
(defun setCurrentCustomSize ()
  (setCustomSize (selected-frame))
)

(add-to-list 'after-make-frame-functions 'setCustomSize t)
(add-hook 'after-init-hook 'setCurrentCustomSize t)
