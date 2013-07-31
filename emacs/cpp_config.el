;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C++ config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'cc-mode)
(which-function-mode t) ;; shows in which function you are

;; AUTO-COMPLETE

;; (load-library "clang-completion-mode")

(require 'pos-tip) ; nicer tooltips
(load "completion")
(initialize-completions)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/projects/config/emacs/emacs.d/ac-dict")
(ac-config-default)

(require 'auto-complete-clang-async)
(defun ac-cc-mode-setup ()
  (setq ac-clang-flags '("-std=c++11" "-stdlib=libc++"))
  (setq clang-complete-executable "~/projects/config/emacs/emacs.d/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
)

(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
(global-auto-complete-mode t)
(setq ac-auto-start nil) ; do not complete automatically

;; command to comment/uncomment text
(defun c++-doc-comment-dwim (arg)
  "Comment or uncomment current line or region in a smart way.
For detail, see `comment-dwim'."
  (interactive "*P")
  (require 'newcomment)
  (let (
        (comment-start "///") (comment-end "")
        )
    (comment-dwim arg)))


(defun document-region ()
  "Insert the proper comment characters into the region of a program.
Used to comment blocks of Lisp or C code."
  (interactive)
  (let ((start-position (make-marker))
	(end-position (make-marker)))
    (set-marker start-position (mark))
    (set-marker end-position (point))
    (cond ((or (eq major-mode 'lisp-mode) (eq major-mode 'emacs-lisp-mode))
	   (comment-lines start-position end-position 'comment-lisp-line)
	   (goto-char (marker-position end-position)))
	  ((or (eq major-mode 'c-mode) (eq major-mode 'c++-c-mode))
	   (c-comment-region start-position end-position))
	  (t (error "Don't know how to comment %s mode." major-mode)))))

(defun undocument-region ()
  "Remove comment delimiters from a region of code.  Works with
comments created by function comment-region.  Lisp or C."
  (interactive)
    (let ((start-position (make-marker))
	  (end-position (make-marker))
	  (final-position (make-marker)))
      (set-marker start-position (mark))
      (set-marker end-position (point))
      (set-marker final-position end-position)
      (cond ((or (eq major-mode 'lisp-mode) (eq major-mode 'emacs-lisp-mode))
	     (comment-lines start-position end-position 'uncomment-lisp-line)
	     (goto-char (marker-position end-position)))
	    ((or (eq major-mode 'c-mode) (eq major-mode 'c++-c-mode))
	     (c-uncomment-region start-position end-position))
	    (t (error "Don't know how to uncomment %s mode." major-mode)))))

;; Keybindings:
(eval-after-load "cc-mode"
  '(progn
     (define-key c++-mode-map (kbd "C-c C-r") 'replace-regexp)
     (define-key c++-mode-map (kbd "C-c C-a") 'align-regexp)
     (define-key c++-mode-map (kbd "C-c C-f") 'flyspell-buffer)
     (define-key c++-mode-map (kbd "C-c C-w") 'whitespace-cleanup)
     ;; (define-key c++-mode-map (kbd "C-c C-c") 'comment-or-uncomment-line-or-region) use M-; instead!
     (define-key c++-mode-map (kbd "C-c C-d") 'document-region)
     ;; (define-key c++-mode-map (kbd "C-c C-c") 'comment-region)
     ;; (define-key c++-mode-map (kbd "C-c C-u") 'uncomment-region)
     (define-key c++-mode-map (kbd "C-c d"  ) 'insert-date)
     (define-key c++-mode-map (kbd "C-c C-u") 'uncomment-region)
     (define-key c++-mode-map (kbd "C-c C-w") 'whitespace-cleanup)
     (define-key c++-mode-map (kbd "M-RET"  ) 'comment-indent-new-line)
     (define-key c++-mode-map (kbd "M-/"    ) 'ac-complete-clang-async)
     (define-key c++-mode-map (kbd "M-?"    ) 'ac-clang-syntax-check)
     )
  )


;; general
(c-toggle-hungry-state 1)
(c-set-offset 'substatement-open 0)
(c-set-offset 'case-label '+)
(c-set-offset 'arglist-cont-nonempty '+)
(c-set-offset 'arglist-intro '+)
(c-set-offset 'topmost-intro-cont '+)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
(setq c-default-style "google")
(add-hook '-mode-common-hook 'flyspell-prog-mode) ;; spell check comments!

;; CMAKE MODE
(setq load-path (cons (expand-file-name "/dir/with/cmake-mode") load-path))
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

(defun ido-goto-symbol (&optional symbol-list)
      "Refresh imenu and jump to a place in the buffer using Ido."
      (interactive)
      (unless (featurep 'imenu)
        (require 'imenu nil t))
      (cond
       ((not symbol-list)
        (let ((ido-mode ido-mode)
              (ido-enable-flex-matching
               (if (boundp 'ido-enable-flex-matching)
                   ido-enable-flex-matching t))
              name-and-pos symbol-names position)
          (unless ido-mode
            (ido-mode 1)
            (setq ido-enable-flex-matching t))
          (while (progn
                   (imenu--cleanup)
                   (setq imenu--index-alist nil)
                   (ido-goto-symbol (imenu--make-index-alist))
                   (setq selected-symbol
                         (ido-completing-read "Symbol? " symbol-names))
                   (string= (car imenu--rescan-item) selected-symbol)))
          (unless (and (boundp 'mark-active) mark-active)
            (push-mark nil t nil))
          (setq position (cdr (assoc selected-symbol name-and-pos)))
          (cond
           ((overlayp position)
            (goto-char (overlay-start position)))
           (t
            (goto-char position)))))
       ((listp symbol-list)
        (dolist (symbol symbol-list)
          (let (name position)
            (cond
             ((and (listp symbol) (imenu--subalist-p symbol))
              (ido-goto-symbol symbol))
             ((listp symbol)
              (setq name (car symbol))
              (setq position (cdr symbol)))
             ((stringp symbol)
              (setq name symbol)
              (setq position
                    (get-text-property 1 'org-imenu-marker symbol))))
            (unless (or (null position) (null name)
                        (string= (car imenu--rescan-item) name))
              (add-to-list 'symbol-names name)
              (add-to-list 'name-and-pos (cons name position))))))))
