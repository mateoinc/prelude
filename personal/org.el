(require 'org)
;; Autofill
(add-hook 'org-mode-hook 'turn-on-auto-fill)
;; CDLatex on org files
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)
;; Directory
(custom-set-variables
 '(org-directory "~/Documents/org")
 '(org-agenda-files (list org-directory
                          "~/Documents/Bib"
                          "~/Documents/org/roam")))
;; Agenda
(setq org-agenda-include-diary t)
;; ipython
(require 'ob-ipython)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ipython . t)
   ;; other languages..
   ))
;; Drill
(require 'org-drill)
;; Default note target
(setq org-directory "~/Documents/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))
;; org keybinds
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
;; Org-rifle keybinds
(global-set-key (kbd "C-c M-r") 'helm-org-rifle)
(global-set-key (kbd "C-c M-a") 'helm-org-rifle-agenda-files)
;; Set default column view headings: Task Total-Time Time-Stamp
(setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")
;; Capture templates
;; Define the custom capture templates
(setq org-capture-templates
      '(("t" "todo" entry (file org-default-notes-file)
         "* TODO %?\n%u\n%a\n" :clock-in t :clock-resume t)
        ("m" "Meeting" entry (file+headline "~/Documents/org/schedule.org" "Meetings")
         "* %? :MEETING:\n" )
        ("s" "Seminar" entry (file+headline "~/Documents/org/schedule.org" "Seminars")
         "* %? :SEMINADR:\n" )
        ("b" "Birthday" entry (file+headline "~/Documents/org/schedule.org" "Birthdays")
         "* %? :BIRTHDAY:\n" )
        ("c" "Class" entry (file+headline "~/Documents/org/schedule.org" "Classes")
         "* %? :CLASS:\n" )
        ("e" "Meeting" entry (file+headline "~/Documents/org/schedule.org" "Meetings")
         "* %? :EVENT:\n" )
        ("d" "Diary" entry (file+datetree "~/Documents/org/diary.org")
         "* %?\n%U\n" :clock-in t :clock-resume t)
        ("i" "Idea" entry (file org-default-notes-file)
         "* %? :IDEA: \n%t" :clock-in t :clock-resume t)
        ("n" "Next Task" entry (file+headline org-default-notes-file "Tasks")
         "** NEXT %? \nDEADLINE: %t")
        ("S" "Simple Flashcard" entry (file+headline "~/Documents/org/drills.org" "Simple Flashcards")
         "* Item :drill:\n%t\n%^{Question}\n** Answer\n%^{Answer}")
        ("Z" "Cloze Flashcard" entry (file+headline "~/Documents/org/drills.org" "Cloze Flashcards")
         "* Item :drill:\n %t\n%^{Clozed ([]) text}")
        ))
;; Where to send captures
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))
;; Run/highlight code using babel in org-mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t)
   (ipython . t)
   (shell . t)
   ;; Include other langpuages here...
   ))
;; Syntax highlight in #+BEGIN_SRC blocks
(setq org-src-fontify-natively t)
;; Don't prompt before running code in org
(setq org-confirm-babel-evaluate nil)
;; Fix an incompatibility between the ob-async and ob-ipython packages
(setq ob-async-no-async-languages-alist '("ipython"))

;;; Bibliography
(setq reftex-default-bibliography '("~/Documents/org/refs.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/Documents/org/refnotes.org"
      org-ref-default-bibliography '("~/Documents/org/refs.bib")
      org-ref-pdf-directory "~/Documents/bibtex-pdfs/")

(setq bibtex-completion-bibliography "~/Documents/org/refs.bib"
      bibtex-completion-library-path   "~/Documents/bibtex-pdfs/"
      bibtex-completion-notes-path "~/Documents/org/helm-bibtex-notes")

(require 'org-ref)
(setq org-ref-insert-cite-key "C-c )")
(setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))

;; Roam

(use-package org-roam
  :ensure t
  :hook
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory "~/Documents/org/roam")
  (org-roam-index-file "index.org")
  :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph-show))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))

(global-set-key (kbd "C-x M-r r") 'org-roam)
(global-set-key (kbd "C-x M-r f") 'org-find-non-ref-file)
(global-set-key (kbd "C-x M-r g") 'org-roam-graph-show)
(global-set-key (kbd "C-x M-r i") 'org-insert-non-ref)
(global-set-key (kbd "C-x M-r I") 'org-roam-insert-immediate)
(global-set-key (kbd "C-x M-r t") 'org-roam-today)
(global-set-key (kbd "C-x M-r s") 'org-roam-server-mode)
(global-set-key (kbd "C-x M-r C-i") 'org-roam-find-index)
(global-set-key (kbd "C-x M-r a")'orb-note-actions )


(add-hook 'after-init-hook 'org-roam-mode)

(require 'org-roam-protocol)

(setq org-roam-capture-templates
      '(("d" "default" plain (function org-roam--capture-get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+title: ${title}\n#+roam_tags: ${tags}\n"
         :unnarrowed t)
        ("w" "website" plain (function org-roam--capture-get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+title: ${title}\n#+roam_key: ${ref}\n"
         :unnarrowed t)
        ("r" "Reference" plain (function org-roam--capture-get-point)
         ""
         :file-name "${citekey}"
         :head "#+title: ${title}\n#+roam_key: ${ref}\n"
         :unnarrowed t
         )))

(use-package org-roam-server
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

(use-package org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :bind (:map org-mode-map
              (("C-c n a" . orb-note-actions))))

;; Aesthetics
(use-package prettify-utils)
(prettify-utils-add-hook org-mode
                         ("[ ]" "☐")
                         ("[X]" "☑")
                         ("[-]" "❍"))
