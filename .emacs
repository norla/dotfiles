;; Melpa
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Path
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Helm
(require 'helm-config)
(helm-mode 1)
(setq helm-locate-command "~/bin/locate-with-mdfind %.0s %s")

;; Highlight symbol
(require 'highlight-symbol)
(setq highlight-symbol-idle-delay 0.5)
(add-hook 'js-mode-hook 'highlight-symbol-mode)
(add-hook 'js2-mode-hook 'highlight-symbol-mode)
(add-hook 'js3-mode-hook 'highlight-symbol-mode)

;; Autocomplete
(require 'auto-complete)
(global-auto-complete-mode t)
  
;; Projectile
(projectile-global-mode)
(setq projectile-enable-caching t)
(require 'helm-projectile)
(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile-find-file)
(add-hook 'projectile-switch-project-hook 'neotree-projectile-action)

;; Perspective moe
(persp-mode)
(require 'persp-projectile)

;; Js/node
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;;(add-hook 'js2-mode-hook 'ac-js2-mode)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))

(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
     (tern-ac-setup)))

(require 'flycheck)
(add-hook 'js2-mode-hook
          (lambda () (flycheck-mode t)))

(with-eval-after-load 'flycheck
  ;; Define a checker for jscs...
  (flycheck-define-checker javascript-jscs
    "A JavaScript style checker using jscs.
      See URL `https://www.npmjs.com/package/jscs'."
    :command ("jscs" "--reporter=checkstyle"
              (config-file "--config" flycheck-jscsrc)
              source)
    :error-parser flycheck-parse-checkstyle
    :modes (js-mode js2-mode js3-mode))
  ;; Make flycheck-jscsrc configuration with default.
  (flycheck-def-config-file-var flycheck-jscsrc javascript-jscs ".jscs.json"
    :safe #'stringp)  ;; Make javascript-jscs automatically selectable to flycheck
  (flycheck-add-next-checker 'javascript-jshint '(t . javascript-jscs)))

(add-to-list 'flycheck-checkers 'javascript-jscs)
;; Js2 modes error highlighting interferes with jshint/jscs, so we disable it
(setq
 js2-mode-show-parse-errors nil
 js2-mode-show-strict-warnings nil)

;; Misc
(global-set-key [C-tab] 'other-window)
(setq column-number-mode t)
(setq neo-window-width 38)

;; Keybindings
(global-set-key [s-return] 'helm-projectile)
(global-set-key [f1] 'projectile-persp-switch-project)
(global-set-key [f2] 'window-ordnung)
(global-set-key [f3] 'helm-ag-project-root)
(global-set-key [f8] 'magit-status)
(global-set-key [f9] 'neotree-find)
(global-set-key [f10] 'neotree-projectile-action)
(global-set-key [f12] 'neotree-toggle)

(defun window-ordnung ()
  "Make nice three-column layout"
  (interactive)
  (delete-other-windows)
  (split-window-right)
  (split-window-right)
  (balance-windows-area)
)

;; Editorconfig\
(load "editorconfig")

;; Custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#272822" "#F92672" "#A6E22E" "#E6DB74" "#66D9EF" "#FD5FF0" "#A1EFE4" "#F8F8F2"])
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (smyx)))
 '(custom-safe-themes
   (quote
    ("18e89f93cbaaac214202142d910582354d36639f21f32b04718ca6425dbc82a2" "0f002f8b472e1a185dfee9e5e5299d3a8927b26b20340f10a8b48beb42b55102" "ed5af4af1d148dc4e0e79e4215c85e7ed21488d63303ddde27880ea91112b07e" "bb15b0004ec895e8b4d5af640cdb3e283cf54271f47ec128dc0ba6af1a333925" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "4e262566c3d57706c70e403d440146a5440de056dfaeb3062f004da1711d83fc" "7bde52fdac7ac54d00f3d4c559f2f7aa899311655e7eb20ec5491f3b5c533fe8" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "1a85b8ade3d7cf76897b338ff3b20409cb5a5fbed4e45c6f38c98eee7b025ad4" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "a233249cc6f90098e13e555f5f5bf6f8461563a8043c7502fb0474be02affeea" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" default)))
 '(ensime-sem-high-faces
   (quote
    ((var :foreground "#9876aa" :underline
          (:style wave :color "yellow"))
     (val :foreground "#9876aa")
     (varField :slant italic)
     (valField :foreground "#9876aa" :slant italic)
     (functionCall :foreground "#a9b7c6")
     (operator :foreground "#cc7832")
     (param :foreground "#a9b7c6")
     (class :foreground "#4e807d")
     (trait :foreground "#4e807d" :slant italic)
     (object :foreground "#6897bb" :slant italic)
     (package :foreground "#cc7832"))))
 '(fci-rule-color "#49483E")
 '(fringe-mode 0 nil (fringe))
 '(highlight-changes-colors ("#FD5FF0" "#AE81FF"))
 '(highlight-tail-colors
   (("#49483E" . 0)
    ("#67930F" . 20)
    ("#349B8D" . 30)
    ("#21889B" . 50)
    ("#968B26" . 60)
    ("#A45E0A" . 70)
    ("#A41F99" . 85)
    ("#49483E" . 100)))
 '(linum-format " %7i ")
 '(magit-diff-use-overlays nil)
 '(nav-width 98)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#49483E" "#A20C41" "#F92672" "#67930F" "#A6E22E" "#968B26" "#E6DB74" "#21889B" "#66D9EF" "#A41F99" "#FD5FF0" "#349B8D" "#A1EFE4" "#F8F8F2" "#F8F8F0")))

