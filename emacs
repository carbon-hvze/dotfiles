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

(setq package-list '(cider smartparens haskell-mode company ac-cider
			   aggressive-indent eshell-prompt-extras
			   minimal-theme))

;;(load-theme 'tao-yang t)
;;(load-theme 'soft-morning t)
(load-theme 'minimal-light t)

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(global-company-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(custom-safe-themes
   (quote
    ("23ccf46b0d05ae80ee0661b91a083427a6c61e7a260227d37e36833d862ccffc" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "4156d0da4d9b715c6f7244be34f2622716fb563d185b6facedca2c0985751334" "9d91458c4ad7c74cf946bd97ad085c0f6a40c370ac0a1cbeb2e3879f15b40553" default)))
 '(fci-rule-color "#F0F0F0" t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (minimal-themee eshell-prompt-extras minimal-theme soft-morning-theme org aggressive-indent tao-theme solarized-theme relative-line-numbers smartparens haskell-mode zenburn-theme leuven-theme company ac-cider)))
 '(tool-bar-mode nil)
 '(vc-annotate-background "#D9D9D9")
 '(vc-annotate-color-map
   (quote
    ((20 . "#616161")
     (40 . "#3C3C3C")
     (60 . "#3C3C3C")
     (80 . "#252525")
     (100 . "#252525")
     (120 . "#161616")
     (140 . "#161616")
     (160 . "#0E0E0E")
     (180 . "#0E0E0E")
     (200 . "#0E0E0E")
     (220 . "#080808")
     (240 . "#080808")
     (260 . "#080808")
     (280 . "#080808")
     (300 . "#080808")
     (320 . "#080808")
     (340 . "#080808")
     (360 . "#080808"))))
 '(vc-annotate-very-old-color "#161616"))

;; smartparens settings
(add-hook 'clojure-mode-hook #'smartparens-strict-mode)

(define-key smartparens-mode-map (kbd "C-u") 'sp-unwrap-sexp)
(define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)
(define-key smartparens-mode-map (kbd "M-k") 'sp-kill-sexp)
(define-key smartparens-mode-map (kbd "C-M-n") 'sp-forward-slurp-sexp)
(define-key smartparens-mode-map (kbd "C-]") 'sp-select-next-thing-exchange)

(define-key smartparens-mode-map (kbd "C-M-e") 'sp-forward-sexp)
(define-key smartparens-mode-map (kbd "C-M-a") 'sp-backward-sexp)

(fset 'my-wrap-with-paren "\C-](") ;; C-] is my binding for `sp-select-next-thing-exchange'
(define-key smartparens-mode-map (kbd "C-9") 'my-wrap-with-paren)

;;(define-key cider-mode-map (kbd "C-c C-d") 'cider-doc)

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

(set-cursor-color "#ccc")

;;aggressive indentation
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'css-mode-hook #'aggressive-indent-mode)
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

(global-set-key (kbd "C-x C-b") 'ibuffer)
(defadvice ibuffer
    (around ibuffer-point-to-most-recent) ()
    "Open ibuffer with cursor pointed to most recent buffer name."
    (let ((recent-buffer-name (buffer-name)))
      ad-do-it
      (ibuffer-jump-to-buffer recent-buffer-name)))
(ad-activate 'ibuffer)

(scroll-bar-mode -1)

;; eshell prompts

(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda))
