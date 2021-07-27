#! /usr/bin/csi -script

(import (sxml-transforms)
        (chicken string)
        (chicken condition)
        (chicken process-context)
        (chicken file)
        (chicken io))

(define (template paragraphs)
    `(html
        (head
            (link (@ (href "main.css")))
            (script (@ (type "module") (src "main.js"))))
        (body
            (main
                (article ,@paragraphs)))))

(define test-article
    "This is some textskalkjklk #\\newline
    here is some more after the \\n.")

;;; Input the text of an article with paragraphs seperated by newlines,
;;; Output list of p tags
(define (ARTICLE->HTML article)
    (SXML->HTML ; Compile to html
        (template   ; Embed into template
        (map
            (lambda (paragraph) `(p ,paragraph)) ; include split text in (p) tags)
            (string-split article "\n")))))


(set! filename (car (command-line-arguments)))

(if (and (string? filename) (file-exists? filename))    ; Run checks on filename
    (with-output-to-file (string-append filename ".html") ; write to file
        (lambda () (write (ARTICLE->HTML (with-input-from-file filename read-string)))))
    (abort "Invalid file name provided."))
