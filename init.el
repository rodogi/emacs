;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(setq package-archives
	     '(("melpa" . "https://melpa.org/packages/")
	       ("gnu" . "https://elpa.gnu.org/packages/")
	       ("org" . "http://orgmode.org/elpa/")))

;;; Install packages with use-package
(eval-when-compile
  (add-to-list 'load-path "/Users/rdora/.emacs.d/elpa")
  (require 'use-package))

(use-package solarized-theme
  :ensure t)

(use-package haskell-mode
  :ensure t)

(use-package auto-fill-mode
  :hook text-mode
  :hook python-mode)

(use-package evil-vimish-fold
  :ensure t
  :config
  (evil-vimish-fold-mode 1)
  (global-set-key (kbd "C-'") 'vimish-fold-avy))


(use-package avy
  :ensure t
  :config
  (global-set-key (kbd "C-:") 'avy-goto-char)
  (global-set-key (kbd "C-;") 'avy-goto-char-2))

(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  (global-set-key (kbd "C-x C-f") 'helm-find-files))

(use-package neotree
  :ensure t
  :config
  (global-set-key (kbd "M-`") 'neotree-toggle)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter))
(use-package all-the-icons
  :ensure t)

(require 'dired-details)
(setq-default dired-details-hidden-string "--- ")
(dired-details-install)
(setq dired-dwim-target t)
  

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package jedi
  :ensure t
  :config
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t))

(use-package header2
  :ensure t)

(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package linum-relative
  :ensure t)

(use-package fill-column-indicator
  :ensure t)

;;; Pretty html with org-mode
(use-package ox-twbs
  :ensure t)

(use-package org-ref
  :ensure t)

;;; beamer
(require 'ox-beamer)

;;; add source directory for org files
(use-package show-paren-mode
  :hook emacs-lisp-mode)

;; pretty headers
(use-package org-bullets
  :ensure t
  :config
  (setq org-ellipsis "⇣")
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package python
  :mode ("\\.py\\'" . python-mode) 
  :interpreter ("python" . python-mode))

;; HTML export syntax highlight
(use-package htmlize
  :ensure t)

;; disable menu bar
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Use jupyter as interactive python
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)

;; Fold code blocks in python
(defun rodogi-fold-python ()
  "Fold all python blocks"
  (interactive)
  (forward-word) ; start in the second word
  (setq p (point))
  (while (forward-word)
    (backward-word)
    (setq col (current-column))
    (forward-word)
    (if (= col 0)
	(progn
	  (setq p1 (car (bounds-of-thing-at-point 'word)))
	  (vimish-fold p p1)
	  (setq p p1)
	  (goto-char p)
	  (forward-word)))
    )
  (vimish-fold p (buffer-size))
  (goto-char 1))

;; change color of motion cursor
(setq evil-motion-state-cursor '("turquoise" box))

(use-package popwin
  :ensure t
  :config
  (popwin-mode 1)
  ;;; set all buffers to appear to the right
  (push '(help-mode :position right :width 0.45) popwin:special-display-config))

;;; count number of occurrences of word
(use-package anzu
  :ensure t
  :config
  (global-anzu-mode +1)
  (global-set-key [remap query-replace] 'anzu-query-replace)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp))

(use-package elpy
  :config
  (setq elpy-rpc-backend "jedi")
  (setq elpy-rpc-python-command "/usr/local/Cellar/python/3.6.3/bin/python3")
  (defun rdg-toggle-folds ()
  "Toggle between folds when in elpy mode"
  (interactive)
  ;; use a property “state”. Value is t or nil
  (if (get 'rdg-toggle-folds 'state)
      (progn
        (hs-hide-all)
        (put 'rdg-toggle-folds 'state nil))
    (progn
      (hs-show-all)
      (put 'rdg-toggle-folds 'state t))))
  (global-set-key (kbd "<S-tab>") (rdg-toggle-folds))
  :hook (hs-minor-mode . elpy))

(use-package evil
  :ensure t
  :config
  (evil-mode 1)

  ;;; Search for visually selected text in evil mode
  (use-package evil-visualstar
    :ensure t
    :config
    (global-evil-visualstar-mode)
    (setq evil-visualstar/persistent t))


  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode))

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode)))

;;; Set font name and size
(set-frame-font "IBM Plex Mono-14" nil t)
(load-theme 'solarized-dark t)

;; Activate flycheck (spelling) for org-mode
;;; turn on spelling for latex and org files
(dolist (hook '(org-mode-hook latex-mode-hook tex-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
;;; Setting english to be the spelling language
(setq ispell-program-name "/usr/local/bin/aspell")
(setq ispell-dictionary "english")

;; set proper line break
(dolist (hook '(text-mode-hook latex-mode-hook tex-mode-hook))
  (add-hook hook (lambda () (set-fill-column 100))))
(dolist (hook '(python-mode-hook c-mode-hook list-mode-hook))
  (add-hook hook (lambda () (set-fill-column 80))))


;; frame full path title
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;;; Set frame to full screen
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-rpc-python-command "/usr/local/Cellar/python/3.6.3/bin/python3")
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(linum-relative-current-symbol "")
 '(org-agenda-files
   (quote
    ("~/Desktop/bases_unam/readme.org" "~/inmegen/breast_cancer/notes/paper.org" "/Users/rdora/Dropbox/org/inmegen.org" "/Users/rdora/Dropbox/org/life.org" "/Users/rdora/Dropbox/org/mobile.org" "/Users/rdora/Dropbox/org/network_science.org")))
 '(package-selected-packages
   (quote
    (haskell-mode markdown-mode mardown-mode ess ein dire-details all-the-icons neotree htmlize avy evil-vimish-fold vimish-fold org-ref ox-beamer anzu evil-visualstar exec-path-from-shell jedi popwin org org-edna org-bullets org-bullet ox-twbs fill-column-indicator linum-relative header2 use-package solarized-theme magit evil-surround evil-leader elpy))))

;; org latex sections
(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


;;; Make sure pdflatex runs from emacs
(setenv "PATH"
	(concat "/Library/TeX/texbin:" (getenv "PATH")))

;;; Include minted package in all LaTeX reports
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listing 'minted)

;; org-babel source blocks
(org-babel-do-load-languages
 'org-babel-load-languages '((C . t)
			     (python . t)
			     (emacs-lisp . t)))



;;; Allow exports to be buffer-local with keyword BIND
(setq org-export-allow-bind-keywords t)

;;; Closet TODO items with timestamp
(setq org-log-done 'time)

;;; Some settings for agenda
(global-set-key "\C-ca" 'org-agenda)
(setq org-agenda-files '("~/Dropbox/org/"))

;;; Set line numbers and relative mode
(global-linum-mode t)
(linum-relative-global-mode)
(setq linum-reative-current-symbol "") ; show actual number instead of 0

;;; Workflow of TODO keywords
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w@/!)" "|" "DONE(d!)" "CANCELED(c@/!)")))
;;; archive in a datetree
(setq org-archive-location "~/org/archive.org::datetree/")

;;; show column number
(setq column-number-mode t)

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    "bibtex %b"
    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;;; Set header for latex mode
(add-hook 'latex-mode-hook 'auto-make-header)

;;; Set window width at max 80
(set-window-margins nil 0 (max (- (window-width) 80) 0))

;;; use auto-fill
(auto-fill-mode 1)

;;; automatic code

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
