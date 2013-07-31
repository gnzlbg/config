;; Hey Emacs, this is -*- Emacs-Lisp -*- :-)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; gonzalo's emacs configuration file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; STARTUP: turn off crap at emacs startup
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq ns-pop-up-frames nil)

;; LOAD PATH
(add-to-list 'load-path "~/projects/config/emacs/emacs.d/")
(setenv "PATH" (concat "/usr/texbin:/usr/local/bin:" (getenv "PATH")))
(setq exec-path (append '("/usr/texbin" "/usr/local/bin") exec-path))

;; emacs server daemon name
(setq server-name "es")

;; start edit server
(require 'edit-server)
(edit-server-start)

;; COLOR THEME
(add-to-list 'custom-theme-load-path "~/projects/config/emacs/emacs.d/themes/")
(add-to-list 'custom-theme-load-path "~/projects/config/emacs/emacs.d/themes/solarized/")
(add-to-list 'custom-theme-load-path "~/projects/config/emacs/emacs.d/themes/tomorrow/")
(add-to-list 'custom-theme-load-path "~/projects/config/emacs/emacs.d/themes/molokai/")
(add-to-list 'custom-theme-load-path "~/projects/config/emacs/emacs.d/themes/awaken/")
(load-theme 'solarized-dark t)
;(load-theme 'zenburn t)
;(load-theme 'tomorrow-night t)
;(load-theme 'monokai t)
;(load-theme 'wombat t)
;(load-theme 'awaken t)

;; FONTS
(set-face-attribute 'default nil
                    :family "Inconsolata" :height 125)
(set-face-attribute 'font-lock-comment-face nil
                    :family "Inconsolata" :height 125 :slant 'italic)

;; GLOBAL KEYS
(global-set-key [f1]                'info)
(global-set-key [f2]                'grep-find)
(global-set-key [f3]                'start-or-end-macro)
(global-set-key [f5]                'compile)
(global-set-key [f6]                'next-error)
(global-set-key [f7]                'gdb)
(global-set-key [f8]                'shell)
(global-set-key (kbd "C-c C-r")     'replace-regexp)
(global-set-key (kbd "C-c C-a")     'align-regexp)
(global-set-key (kbd "C-c C-f")     'flyspell-buffer)
(global-set-key (kbd "C-c C-w")     'whitespace-cleanup)
(global-set-key (kbd "C-c C-c")     'comment-region)
(global-set-key (kbd "C-c C-u")     'uncomment-region)
(global-set-key (kbd "C-c d")       'insert-date)
(global-set-key (kbd "S-C-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>")  'shrink-window)
(global-set-key (kbd "S-C-<up>")    'enlarge-window)
(global-set-key [delete]            'delete-char)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-q" 'backward-kill-word)
(global-set-key "\C-w" 'kill-region)

;; GENERAL
(fset 'yes-or-no-p 'y-or-n-p)                 ;; y/n
(setq display-time-day-and-date t) (display-time)
(setq default-major-mode 'text-mode)
(global-font-lock-mode t)                     ;; fontification in all modes.
(setq font-lock-maximum-decoration t)         ;; maximum possible fontification.
(tool-bar-mode nil)                           ;; no toolbar in gui mode
;(setq visible-bell t)                        ;; flash instead of error beep

;; smooth scrolling:
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

;; highlighting:
(setq query-replace-highlight t)     ;; during query.
(setq search-highlight t)	     ;; incremental search

;; parentheses:
(require 'paren) (show-paren-mode t) ;; matching parentheses next to cursor.
(transient-mark-mode t)		     ;; region between point and mark.
;; Buffer/minibuffer
(setq enable-recursive-minibuffers t)  ;; allow recursive editing in minibuffer
(require 'uniquify)                        ;; help make buffer names distinguishable
(setq uniquify-buffer-name-style 'reverse) ;; customize uniquify-style

;; line numbers:
(line-number-mode 1)                 ;; makes the line number show up
(column-number-mode 1)               ;; makes the column number show up
(global-linum-mode 1)
(setq linum-format "%d ")

;; indentaion/spacement/newlines:
(setq require-final-newline t)			  ;; last line end in a carriage return.
(setq next-line-add-newlines nil)		  ;; no new lines created with "arrow-down key" at buffer end
(setq-default indent-tabs-mode nil)		  ;; introduce spaces instead of tabs by default.
(setq-default truncate-lines nil)		  ;; truncate lines if they are too long...
(setq-default truncate-partial-width-windows nil) ;; and when multiple windows.

;; whitespace hate:
(require 'whitespace)
(setq-default fill-column 80)
(setq whitespace-line-column nil)
(setq whitespace-style '(face empty trailing lines-tail))
(set-face-attribute 'whitespace-line nil
                    ;:background "SlateBlue4"
                    :foreground "DeepPink"
                    :weight 'bold)
(global-whitespace-mode 1)

;; make marks visible
(require 'visible-mark)
(setq visible-mark-max 1)
(global-visible-mark-mode)

;; backup files:
(defvar user-temporary-file-directory "~/.emacs-backups/")
(make-directory user-temporary-file-directory t)
(setq backup-directory-alist `((".*" . ,user-temporary-file-directory)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))

;; backup options:
(setq
 backup-by-copying t      ; don't clobber symlinks
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

;; latex/flyspell:
(setq LaTeX-command "latex -synctex=1 -shell-escape")
(setq-default ispell-program-name "aspell")
(setq-default ispell-list-command "list")

;; yasnippet
;(require 'yasnippet)
;(yas-global-mode 1)

;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
;(ac-set-trigger-key "TAB")
;(ac-set-trigger-key "<tab>")

;; ORG - MODE
(load-file "~/projects/config/emacs/org_config.el")

;; ;; C/C++ Mode
(load-file "~/projects/config/emacs/cpp_config.el")

;; dired Mode
(custom-set-variables '(dired-dwim-target t))  ;; makes dired smart!

;; Redefine the sorting in dired to flip between sorting on name, size,
;; time, and extension,  rather than simply on name and time.

(defun dired-sort-toggle ()
  ;; Toggle between sort by date/name.  Reverts the buffer.
  (setq dired-actual-switches
        (let (case-fold-search)

          (cond

           ((string-match " " dired-actual-switches) ;; contains a space
            ;; New toggle scheme: add/remove a trailing " -t" " -S",
            ;; or " -U"

            (cond

             ((string-match " -t\\'" dired-actual-switches)
              (concat
               (substring dired-actual-switches 0 (match-beginning 0))
               " -X"))

             ((string-match " -X\\'" dired-actual-switches)
              (concat
               (substring dired-actual-switches 0 (match-beginning 0))
               " -S"))

             ((string-match " -S\\'" dired-actual-switches)
              (substring dired-actual-switches 0 (match-beginning 0)))

             (t
              (concat dired-actual-switches " -t"))))

           (t
            ;; old toggle scheme: look for a sorting switch, one of [tUXS]
            ;; and switch between them. Assume there is only ONE present.
            (let* ((old-sorting-switch
                    (if (string-match (concat "[t" dired-ls-sorting-switches "]")
                                      dired-actual-switches)
                        (substring dired-actual-switches (match-beginning 0)
                                   (match-end 0))
                      ""))

                       (new-sorting-switch
                        (cond
                         ((string= old-sorting-switch "t")
                          "X")
                         ((string= old-sorting-switch "X")
                          "S")
                         ((string= old-sorting-switch "S")
                          "")
                         (t
                          "t"))))
                  (concat
                   "-l"
                   ;; strip -l and any sorting switches
                   (dired-replace-in-string (concat "[-lt"
                                                    dired-ls-sorting-switches "]")
                                            ""
                                            dired-actual-switches)
                   new-sorting-switch))))))

  (dired-sort-set-modeline)
  (revert-buffer))

(setq dired-listing-switches "-alh")

;; ediff Mode
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function (if (> (frame-width) 150)
                                          'split-window-horizontally
                                        'split-window-vertically))

;; MACROS
;; macros record/stop recording
(defun start-or-end-macro (arg)
  (interactive "P")
  (if defining-kbd-macro
      (if arg
          (end-kbd-macro arg)
        (end-kbd-macro))
    (start-kbd-macro arg)))

;; insert date into buffer at point
(defun insert-date()
  "Insert date at point."
  (interactive)
  (insert (format-time-string "%a %Y-%m-%d - %l:%M %p")))


;; TEXT-MODE
(add-hook 'text-mode-hook
          '(lambda ()
             (turn-on-auto-fill)
             (auto-fill-mode 1)
             ))


;; SHELL MODE

;(auto-show-make-point-visible)						     ;; position the cursor to end of output in shell mode.
(setq comint-buffer-maximum-size 10240)					     ;; set maximum-buffer size for shell-mode
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)	     ;; truncate shell buffer maximum-size.
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt) ;; passwords not shown in clear text
(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)		     ;; remove ctrl-m from shell output.

;; shell colors
(setq ansi-color-names-vector ; better contrast colors
      ["black" "red4" "green4" "yellow4"
       "blue3" "magenta4" "cyan4" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'shell-mode-hook
	  '(lambda ()
             (local-set-key [up]        ; cycle backward through command history
                            '(lambda () (interactive)
                               (if (comint-after-pmark-p)
                                   (comint-previous-input 1)
                                 (previous-line 1))))
	     (local-set-key [down]      ; cycle forward through command history
                            '(lambda () (interactive)
                               (if (comint-after-pmark-p)
                                   (comint-next-input 1)
                                 (forward-line 1))))
             ))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq ns-pop-up-frames nil)


;; TRAMP
(require 'tramp)


;; HASKELL
(load "~/projects/config/emacs/emacs.d/haskell/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
(setq haskell-font-lock-symbols t)
