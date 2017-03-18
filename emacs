(require 'package) ;; You might already have this line
;; (require 'smartparens-config)

(set-default 'truncate-lines t)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(unless package-archive-contents
  (package-refresh-contents))

(setq package-list '(cider smartparens rainbow-delimiters haskell-mode
		     leuven-theme company ac-cider))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;(load-theme 'zenburn t)
(load-theme 'leuven t)
(global-company-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (relative-line-numbers smartparens rainbow-delimiters haskell-mode zenburn-theme leuven-theme company ac-cider)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "orange red"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "gold3"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "purple2"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "turquoise"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "firebrick2"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "dark blue"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "chocolate")))))

(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)

;; smartparens settings
(add-hook 'clojure-mode-hook #'smartparens-strict-mode)

(define-key smartparens-mode-map (kbd "C-u") 'sp-unwrap-sexp)
(define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)
(define-key smartparens-mode-map (kbd "M-k") 'sp-kill-sexp)
(define-key smartparens-mode-map (kbd "C-M-n") 'sp-forward-slurp-sexp)
(define-key smartparens-mode-map (kbd "C-]") 'sp-select-next-thing-exchange)

(fset 'my-wrap-with-paren "\C-](") ;; C-] is my binding for `sp-select-next-thing-exchange'
(define-key smartparens-mode-map (kbd "C-9") 'my-wrap-with-paren)

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

;; haskell stuff
(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

; ensure that last file is opened on startup
(desktop-save-mode 1)

;; linum settings
(eval-after-load "linum"
  '(set-face-attribute 'linum nil :height 110))
(global-linum-mode 1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
