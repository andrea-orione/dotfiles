  (setq gc-cons-threshold (* 50 1000 1000)) ;; Default is 800 KB. Measured in bytes.
  (setq custom-file "~/.config/emacs/custom.el")
  (load custom-file)

  (require 'package) ;; Initializing packge source

  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
                           ("melpa-stable" . "https://stable.melpa.org/packages/")
                           ("org" . "https://orgmode.org/elpa/")
                           ("elpa" . "https://elpa.gnu.org/packages/")))

  (package-initialize)
  (unless package-archive-contents
    (package-refresh-contents))
  (unless (package-installed-p 'use-package)
    (package-install 'use-package))

  (require 'use-package)
  (setq use-package-always-ensure t)      ;; Install the package if it is not already
  ;; (setq use-package-verbose t)
  (use-package auto-package-update
    :custom
    (auto-package-update-interval 7)
    (auto-package-update-prompt-before-update t)
    (auto-package-update-hide-results t)
    :config
    (auto-package-update-maybe)
    (auto-package-update-at-time "09:00"))
  (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
  (delete-selection-mode t)
  (global-set-key (kbd "C-M-u") 'universal-argument)
  ;; Creates a list of modes when to use emacs state mode
  (defun orion/evil-hook ()
    (dolist (mode '(custom-mode
                    eshell-mode
                    git-rebase-mode
                    erc-mode
                    circe-server-mode
                    circe-chat-mode
                    circe-query-mode
                    sauron-mode
                    term-mode))
    (add-to-list 'evil-emacs-state-modes mode)))

  (use-package evil
    :init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    (setq evil-want-C-u-scroll t)
    (setq evil-want-C-i-jump nil)
    (setq evil-respect-visual-line-mode t)
    (setq evil-undo-system 'undo-tree)
    :config
    (add-hook 'evil-mode-hook 'orion/evil-hook)
    (evil-mode 1)
    (define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
    (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

    ;; Use visual line motion even outside of visual-line-mode buffers
    (evil-global-set-key 'motion "j" 'evil-next-visual-line)
    (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

    (evil-set-initial-state 'messages-buffer-mode 'normal)
    (evil-set-initial-state 'dashboard-mode 'normal))

  (use-package evil-collection
    :after evil
    :custom
    (evil-collection-outline-bind-tap-p nil)
    :config
    (delete 'lispy evil-collection-mode-list)
    (delete 'org-present evil-collection-mode-list)
    (evil-collection-init))

  ;; Emacs version of the vim tutor
  (use-package evil-tutor
    :commands evil-tutor-start)
  (use-package undo-tree
    :after evil
    :defer 0
    :init
    :config
    (global-undo-tree-mode 1)
    (setq undo-tree-auto-save-history nil))
  (use-package which-key
    :defer 0
    :diminish which-key-mode
    :config
    (which-key-mode)
    (setq which-key-idle-delay 0.3))  ;; Delay before the panel is shown since the key was pressed
  (use-package general
    :after evil
    :config
    (general-evil-setup t)
    (general-imap "j"
      (general-key-dispatch 'self-insert-command
        :timeout 0.25
        "k" 'evil-normal-state))
    (general-imap "k"
      (general-key-dispatch 'self-insert-command
        :timeout 0.25
        "j" 'evil-normal-state))
    (general-create-definer orion/leader-keys
      :keymaps '(normal insert visual emacs)
      :prefix "SPC"
      :global-prefix "C-SPC"))
  (use-package hydra
    :defer t)
  (scroll-bar-mode -1)       ; Disable visible scrollbar
  (tool-bar-mode -1)         ; Disable the toolbar
  (tooltip-mode -1)          ; Disable tooltips
  (set-fringe-mode 7)        ; Instert space on the sides

  (menu-bar-mode -1)         ; Disable the menu bar
  (scroll-bar-mode -1)          ; Disable the scroll bar

  (setq visible-bell nil)      ; Set up the visible bell
  (column-number-mode)
  (global-display-line-numbers-mode t)
  (setq display-line-numbers-type 'relative)

  ;; Disable line number for some modes
  (dolist (mode '(org-mode-hook
        term-mode-hook
        shell-mode-hook
        treemacs-mode-hook
        eshell-mode-hook))
    (add-hook mode (lambda () (display-line-numbers-mode 0))))
  (set-frame-parameter (selected-frame) 'alpha '(95 . 95))
  (add-to-list 'default-frame-alist '(alpha . (95 . 95)))
  (setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((meta) . 5))) ;; one line at a time
  (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
  (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
  (use-package dashboard
    :after all-the-icons
    :init
    (setq dashboard-set-heading-icons t)
    (setq dashboard-set-file-icons t)
    (setq dashboard-banner-logo-title "Orionmacs")
    (setq dashboard-startup-banner "~/.config/emacs/emacs-banner.txt");; Use 'logo for standard logo
    (setq dashboard-center-content nil)
    (setq dashboard-items '((recents . 5)
                            (projects . 3)))
    (setq dashboard-item-shortcuts '((recents   . "r")
                                     (projects  . "p")))
    (setq dashboard-icon-type 'all-the-icons)
    :config
    (dashboard-setup-startup-hook)
    (dashboard-modify-heading-icons '((recents . "file-text")
                                      (bookmarks . "book"))))

  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (use-package doom-themes)
  (load-theme 'orion-blue t)
  ;;(load-theme 'doom-dracula t)
  ;;(load-theme 'doom-dark+ t)
  ;;(load-theme 'doom-one t)
  ;;(load-theme 'doom-monokai-classic t)
  ;;(load-theme 'doom-solarized-dark t)
  ;;(load-theme 'doom-tomorrow-night t)

  (orion/leader-keys
    "s"  '(:ignore t :which-key "Search")
    "sc" '(counsel-load-theme :which-key "Colorscheme"))
  (defvar orion/default-font-size 128)
  (defvar orion/default-variable-font-size 128)

  (set-face-attribute 'default nil :font "Ubuntu Mono" :height orion/default-font-size)

  (set-face-attribute 'fixed-pitch nil :font "Ubuntu Mono" :height 128)

  (set-face-attribute 'variable-pitch nil :font "Ubuntu" :height orion/default-variable-font-size :weight 'light)
  (use-package emojify
    :hook (erc-mode . emojify-mode)
    :commands emojify-mode)
  (use-package all-the-icons)
  (setq display-time-format "%l:%M %p %b %y"
        display-time-default-load-average nil)
  (use-package diminish)
  (use-package minions
    :hook (doom-modeline-mode . minions-mode))
  (use-package doom-modeline
    :init
    (doom-modeline-mode 1)
    :config
    (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)
    (setq doom-modeline-minor-modes t)
    (setq doom-modeline-indent-info t))
  (use-package perspective
    :demand t
    :bind (("C-M-k" . persp-switch)
           ("C-M-n" . persp-next)
           ("C-x k" . persp-kill-buffer*)
           ("C-x b" . persp-counsel-switch-buffer))
    :custom
    (persp-initial-frame-name "Main")
    :config
    (customize-set-variable 'persp-mode-prefix-key (kbd "C-c M-p"))
    ;; Running `persp-mode' multiple times resets the perspective list...
    (unless (equal persp-mode t)
      (persp-mode)))
  (use-package alert
    :commands alert)
  (setq backup-directory-alist '(("." . "~/.config/emacs/backup"))
    backup-by-copying t    ; Don't delink hardlinks
    version-control t      ; Use version numbers on backups
    delete-old-versions t  ; Automatically delete excess backups
    kept-new-versions 20   ; how many of the newest versions to keep
    kept-old-versions 5    ; and how many of the old
    )
  (use-package super-save
    :defer 1
    :diminish super-save-mode
    :config
    (super-save-mode +1)
    (setq super-save-auto-save-when-idle t)
    (setq auto-save-default nil))
  (setq global-auto-revert-non-file-buffers t) ;; Revert Dired and other non file buffers

  (global-auto-revert-mode 1) ;; Revert buffers when the underlying file has changed
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)
  (setq-default evil-shift-width tab-width)
  (use-package evil-nerd-commenter
    :bind ("M-/" . evilnc-comment-or-uncomment-lines))
  (use-package ws-butler
    :hook ((text-mode . ws-butler-mode)
           (prog-mode . ws-butler-mode)))
  (use-package hideshow
    :hook (prog-mode . hs-minor-mode))
  (use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))
  (use-package rainbow-mode)
  (use-package highlight-indent-guides
    :hook (prog-mode . highlight-indent-guides-mode)
    :config
    (setq highlight-indent-guides-method 'character))
  (use-package ivy
    :diminish
    :bind (("C-s" . swiper)
           :map ivy-minibuffer-map
           ("TAB" . ivy-alt-done)
           ("C-l" . ivy-alt-done)
           ("C-j" . ivy-next-line)
           ("C-k" . ivy-previous-line)
           :map ivy-switch-buffer-map
           ("C-k" . ivy-previous-line)
           ("C-l" . ivy-done)
           ("C-d" . ivy-switch-buffer-kill)
           :map ivy-reverse-i-search-map
           ("C-k" . ivy-previous-line)
           ("C-d" . ivy-reverse-i-search-kill))
   :config
    (ivy-mode 1))

  (use-package ivy-rich
    :after ivy
    :init
    (ivy-rich-mode 1))

  (use-package counsel
    :bind (("M-x" . counsel-M-x)
           ("C-x C-f" . counsel-find-file)
           :map minibuffer-local-map
           ("C-r" . 'counsel-minibuffer-history)))
  (use-package helpful
    :commands (helpful-callable helpful-variable helpful-command helpful-key)
    :custom
    (counsel-describe-function-function #'helpful-callable)
    (counsel-describe-variable-function #'helpful-variable)
    :bind
    ([remap describe-function] . counsel-describe-function)
    ([remap describe-command] . helpful-command)
    ([remap describe-variable] . counsel-describe-variable)
    ([remap describe-key] . helpful-key))
(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer)
  (setq delete-by-moving-to-trash t))

(use-package dired-single
  :after dired)

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :after dired
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

(defun orion/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil)
  (diminish org-indent-mode))


(use-package org
  :hook (org-mode . orion/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
        org-src-fontify-natively t
        org-fontify-quote-and-verse-blocks t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 2
        org-hide-block-startup nil
        org-src-preserve-indentation nil
        org-cycle-separator-lines 2
        org-capture-bookmark nil)

  (setq org-agenda-start-with-log-mode t)
  (orion/org-font-setup)
  (setq org-agenda-files
	'("~/.config/emacs/tasks/task.org")))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))


(defun orion/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . orion/org-mode-visual-fill))


(defun orion/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)))

(setq org-confirma-babel-evaluate nil)

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("cpp" . "src cpp"))
(add-to-list 'org-structure-template-alist '("li" . "src lisp"))
(add-to-list 'org-structure-template-alist '("sc" . "src scheme"))
(add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
(add-to-list 'org-structure-template-alist '("go" . "src go"))
(add-to-list 'org-structure-template-alist '("yaml" . "src yaml"))
(add-to-list 'org-structure-template-alist '("json" . "src json"))

(defun orion/org-babel-tangle-config()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.config/emacs/Emacs.org"))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'orion/org-babel-tangle-config)))

(orion/leader-keys
  "o"   '(:ignore t :which-key "org mode")

  "oi"  '(:ignore t :which-key "insert")
  "oil" '(org-insert-link :which-key "insert link")

  "on"  '(org-toggle-narrow-to-subtree :which-key "toggle narrow")

  "os"  '(dw/counsel-rg-org-files :which-key "search notes")

  "oa"  '(org-agenda :which-key "status")
  "ot"  '(org-todo-list :which-key "todos")
  "oc"  '(org-capture t :which-key "capture")
  "ox"  '(org-export-dispatch t :which-key "export"))

(use-package toc-org
  :commands toc-org-enable
  :hook (org-mode . toc-org-enable))

(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(orion/leader-keys
  "g"   '(:ignore t :which-key "git")
  "gs"  'magit-status
  "gd"  'magit-diff-unstaged
  "gc"  'magit-branch-or-checkout
  "gl"   '(:ignore t :which-key "log")
  "glc" 'magit-log-current
  "glf" 'magit-log-buffer-file
  "gb"  'magit-branch
  "gP"  'magit-push-current
  "gp"  'magit-pull-branch
  "gf"  'magit-fetch
  "gF"  'magit-fetch-all
  "gr"  'magit-rebase)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-complition-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

(orion/leader-keys
  "p"   '(:ignore t :which-key "projectile")
  "pf"  'projectile-find-file
  "ps"  'projectile-switch-project
  "pF"  'consult-ripgrep
  "pp"  'projectile-find-file
  "pc"  'projectile-compile-project
  "pd"  'projectile-dired)

(defun orion/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . orion/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l") ;;Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(orion/leader-keys
  "l"  '(:ignore t :which-key "lsp")
  "ld" 'xref-find-definitions
  "lr" 'xref-find-references
  "ln" 'lsp-ui-find-next-reference
  "lp" 'lsp-ui-find-prev-reference
  "ls" 'counsel-imenu
  "le" 'lsp-ui-flycheck-list
  "lS" 'lsp-ui-sideline-mode
  "lX" 'lsp-execute-code-action)

;;Introduce more ui improves such as sideline
(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

  (use-package cc-mode
      :ensure nil
      :hook (c++-mode . lsp-deferred)
      :config
      (setq lsp-clangd-binary-path "/usr/lib/llvm-15/bin/clangd-15"))

  (use-package python-mode
    :ensure t
    :hook (python-mode . lsp-deferred)
    :custom
    (python-shell-interpreter "python3"))

  (use-package auctex
    :hook (latex-mode . auctex))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package lsp-treemacs
  :after lsp)

  (use-package sublimity)

(use-package lsp-ivy
  :after ivy)

  (use-package ein)
  (use-package ein-notebook)
  (use-package ein-subpackages)

(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "bash") ;; Change this to zsh, etc
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args
  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  ;;(setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

  (when (eq system-type 'windows-nt)
    (setq explicit-shell-file-name "powershell.exe")
    (setq explicit-powershell.exe-args '()))

(defun orion/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt
  :after eshell)

(use-package eshell
  :hook (eshell-first-time-mode . orion/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'multiline2))
  ;; Make gc pauses faster by decreasing the threshold.
  (setq gc-cons-threshold (* 2 1000 1000))
