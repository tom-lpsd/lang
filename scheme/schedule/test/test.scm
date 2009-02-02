;; -*- coding: utf-8; mode: scheme -*-
;; test schedule script.
;; $Id:$

(use gauche.test)
(use file.util)
(use text.tree)
(use sxml.ssax)
(use sxml.sxpath)
(use kahua)
(use kahua.test.xml)
(use kahua.test.worker)

(test-start "schedule")

(define GOSH "/Users/tom/apps/bin/gosh")
(define *PLUGINS* '(schedule.scm))
(define *config* "test.conf")

(sys-system "rm -rf _tmp _work schedule")
(sys-mkdir "schedule" #o755)
(sys-mkdir "_tmp" #o755)
(sys-mkdir "_work" #o755)
(sys-mkdir "_work/plugins" #o755)
(sys-mkdir "_work/templates" #o755)
(sys-mkdir "_work/templates/schedule" #o755)

(copy-file "../plugins/schedule.scm"  "_work/plugins/schedule.scm")
(copy-file "../templates/page.xml"  "_work/templates/schedule/page.xml")

(kahua-init *config*)

;;------------------------------------------------------------
;; Run schedule
(test-section "kahua-server schedule.kahua")

(with-worker
 (w `(,GOSH "-I.." "-I/Users/tom/apps/kahua/lib/kahua" "kahua-server.scm" "-c" ,*config*
            "../schedule/schedule.kahua"))

 (test* "run schedule.kahua" #t (worker-running? w))


;  (test* "schedule"
;         '(html (head (title "Hello, world!"))
;                (body (h1 "Hello, world!")
;                      (a (@ (href ?&)) "version")))
;         (call-worker/gsid w '() '() (lambda (h b) (tree->string b)))
;         (make-match&pick w))

;  (test* "version"
;        '(html (head (title "schedule: version 0.0.0"))
;               (body (h1 "schedule: version 0.0.0")
;                     (a ?@ ?*)))
;        (call-worker/gsid w '() '() (lambda (h b) (tree->string b)))
;        (make-match&pick w))

 )

(test-end)

