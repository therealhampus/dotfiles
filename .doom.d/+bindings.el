;;; +bindings.el -*- lexical-binding: t; -*-


;; register thing for angle brackets <>
(meow-thing-register 'angle '(pair ("<") (">")) '(pair ("<") (">")))
(add-to-list 'meow-char-thing-table '(?a . angle))

;; register thing for quotes (double, single and back tick)
(meow-thing-register 'quote
                     '(regexp "'\\|`\\|\"" "'\\|`\\|\"")
                     '(regexp "'\\|`\\|\"" "'\\|`\\|\""))
(add-to-list 'meow-char-thing-table '(?q . quote))


;; register thing for xml/html tags
(meow-thing-register 'tag
                     '(pair-regexp ("<[[:alnum:][:space:]=_{}:\"]+>") ("</[[:alnum:]]*>") )
                     '(pair-regexp ("<[[:alnum:][:space:]=_{}:\"]+>") ("</[[:alnum:]]*>")))
(add-to-list 'meow-char-thing-table '(?t . tag))
