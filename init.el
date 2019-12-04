;http://www.nochedemuseos.cdmx.gob.mx/#image-19; Configure package.el to include MELPA.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Ensure that use-package is installed.
;;
;; If use-package isn't already installed, it's extremely likely that this is a
;; fresh installation! So we'll want to update the package repository and
;; install use-package before loading the literate configuration.
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(org-babel-load-file "~/.emacs.d/config.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
<<<<<<< HEAD
 '(package-selected-packages
	 (quote
		(ox-reveal evil-escape zenburn-theme zenburn auto-compile use-package solarized-theme py-autopep8 popwin ox-twbs ox-hugo org-ref org-bullets neotree moody minions magit-popup magit linum-relative jedi header2 haskell-mode ghub fill-column-indicator exec-path-from-shell evil-visualstar evil-vimish-fold evil-surround evil-leader ess elpy ein diff-hl avy anzu all-the-icons))))
=======
 '(org-agenda-files
   (quote
    ("~/emacs_meetup/talk.org" "/Users/rdora/Dropbox/org/cool_blogs.org" "/Users/rdora/Dropbox/org/inmegen.org" "/Users/rdora/Dropbox/org/life.org" "/Users/rdora/Dropbox/org/mobile.org" "/Users/rdora/Dropbox/org/network_science.org")))
 '(package-selected-packages
   (quote
    (emacs-reveal ox-reveal projectile flycheck evil-escape zenburn-theme zenburn auto-compile use-package solarized-theme py-autopep8 popwin ox-twbs ox-hugo org-ref org-bullets neotree moody minions magit-popup magit linum-relative jedi header2 haskell-mode ghub fill-column-indicator exec-path-from-shell evil-visualstar evil-vimish-fold evil-surround evil-leader ess elpy ein diff-hl avy anzu all-the-icons))))
>>>>>>> 5eadd39481708d576d02a70e0906633dddd987bc
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "IBM Plex Mono" :foundry "nil" :slant normal :weight normal :height 140 :width normal)))))
