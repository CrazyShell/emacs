;; -*- Emacs-Lisp -*-

;; Time-stamp: <07/30/2008 21:29:49 星期三 by Crazybaby>

(require 'my-face)

(set-face-foreground 'semantic-tag-highlight-face "red")
(set-face-background 'semantic-tag-highlight-face "blue")

(setq browse-kill-ring-separator-face 'font-lock-comment-delimiter-face)

(if is-before-emacs-21
    (progn
      (setq face 'ido-first-match-faces)
      (custom-set-faces '(ido-first-match-face ((((class color) (background dark)) (:foreground "yellow"))))))
  (require 'ido)
  (setq face 'ido-first-match)
  (custom-set-faces '(ido-first-match ((((class color) (background dark)) (:foreground "yellow"))))))

(set-face-foreground 'linum "cyan")

;; 颜色配置
;; 高亮显示
(set-face-foreground 'highlight "red")
(set-face-background 'highlight "blue")

;; 区域显示
(set-face-background 'region "blue")
(set-face-foreground 'region "red")

;; 语法着色
(set-face-foreground 'font-lock-comment-face "red")
(set-face-foreground 'font-lock-string-face "magenta")
(custom-set-faces
 '(font-lock-function-name-face
   ((((class color) (background dark)) (:foreground "blue")))))
(set-face-background 'font-lock-function-name-face "yellow")
(set-face-foreground 'font-lock-function-name-face "blue")
(set-face-foreground 'font-lock-variable-name-face "yellow")
(set-face-background 'font-lock-variable-name-face "black")
(set-face-foreground 'font-lock-constant-face "blue")
(set-face-background 'font-lock-constant-face "white")
(set-face-foreground 'font-lock-keyword-face "cyan")
(set-face-background 'font-lock-keyword-face "black")
(set-face-foreground 'font-lock-warning-face "white")
(set-face-background 'font-lock-warning-face "red")

;; `completion-mode'颜色设置
(unless is-before-emacs-21
  (custom-set-faces
   '(completions-first-difference
     ((((class color) (background dark)) (:foreground "red")))))
  (set-face-foreground 'completions-common-part "yellow"))

;; 设置界面
(set-background-color "Black")
(set-foreground-color "white")
(set-cursor-color "green")

;; `apropos-mode'颜色设置
(setq apropos-match-face 'my-red-face)
(setq apropos-symbol-face 'my-magenta-face)
(setq apropos-keybinding-face 'my-cyan-face)
(setq apropos-label-face 'my-underline-green-face)
(setq apropos-property-face 'font-yellow-face)

;; mode-line颜色设置
;; `which-func'颜色设置
(if window-system
    (progn
      (set-face-foreground 'mode-line "black")
      (set-face-background 'mode-line "green")
      (unless is-before-emacs-21
        (set-face-foreground 'mode-line-buffer-id "yellow")
        (set-face-background 'mode-line-buffer-id "blue")
        (set-face-foreground 'mode-line-inactive "black")
        (set-face-background 'mode-line-inactive "white")
        (set-face-foreground 'which-func "white")
        (set-face-background 'which-func "red")))
  (set-face-foreground 'mode-line "green")
  (set-face-background 'mode-line "black")
  (unless is-before-emacs-21
    (set-face-foreground 'mode-line-buffer-id "blue")
    (set-face-background 'mode-line-buffer-id "yellow")
    (set-face-foreground 'mode-line-inactive "white")
    (set-face-background 'mode-line-inactive "black")
    (set-face-foreground 'which-func "red")
    (set-face-background 'which-func "white")))

(unless is-before-emacs-21
  ;; 括号颜色设置
  (set-face-background 'show-paren-match "magenta")
  (set-face-foreground 'show-paren-match "yellow")
  (set-face-background 'show-paren-mismatch "red")

  ;; `help-mode'
  (set-face-foreground 'help-argument-name "green"))

;; `isearch'颜色设置
(set-face-foreground 'isearch "red")
(set-face-background 'isearch "blue")
(when (not is-before-emacs-21)
  (set-face-foreground 'lazy-highlight "black")
  (set-face-background 'lazy-highlight "white"))

(require 'ediff)
(if is-before-emacs-21
    (progn
      (custom-set-faces
       '(ediff-current-diff-face-B
         ((((class color) (background dark)) (:background "yellow")))))
      (set-face-foreground 'ediff-fine-diff-face-A "white")
      (set-face-background 'ediff-fine-diff-face-A "blue")
      (set-face-foreground 'ediff-current-diff-face-B "red")
      (set-face-foreground 'ediff-fine-diff-face-B "red")
      (set-face-background 'ediff-fine-diff-face-B "blue"))
  (custom-set-faces
   '(ediff-current-diff-B
     ((((class color) (background dark)) (:background "yellow")))))
  (set-face-background 'ediff-fine-diff-A "blue")
  (set-face-foreground 'ediff-current-diff-B "red")
  (set-face-foreground 'ediff-fine-diff-B "red")
  (set-face-background 'ediff-fine-diff-B "blue"))

(require 'color-moccur)
(set-face-foreground 'moccur-current-line-face "red")
(set-face-background 'moccur-current-line-face "blue")
(custom-set-faces '(moccur-face ((((class color) (background dark)) (:foreground "red")))))
(set-face-background 'moccur-face "white")

(setq Man-overstrike-face 'my-yellow-face)
(setq Man-underline-face 'my-underline-green-face)
(setq Man-reverse-face 'my-red-face)

(require 'info)
(set-face-foreground 'info-menu-header "blue")
(unless is-before-emacs-21
  (set-face-foreground 'info-menu-star "red")
  (set-face-background 'info-menu-star "yellow"))
(custom-set-faces '(info-header-node ((((class color) (background dark)) (:foreground "red")))))

(require 'mic-paren)
(set-face-background 'paren-face-match "magenta")
(set-face-foreground 'paren-face-match "yellow")
(set-face-background 'paren-face-mismatch "red")

(require 'log-view)
(if is-before-emacs-21
    (progn
      (set-face-foreground 'log-view-file-face "green")
      (set-face-foreground 'log-view-message-face "yellow"))
  (set-face-foreground 'log-view-file "green")
  (set-face-foreground 'log-view-message "yellow"))

(provide 'my-face-settings)
