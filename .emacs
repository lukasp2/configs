;; device dependent
(setq default-directory "~")

;; loads the theme
(load-theme 'wombat)
;; (load-theme 'solarized-dark-high-contrast)
;; (load-theme 'monokai)
;; (load-theme 'sanityinc-tomorrow-night)

;; set window name to emacs
(setq frame-title-format '("emacs"))

;; removes scrollbar and toolbar
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; show column numbers
(column-number-mode)

;; show matching parenthesis
(show-paren-mode)

;; use CUA keys
(cua-mode t)

;; dont display startup screen
'(inhibit-startup-screen t)

;; change window with Shift + arrow keys
(windmove-default-keybindings)

;; A C-x C-f interface 
(ido-mode)

;; ido-mode for M-x <package-install smex>
;; (global-set-key (kbd "M-x") 'smex)

;; theme for powerline <package-install powerline-center-theme>
;; (powerline-center-theme)

;; undo/redo window configuration with C-c left/right
(winner-mode t)

;; linum mode
(global-linum-mode t)

;; disable the most annoying default config of emacs: the beep.
(setq visible-bell 1)

;; break line at end of window
(global-visual-line-mode t)

(setq c-default-style "linux"
      c-basic-offset 4)
      
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
;; NOTE: You'll need to run M-x package-refresh-contents or M-x package-list-packages to ensure fetching of the package list before installing packages.

;; added by Custom
(custom-set-variables
 '(inhibit-startup-screen t)
)

(custom-set-faces)

;; move lines with M-<up> and M-<down>
(fset 'move-line-up
   [?\C-a ?\C-  ?\C-e ?\C-w up ?\C-  ?\C-e ?\C-w down ?\C-y up ?\C-y ?\M-y ?\C-a])
(global-set-key (kbd "M-<up>") 'move-line-up)

(fset 'move-line-down
   [?\C-a ?\C-  ?\C-e ?\C-w down ?\C-  ?\C-e ?\C-w up ?\C-y down ?\C-y ?\M-y ?\C-a])      
(global-set-key (kbd "M-<down>") 'move-line-down)

;; multiple cursors (Ctrl-AltGr 7/0)
(global-set-key (kbd "C-{") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-}") 'mc/mark-next-like-this)

;; INSTALL PACKAGES
;; powerline
;; smex ;; ido mode for M-x
;; magit
;; minimap
;; neotree  ;; file list
;; multiple-cursors
;; alpha ;; change opacity of window MARMALADE

;; AFTER PACKAGES HAVE BEEN INSTALLED, UNCOMMENT THESE
;; set transparency (Shift-Ctrl-Alt 8/9)
;; (require 'alpha)
;; (global-set-key (kbd "C-M-)") 'transparency-increase)
;; (global-set-key (kbd "C-M-(") 'transparency-decrease)

;; NOTES
;; reload .emacs C-x C-e
;; list buffers C-x C-b or C-x b
