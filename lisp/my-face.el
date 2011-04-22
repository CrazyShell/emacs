;; -*- Emacs-Lisp -*-

;; Time-stamp: <07/30/2008 21:29:30 星期三 by Crazybaby>

;; 我自定义的一些face
(defface my-white-face
  '((((class color) (background dark)) (:foreground "white")) (t ()))
  "我自定义的white face")
(defface my-red-face
  '((((class color) (background dark)) (:foreground "red")) (t ()))
  "我自定义的red face")
(defface my-green-face
  '((((class color) (background dark)) (:foreground "green")) (t ()))
  "我自定义的green face")
(defface my-blue-face
  '((((class color) (background dark)) (:foreground "blue")) (t ()))
  "我自定义的blue face")
(defface my-lightblue-face
  '((((class color) (background light)) (:foreground "blue")) (t ()))
  "我自定义的lightblue face")
(defface my-yellow-face
  '((((class color) (background dark)) (:foreground "yellow")) (t ()))
  "我自定义的yellow face")
(defface my-cyan-face
  '((((class color) (background dark)) (:foreground "cyan")) (t ()))
  "我自定义的cyan face")
(defface my-magenta-face
  '((((class color) (background dark)) (:foreground "magenta")) (t ()))
  "我自定义的magenta face")
(defface my-underline-green-face
  '((((class color) (background dark)) (:underline t :foreground "green")) (t ()))
  "我自定义的underline green face")
(defface my-black-red-face
  '((((class color) (background dark)) (:foreground "black" :background "red")) (t ()))
  "我自定义的black-red face")
(defface my-green-red-face
  '((((class color) (background dark)) (:foreground "green" :background "red")) (t ()))
  "我自定义的green-red face")
(defface my-yellow-red-face
  '((((class color) (background dark)) (:foreground "yellow" :background "red")) (t ()))
  "我自定义的yellow-red face")
(defface my-red-yellow-face
  '((((class color) (background dark)) (:foreground "red" :background "yellow")) (t ()))
  "我自定义的red-yellow face")
(defface my-red-blue-face
  '((((class color) (background dark)) (:foreground "red" :background "blue")) (t ()))
  "我自定义的red-blue face")

(provide 'my-face)
