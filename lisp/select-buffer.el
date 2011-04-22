;; -*- Emacs-Lisp -*-

;; Time-stamp: <09/23/2008 11:41:19 星期二 by Crazybaby>

;; 使用
;; (require 'select-buffer)
;; (global-set-key (kbd "M-N") 'select-buffer-forward)
;; (global-set-key (kbd "M-P") 'select-buffer-backward)
;; (global-set-key (kbd "C-x t") 'sb-toggle-keep-buffer)
;; TODO: 如果出现bug, C-x t不显示`sb-buffer-name'buffer

(require 'my-face)

(defvar sb-active-buffer-face 'my-red-face "default face for active buffer")
(defvar sb-inactive-buffer-face 'my-white-face "default face for inactive buffer")
(defvar sb-indicator-face 'my-green-face "the face of select buffer indicator")

(defvar sb-cur-buffer-index 0 "当前选择的buffer的索引")
(defvar sb-buffer-name "*select buffer*" "select buffer的名字")
(defvar sb-buffer-min-height 2 "`sb-buffer-name'buffer最小的高度")
(defvar sb-keep-buffer t "是否始终显示`sb-buffer-name'window")
(defvar sb-disp-buf-list-timer nil "显示`sb-buffer-name'buffer的timer")

(defvar sb-indicator " | " "*indicator of select buffer")
(defvar sb-buffer-exclude-regexps
  (list "^ .*" (regexp-quote sb-buffer-name) (regexp-quote "*svn-process*")
        (regexp-quote "*Ediff Registry*") (regexp-quote "*svn-log-edit*"))
  "*if buffer name match the regexp, ignore it.")
(defvar sb-auto-adjust-buffer nil "*Non-nil means automatically adjust the height of `sb-buffer-name'window")

(defadvice other-window (after sb-other-window)
    (when (sb-window-p (selected-window))
      (other-window
       (if (and (number-or-marker-p (ad-get-arg 0)) (< (ad-get-arg 0) 0)) -1 1) (ad-get-arg 1))))

(defun sb-window-p (window)
  "window WINDOW是否是`sb-buffer-name'window"
  (string= (buffer-name (window-buffer window)) sb-buffer-name))

(defun sb-buffer-visible-p ()
  "`sb-buffer-name'buffer是否存在于当前frame"
  (let ((list (window-list)) exist)
    (while (and list (not exist))
      (setq exist (string= (buffer-name (window-buffer (car list))) sb-buffer-name))
      (setq list (cdr list)))
    exist))

(defun sb-keep-buffer (keep)
  "控制是否始终显示`sb-buffer-name'buffer, KEEP为t则显示, 否则不显示"
  (interactive "P")
  (setq sb-keep-buffer keep)
  (sb-toggle-timer keep)
  (if keep
      (ad-activate 'other-window)
    (ad-deactivate 'other-window)
    (let ((buffer (get-buffer sb-buffer-name)))
      (when buffer
        (delete-windows-on buffer)
        (kill-buffer buffer)))))

(defun sb-toggle-timer (enable)
  "toggle `sb-disp-buf-list-timer'"
  (if enable
      (unless sb-disp-buf-list-timer
          (setq sb-disp-buf-list-timer (run-with-idle-timer 0.1 t 'sb-update-buffer)))
    (when sb-disp-buf-list-timer
      (cancel-timer sb-disp-buf-list-timer)
      (setq sb-disp-buf-list-timer nil))))

(defun sb-buffer-forward(buffer-list)
  (let ((len (length buffer-list)))
  (setq sb-cur-buffer-index (% (1+ sb-cur-buffer-index) len))))

(defun sb-buffer-backword(buffer-list)
  (let ((len (length buffer-list)))
    (setq sb-cur-buffer-index (1- sb-cur-buffer-index))
    (if (< sb-cur-buffer-index 0)
        (setq sb-cur-buffer-index (% (+ len sb-cur-buffer-index) len)))))

(defun sb-buffer-list ()
  "根据`sb-buffer-exclude-regexps'过滤不需要的buffer得到buffer list"
  (if (null sb-buffer-exclude-regexps)
      (buffer-list)
    (let ((regexp (mapconcat 'identity sb-buffer-exclude-regexps "\\|"))
          (buffer-list nil))
      (dolist (buffer (buffer-list))
        (if (not (string-match regexp (buffer-name buffer)))
            (setq buffer-list (append buffer-list (list buffer) nil))))
      buffer-list)))

(defun sb-buffer-name (buffer)
  (propertize (buffer-name buffer) 'face sb-inactive-buffer-face))

(defun sb-create-buffer ()
  "创建名字为`sb-buffer-name'的buffer"
  (unless (sb-buffer-visible-p)
    (let ((obuffer (current-buffer))
          (window (window-at 0 0))
          (owindow (selected-window))
          (buffer (get-buffer-create sb-buffer-name))
          (height (max window-min-height sb-buffer-min-height))
          nwindow result)
      (setq nwindow (split-window window height))
      (setq result (equal window owindow))
      (if result (setq owindow nwindow))
      (set-window-buffer window buffer)
      (if (= height window-min-height)
          (with-current-buffer buffer
            (make-local-variable 'window-min-height)
            (setq window-min-height sb-buffer-min-height)
            (shrink-window (- height window-min-height))))
      (select-window owindow))))

(defun sb-disp-buf-list (buffer-list)
  "在`sb-buffer-name'buffer显示BUFFER-LIST"
  (let* ((len (length buffer-list))
         (index sb-cur-buffer-index)
         (indicator (propertize sb-indicator 'face sb-indicator-face))
         (left-buffers-name (mapconcat 'sb-buffer-name (butlast buffer-list (- len index)) indicator))
         (right-buffers-name (mapconcat 'sb-buffer-name (nthcdr (1+ index) buffer-list) indicator))
         string)
    (setq string
          (format "%s"
                  (concat
                   left-buffers-name
                   (if (not (string= left-buffers-name "")) indicator)
                   (propertize (buffer-name (nth index buffer-list)) 'face sb-active-buffer-face)
                   (if (not (string= right-buffers-name "")) indicator)
                   right-buffers-name)))
    (if (not sb-keep-buffer)
        (message string)
      (sb-create-buffer)
      (let ((buffer (get-buffer sb-buffer-name)))
        (set-buffer buffer)
        (setq buffer-read-only nil)
        (erase-buffer)
        (insert string)
        (setq buffer-read-only t)
        (let* ((window (get-buffer-window buffer))
               (oheight (window-height window))
               (len (length string))
               (width (window-width))
               height)
          (setq height (1+ (/ len width)))
          (if (/= (% len width) 0) (setq height (1+ height)))
          ;; TODO: with-selected-window会改变buffer顺序
          ;; 怎样不改变buffer顺序enlarge-window
          (when sb-auto-adjust-buffer
            (with-selected-window window
              (enlarge-window (- height oheight)))))))))

(defun sb-update-buffer ()
  (sb-disp-buf-list (sb-buffer-list)))

(defun sb-disp-buf-list-with-switch (buffer-list)
  (sb-disp-buf-list buffer-list)
  (switch-to-buffer (nth sb-cur-buffer-index buffer-list) t))

(defun select-buffer (&optional arg)
  "像windows中Alt+Tab那样选择buffer, 如果ARG为nil, 则向前选择buffer, 否则向后选择buffer"
  (let* ((select-function (if arg 'sb-buffer-backword 'sb-buffer-forward))
         (buffer-list (sb-buffer-list))
         (exit-flag nil)
         key fun)
    (sb-toggle-timer nil)
    (funcall select-function buffer-list)
    (sb-disp-buf-list-with-switch buffer-list)
    (while (not exit-flag)
      (setq key (read-key-sequence-vector nil))
      (setq fun (key-binding key))
      (setq last-command-event (aref key (1- (length key))))
      (cond
       ((equal fun 'select-buffer-forward)
        (sb-buffer-forward buffer-list)
        (sb-disp-buf-list-with-switch buffer-list))
       ((equal fun 'select-buffer-backward)
        (sb-buffer-backword buffer-list)
        (sb-disp-buf-list-with-switch buffer-list))
       ((equal fun 'keyboard-quit)
        (setq sb-cur-buffer-index 0)
        (setq exit-flag 1)
        (sb-update))
       (t (setq exit-flag 2))))
    ;; 切换到选择的buffer
    (let ((selected-buffer (nth sb-cur-buffer-index buffer-list)))
      (setq sb-cur-buffer-index 0)
      (when (buffer-name selected-buffer)
        (switch-to-buffer selected-buffer)))
    ;; 执行最后一个按键对应的命令
    (when (= exit-flag 2)
      (when fun
        (call-interactively fun)
        (if (eq fun 'gdb) (sb-keep-buffer nil))))
    (sb-update)
    (sb-toggle-timer sb-keep-buffer)))

(defun select-buffer-forward ()
  "向前选择buffer"
  (interactive)
  (select-buffer))

(defun select-buffer-backward ()
  "向后选择buffer"
  (interactive)
  (select-buffer t))

(defun sb-toggle-keep-buffer ()
  "toggle `sb-keep-buffer'"
  (interactive)
  (setq sb-keep-buffer (not sb-keep-buffer))
  (sb-keep-buffer sb-keep-buffer))

(defun sb-toggle-auto-just-buffer ()
  "toggle `sb-auto-just-buffer'"
  (interactive)
  (setq sb-auto-adjust-buffer (not sb-auto-adjust-buffer)))

(defun sb-update ()
  (if sb-keep-buffer (sb-update-buffer)))

(sb-keep-buffer sb-keep-buffer)
(sb-update)

;; TODO: 怎样可以不要以下的小patch
(require 'ediff)

(defvar sb-state-ediff nil "select-buffer的状态")

(add-hook 'ediff-startup-hook
          '(lambda ()
             (setq sb-state-ediff sb-keep-buffer)
             (sb-keep-buffer nil)))
(add-hook 'ediff-quit-hook '(lambda () (sb-keep-buffer sb-state-ediff)))

(defvar command-with-sb
  '(kill-buffer
    kill-this-buffer
    switch-to-other-buffer
    ido-switch-buffer
    find-file
    ido-find-file
    ido-exit-minibuffer
    other-window
    delete-other-windows
    visit-.emacs
    recentf-open-files-complete
    svn-status-this-dir-hide
    svn-status-hide
    svn)
  "*运行命令后需要执行`sb-update'的命令")

(defvar command-with-sb-kill
  '(gdb)
  "*运行命令后需要执行`sb-keep-buffer'的命令")

(defun sb-post-command ()
  (if (memq this-command command-with-sb)
      (sb-update)))

(defun sb-kill-pre-command ()
  (if (memq this-command command-with-sb-kill) (sb-keep-buffer nil)))

(add-hook 'post-command-hook 'sb-post-command)
(add-hook 'pre-command-hook 'sb-kill-pre-command)

(defmacro def-command-sb (fun-name command)
  "有些命令在`sb-buffer-name'存在的时候不能正确的执行, 可以用这个宏重新定义下这些命令"
  `(defun ,fun-name ()
     (interactive)
     (let ((state sb-keep-buffer))
       (sb-toggle-timer nil)
       (call-interactively ,command)
       (sb-toggle-timer state))))

(def-command-sb query-replace-sb 'query-replace)
(def-command-sb describe-key-sb 'describe-key)
(def-command-sb describe-symbol-sb 'describe-symbol)
(def-command-sb find-symbol-sb 'find-symbol)
(def-command-sb find-symbol-fun-on-key-sb 'find-symbol-fun-on-key)
(def-command-sb svn-status-revert-sb 'svn-status-revert)
(def-command-sb recentf-open-files-complete-sb 'recentf-open-files-complete)
(def-command-sb zap-to-char-sb 'zap-to-char)
(def-command-sb save-buffer-sb 'save-buffer)

(provide 'select-buffer)
