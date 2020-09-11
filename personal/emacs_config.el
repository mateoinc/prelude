;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; basic emacs configuration to be used in conjunction with prelude       ;;
;; pragmaticemacs.com/installing-and-setting-up-emacs/                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;Add MELPA repository for packages
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For compatibility
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; prelude options                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; install additional packages - add anyto this list that you want to
;; be installed automatically
(prelude-require-packages '(use-package
                            pdf-tools
                            engine-mode
                            multiple-cursors ess
                            cyberpunk-theme
                            conda
                            org-drill
                            org-ref
                            org-roam
                            org-roam-server
                            org-roam-bibtex
                            treemacs
                            treemacs-projectile
                            treemacs-icons-dired
                            treemacs-magit
                            julia-mode
                            ob-ipython
                            all-the-icons))

;;enable arrow keys
(setq prelude-guru nil)

;;smooth scrolling
(setq prelude-use-smooth-scrolling t)

;;uncomment this to use default theme
(disable-theme 'zenburn)
(use-package cyberpunk-theme
  :ensure t
  :config
  (load-theme 'cyberpunk t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; display options                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;enable tool and menu bars - good for beginners
(tool-bar-mode 1)
(menu-bar-mode 1)

;; Python
;; (use-package conda
;;             :ensure t
;;             :init
;;             (setq conda-anaconda-home (expand-file-name "~/anaconda3"))
;;             (setq conda-env-home-directory (expand-file-name "~/anaconda3")))

;; Latex mode hook
(add-hook 'latex-mode-hook 'turn-on-cdlatex)


;; pdftools
(pdf-tools-install)
;; to use pdfview with auctex
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
      TeX-source-correlate-start-server t) ;; not sure if last line is neccessary

;; to have the buffer refresh after compilation
(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)


;;; engine-mode
(defengine duckduckgo
  "https://duckduckgo.com/?q=%s"
  :keybinding "d")
(defengine sci-hub
  "https://sci-hub.tw/%s"
  :keybinding "s")
;; (global-engine-mode t)

;; Packages
(require 'julia-mode)
(require 'all-the-icons)


; LocalWords:  Autofill Nyan
