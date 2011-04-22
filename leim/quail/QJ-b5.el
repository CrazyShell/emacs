;; Quail package `chinese-qj-b5' -*- coding:chinese-big5-unix; byte-compile-disable-print-circle:t; -*-
;;   Generated by the command `titdic-convert'
;;	Date: Thu Jul 30 12:54:18 2009
;;	Original TIT dictionary file: QJ-b5.tit

;;; Comment:

;; Byte-compile this file again after any modification.

;;; Start of the header of original TIT dictionary.

;; # HANZI input table for cxterm
;; # To be used by cxterm, convert me to .cit format first
;; # .cit version 2
;; ENCODE:	BIG5
;; AUTOSELECT:	YES
;; PROMPT:	�~�r��J::����::
;; #
;; COMMENT Copyright 1991 by Yongguang Zhang.      (ygz@cs.purdue.edu)
;; COMMENT Permission to use/modify/copy for any purpose is hereby granted.
;; COMMENT Absolutely no warranties.
;; # define keys
;; VALIDINPUTKEY:	\040!"\043$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMN
;; VALIDINPUTKEY:	OPQRSTUVWXYZ[\134]^_`abcdefghijklmnopqrstuvwxyz{|}~
;; # the following line must not be removed
;; BEGINDICTIONARY

;;; End of the header of original TIT dictionary.

;;; Code:

(require 'quail)

(quail-define-package "chinese-qj-b5" "Chinese-BIG5" "��B"
 t
"�~�r��J::����::

 Copyright 1991 by Yongguang Zhang.      (ygz@cs.purdue.edu)
 Permission to use/modify/copy for any purpose is hereby granted.
 Absolutely no warranties.
"
 '(("\C-?" . quail-delete-last-char)
   
   ("." . quail-next-translation)
   (">" . quail-next-translation)
   ("," . quail-prev-translation)
   ("<" . quail-prev-translation))
 nil nil nil nil)

(quail-define-rules
(" " "�@")
("!" "�I")
("\"" "��")
("#" "��")
("$" "�L")
("%" "�H")
("&" "��")
("'" "��")
("(" "�]")
(")" "�^")
("*" "��")
("+" "��")
("," "�A")
("-" "��")
("." "�D")
("/" "��")
("0" "��")
("1" "��")
("2" "��")
("3" "��")
("4" "��")
("5" "��")
("6" "��")
("7" "��")
("8" "��")
("9" "��")
(":" "�G")
(";" "�F")
("<" "�q")
("=" "��")
(">" "�r")
("?" "�H")
("@" "�I")
("A" "��")
("B" "��")
("C" "��")
("D" "��")
("E" "��")
("F" "��")
("G" "��")
("H" "��")
("I" "��")
("J" "��")
("K" "��")
("L" "��")
("M" "��")
("N" "��")
("O" "��")
("P" "��")
("Q" "��")
("R" "��")
("S" "��")
("T" "��")
("U" "��")
("V" "��")
("W" "��")
("X" "��")
("Y" "��")
("Z" "��")
("[" "�i")
("\\" "�@")
("]" "�j")
("^" "�s")
("_" "�Z")
("`" "��")
("a" "��")
("b" "��")
("c" "��")
("d" "��")
("e" "��")
("f" "��")
("g" "��")
("h" "��")
("i" "��")
("j" "��")
("k" "��")
("l" "��")
("m" "��")
("n" "��")
("o" "��")
("p" "��")
("q" "��")
("r" "��")
("s" "��")
("t" "��")
("u" "��")
("v" "��")
("w" "�@")
("x" "�A")
("y" "�B")
("z" "�C")
("{" "�a")
("|" "�U")
("}" "�b")
("~" "��")
)
