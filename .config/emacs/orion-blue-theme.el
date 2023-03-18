;;; orion-blue-theme.el --- hopefully it works

;;    ____     ____
;;  /  __  \ /  __  \
;; |  |__|  |  |  |  |  Andrea Orione
;; |   __   |  |  |  |  https://www.github.com/andrea-orione
;; |  |  |  |  |__|  |
;; |__|  |__|\ ____ /

;; Copyright (C) 2023 by Andrea Orione.

;;; Commentary:

;; If it works should be a colorful theme centered on shades
;; of cyan and dark blue

;;; Code:

(deftheme orion-blue "A very colorful theme from the stars")

(defgroup orion-blue-theme nil
  "Options for the `orion-dark' theme."
  :group 'personal-themes
  :prefix "orion-blue-"
  :tag "Orion blue theme")


(let ((class '((class color) (min-colors 89)))
      ;; Color Palette
      (orion-bg-2     "#041020") ;; !base2
      (orion-bg-1     "#001323") ;; !modeline-bg-alt
      (orion-bg       "#011627")
      (orion-bg+1     "#07213F") ;; !base0 "#171F24"
      (orion-bg+2     "#0E2D58")
      (orion-bg+3     "#103362") ;; !base6
      (orion-bg-alt   "#252526") ;; vertical-bar
      (orion-base1    "#1C1C1C")
      (orion-base3    "#313131")
      (orion-base4    "#4b474c")
      (orion-base5    "#37474F")
      (orion-fg       "#A7DBF7") ;; variables
      (orion-fg-alt   "#C7DBF7")
      (orion-white-1  "#f4f4f4") ;; !base 8
      (orion-white    "#FFFFFF")
      (orion-gray     "#999999")
      (orion-red      "#D30102") ;; vc-deleted
      (orion-red+1    "#FC2626")
      (orion-orange   "#FF961F")
      (orion-orange+1 "#FFCA28")
      (orion-green    "#00B70A") ;; vc-added
      (orion-green+1  "#A6E22E") ;; success
      (orion-yellow-1 "#FFFF00")
      (orion-yellow   "#D7BA7D")
      (orion-yellow+1 "#D9DAA2") ;; methods
      (orion-pink     "#FF8CB6")
      (orion-magenta  "#B300B3")
      (orion-violet-1 "#C792EA")
      (orion-violet   "#F07178")
      (orion-purple   "#8B049C")
      (orion-purple-1 "#6C00D9") ;; numbers
      (orion-blue-1   "#040520")
      (orion-cyan-1   "#219FD5") ;; vc-modified
      (orion-cyan     "#00BFF9") ;; operators
      (orion-cyan+1   "#00E1FF")
      (orion-teal     "#35CDAF")
      (orion-black    "#000000"))

  (custom-theme-set-faces
   'orion-blue

   ;; Basics
   '(button  ((t (:underline t :inherit link))))
   `(link    ((,class (:foreground ,orion-cyan :underline t :weight bold))))
   `(link-visited  ((,class (:foreground ,orion-cyan-1 :underline t :weight normal))))
   `(bold    ((,class (:bold t))))
   `(default ((,class (:foreground ,orion-fg :background ,orion-bg))))
   `(cursor  ((,class (:foreground ,orion-cyan :background ,orion-cyan+1))))
   `(widget-field  ((,class (:foreground ,orion-fg :background ,orion-bg+1))))
   `(escape-glyph  ((,class (:foreground ,orion-purple :weight bold))))
   `(fringe ((,class (:foreground ,orion-base4 :background ,orion-bg))))
   `(header-line   ((,class (:foreground ,orion-cyan-1
                                    :background ,orion-blue-1
                                    :box (:line-width -1 :style released-button)
                                    :extend t))))
   `(highlight ((,class (:background ,orion-bg+2))))
   `(success ((,class (:foreground ,orion-green+1 :weight bold))))
   `(warning ((,class (:foreground ,orion-orange+1 :weight bold))))
   `(error   ((,class (:foreground ,orion-red :weight bold))))
   `(tooltip ((,class (:foreground ,orion-cyan :background ,orion-bg))))

   ;; Selections
   `(region ((,class (:background ,orion-bg+1))))
   `(secondary-selection ((,class (:background ,orion-bg+2))))
   `(trailing-whitespace ((,class (:background ,orion-red))))

   ;; Ansi-colors (built-in)
   `(ansi-color-black   ((,class (:foreground ,orion-black :background ,orion-black))))
   `(ansi-color-red     ((,class (:foreground ,orion-red :background ,orion-red))))
   `(ansi-color-green   ((,class (:foreground ,orion-green :background ,orion-green))))
   `(ansi-color-yellow  ((,class (:foreground ,orion-yellow :background ,orion-yellow))))
   `(ansi-color-blue    ((,class (:foreground ,orion-blue-1 :background ,orion-blue-1))))
   `(ansi-color-magenta ((,class (:foreground ,orion-magenta :background ,orion-magenta))))
   `(ansi-color-cyan    ((,class (:foreground ,orion-cyan :background ,orion-cyan))))
   `(ansi-color-white   ((,class (:foreground ,orion-white :background ,orion-white))))

   ;; Compilation (built-in)
   `(compilation-column-number  ((,class (:inherit font-lock-comment-face))))
   `(compilation-line-number    ((,class (:foreground ,orion-cyan))))
   `(compilation-error          ((,class (:foreground ,orion-red))))
   `(compilation-warning        ((,class (:inherit warning))))
   `(compilation-info           ((,class (:inherit tooltip))))
   `(compilation-mode-line-exit ((,class (:inherit compilation-info))))
   `(compilation-mode-line-fail ((,class (:inherit compilation-error))))

   ;; Grep
   `(grep-context-face ((,class (:foreground ,orion-bg :background ,orion-green))))
   `(grep-error-face   ((,class (:foreground ,orion-red :weight bold))))
   `(grep-hit-face     ((,class (:foreground ,orion-bg :background ,orion-red))))
   `(grep-match-face   ((,class (:foreground ,orion-bg :background ,orion-purple))))
   `(match             ((,class (:foreground ,orion-bg :background ,orion-green))))

   ;; Isearch
   `(isearch        ((,class (:foreground ,orion-bg :background ,orion-green))))
   `(isearch-fail   ((,class (:background ,orion-red))))
   `(lazy-highlight ((,class (:foreground ,orion-bg :background ,orion-magenta))))
   `(query-replace  ((,class (:foreground ,orion-red))))

   ;; Bars and mini-buffer
   `(menu ((,class (:foreground ,orion-fg :background ,orion-bg))))
   `(minibuffer-prompt ((,class (:foreground ,orion-cyan))))

   ;; Modeline and Header line
   `(mode-line ((,class (:foreground ,orion-fg :background ,orion-blue-1))))
   `(mode-line-inactive ((,class (:foreground ,orion-base5 :background ,orion-bg-1))))
   `(mode-line-emphasis ((,class (:foreground ,orion-cyan :weight bold))))
   `(mode-line-highlight ((,class (:background ,orion-bg+1 :box (:line-width -1 :color ,orion-bg+3)))))
   `(mode-line-buffer-id ((,class (:weight bold))))
   `(doom-modeline-bar ((,class (:background ,orion-bg+3))))
   `(doom-modeline-buffer-modified ((,class (:inherit mode-line-emphasis :weight bold :foreground ,orion-red+1))))
   `(doom-modeline-debug ((,class (:inherit mode-line-emphasis))))
   `(doom-modeline-evil-normal-state ((,class (:foreground ,orion-cyan))))
   `(doom-modeline-evil-insert-state ((,class (:foreground ,orion-purple))))
   `(doom-modeline-evil-visual-state ((,class (:foreground ,orion-yellow))))
   `(persp-selected-face ((,class (:foreground ,orion-cyan))))
   `(header-line ((,class (:inherit mode-line))))
   `(header-line-highlight ((,class (:inherit mode-line-highlight))))

   ;; Font lock
   `(font-lock-builtin-face  ((,class (:foreground ,orion-orange))))
   `(font-lock-comment-face  ((,class (:foreground ,orion-gray :italic t))))
   `(font-lock-comment-delimiter-face ((,class (:inherit font-lock-comment-face))))
   `(font-lock-doc-face      ((,class (:foreground ,orion-teal))))
   `(font-lock-constant-face ((,class (:foreground ,orion-purple))))
   `(font-lock-function-name-face ((,class (:foreground ,orion-green+1 :italic t))))
   `(font-lock-keyword-face  ((,class (:foreground ,orion-cyan :italic t))))
   `(font-lock-string-face   ((,class (:foreground ,orion-green))))
   `(font-lock-type-face     ((,class (:foreground ,orion-violet-1 :italic t))))
   `(font-lock-variable-name-face ((,class (:foreground ,orion-fg :italic t))))
   `(font-lock-warning-face  ((,class (:inherit warning))))
   `(font-lock-preprocessor-face ((,class (:foreground ,orion-cyan))))
   `(font-lock-regexp-grouping-backslash ((,class (:foreground ,orion-purple-1))))
   `(font-lock-regexp-grouping-construct ((,class (:foreground ,orion-purple-1))))
   `(c-annotation-face ((,class (:inherit font-lock-constant-face))))

   ;; Line numbers
   `(line-number ((,class (:foreground ,orion-cyan))))
   `(line-number-current-line ((,class (:foreground ,orion-fg :background ,orion-bg+2))))

   ;; Latex
   `(font-latex ((,class (:inherit bold))))
   `(font-latex-warning ((,class (:inherit font-lock-warning-face))))
   `(font-latex-sectioning-5-face ((,class (:foreground ,orion-red :weight bold ))))
   `(font-latex-sedate-face ((,class (:foreground ,orion-yellow))))
   `(font-latex-italic-face ((,class (:foreground ,orion-cyan :italic t))))
   `(font-latex-string-face ((,class (:inherit font-lock-string-face))))
   `(font-latex-math-face ((,class (:foreground ,orion-orange))))
   `(font-latex-script-char-face ((,class (:foreground ,orion-orange))))

   ;; Company-mode TODO
   `(company-tooltip ((,class (:background ,orion-bg :box (:line-width -1 :color ,orion-cyan)))))
   `(company-tooltip-common ((,class (:inherit company-tooltip))))

   ;; diff
   `(diff-added ((,class (:foreground ,orion-green))))
   `(diff-changed ((,class (:foreground ,orion-yellow-1))))
   `(diff-removed ((,class (:foreground ,orion-red))))
   `(diff-header ((,class (:background ,orion-bg+1))))
   `(diff-file-header ((,class (:background ,orion-bg+2 :foreground ,orion-fg :wheight bold))))

   ;; eshell
   `(eshell-prompt ((,class (:foreground ,orion-cyan :weight bold))))
   `(eshell-ls-archive ((,class (:foreground ,orion-magenta :weight bold))))
   `(eshell-ls-backup ((,class (:inherit font-lock-comment))))
   `(eshell-ls-clutter ((,class (:inherit font-lock-comment))))
   `(eshell-ls-directory ((,class (:foreground ,orion-green :weight bold))))
   `(eshell-ls-executable ((,class (:foreground ,orion-red :weight bold))))
   `(eshell-ls-unreadable ((,class (:foreground ,orion-fg))))
   `(eshell-ls-missing ((,class (:inherit font-lock-warning))))
   `(eshell-ls-product ((,class (:inherit font-lock-doc))))
   `(eshell-ls-special ((,class (:foreground ,orion-yellow :weight bold))))
   `(eshell-ls-symlink ((,class (:foreground ,orion-cyan :weight bold))))

   ;; flycheck
   `(flycheck-error
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,orion-red) :inherit unspecified))
      (,class (:foreground ,orion-red :weight bold :underline t))))
   `(flycheck-warning
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,orion-yellow) :inherit unspecified))
      (,class (:foreground ,orion-yellow :weight bold :underline t))))
   `(flycheck-info
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,orion-cyan) :inherit unspecified))
      (,class (:foreground ,orion-cyan :weight bold :underline t))))
   `(flycheck-fringe-error ((,class (:foreground ,orion-red :weight bold))))
   `(flycheck-fringe-warning ((,class (:foreground ,orion-yellow :weight bold))))
   `(flycheck-fringe-info ((,class (:foreground ,orion-cyan :weight bold))))

   ;; flymake
   `(flymake-errline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,orion-red)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (,class (:foreground ,orion-red :weight bold :underline t))))
   `(flymake-warnline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,orion-orange)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (,class (:foreground ,orion-orange :weight bold :underline t))))
   `(flymake-infoline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,orion-cyan)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (,class (:foreground ,orion-cyan :weight bold :underline t))))
   `(flymake-error
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,orion-red)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (,class (:foreground ,orion-red :weight bold :underline t))))
   `(flymake-warning
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,orion-orange)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (,class (:foreground ,orion-orange :weight bold :underline t))))
   `(flymake-note
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,orion-cyan)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (,class (:foreground ,orion-cyan :weight bold :underline t))))

   ;; flyspell
   `(flyspell-duplicate
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,orion-orange) :inherit unspecified))
      (,class (:foreground ,orion-orange :weight bold :underline t))))
   `(flyspell-incorrect
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,orion-red) :inherit unspecified))
      (,class (:foreground ,orion-red :weight bold :underline t))))

   ;; helm
   `(helm-header
     ((,class (:foreground ,orion-cyan
                           :background ,orion-bg
                           :underline nil
                           :box nil))))
   `(helm-source-header
     ((,class (:foreground ,orion-yellow
                           :background ,orion-bg-1
                           :underline nil
                           :weight bold
                           :box (:line-width -1 :style released-button)))))
   `(helm-selection ((,class (:background ,orion-bg+1 :underline nil))))
   `(helm-selection-line ((,class (:background ,orion-bg+1))))
   `(helm-visible-mark ((,class (:foreground ,orion-bg :background ,orion-yellow-1))))
   `(helm-candidate-number ((,class (:foreground ,orion-green :background ,orion-bg-1))))
   `(helm-ff-directory ((,class (:foreground ,orion-pink :background ,orion-bg))))
   `(helm-ff-dotted-directory ((,class (:foreground ,orion-pink :background ,orion-bg))))

   ;; hydra
   `(hydra-face-red ((,class (:foreground ,orion-red :background ,orion-bg))))
   `(hydra-face-amaranth ((,class (:foreground ,orion-magenta :background ,orion-bg))))
   `(hydra-face-blue ((,class (:foreground ,orion-cyan :background ,orion-bg))))
   `(hydra-face-pink ((,class (:foreground ,orion-pink :background ,orion-bg))))
   `(hydra-face-teal ((,class (:foreground ,orion-teal :background ,orion-bg))))

   ;; ivy
   `(ivy-confirm-face ((,class (:foreground ,orion-green :background ,orion-bg))))
   `(ivy-current-match ((,class (:background ,orion-bg+2 :weight bold))))
   `(ivy-cursor ((,class (:foreground ,orion-bg :background ,orion-fg))))
   `(ivy-match-required-face ((,class (:foreground ,orion-red :background ,orion-bg))))
   `(ivy-minibuffer-match-face-1 ((,class (:background ,orion-bg+1))))
   `(ivy-remote ((,class (:foreground ,orion-cyan :background ,orion-bg))))
   `(ivy-subdir ((,class (:foreground ,orion-green+1 :background ,orion-bg))))

   ;; ido-mode
   `(ido-subdir ((,class (:foreground ,orion-green+1))))

   ;; magit headings and diffs
   `(magit-section-highlight ((,class (:background ,orion-bg+1))))
   `(magit-section-heading ((,class (:foreground ,orion-cyan :weight bold))))
   `(magit-section-heading-selection ((,class (:foreground ,orion-red+1 :weight bold))))
   `(magit-diff-file-heading           ((,class (:weight bold))))
   `(magit-diff-file-heading-highlight ((,class (:background ,orion-bg+2  :weight bold))))
   `(magit-diff-file-heading-selection ((,class (:background ,orion-bg+2
                                                        :foreground ,orion-cyan :weight bold))))
   `(magit-diff-hunk-heading           ((,class (:background ,orion-bg+1))))
   `(magit-diff-hunk-heading-highlight ((,class (:background ,orion-bg+2))))
   `(magit-diff-hunk-heading-selection ((,class (:background ,orion-bg+2
                                                        :foreground ,orion-cyan))))
   `(magit-diff-lines-heading          ((,class (:background ,orion-bg-1
                                                        :foreground ,orion-fg))))
   `(magit-diff-added                  ((,class (:foreground ,orion-green))))
   `(magit-diff-added-highlight        ((,class (:inherit magit-diff-added :weight bold))))
   `(magit-diff-removed                ((,class (:foreground ,orion-red+1))))
   `(magit-diff-removed-highlight      ((,class (:inherit magit-diff-removed :weight bold))))
   `(magit-diff-context                ((,class (:foreground ,orion-gray))))
   `(magit-diff-context-highlight      ((,class (:inherit magit-diff-context :weight bold))))
   `(magit-diffstat-added   ((,class (:inherit magit-diff-added))))
   `(magit-diffstat-removed ((,class (:inherit magit-diff-removed))))
   `(diff-refine-added ((,class (:background ,orion-green))))
   ;; magit popup
   `(magit-popup-heading             ((,class (:foreground ,orion-pink  :weight bold))))
   `(magit-popup-key                 ((,class (:foreground ,orion-cyan :weight bold))))
   `(magit-popup-argument            ((,class (:foreground ,orion-fg   :weight bold))))
   `(magit-popup-disabled-argument   ((,class (:foreground ,orion-fg    :weight normal))))
   `(magit-popup-option-value        ((,class (:foreground ,orion-orange  :weight bold))))
   ;; ;; magit process
   `(magit-process-ok    ((,class (:foreground ,orion-green  :weight bold))))
   `(magit-process-ng    ((,class (:foreground ,orion-pink    :weight bold))))
   ;; ;; magit log
   `(magit-log-author    ((,class (:foreground ,orion-pink))))
   `(magit-log-date      ((,class (:foreground ,orion-gray))))
   `(magit-log-graph     ((,class (:foreground ,orion-white-1))))
   ;; ;; magit sequence
   `(magit-sequence-pick ((,class (:foreground ,orion-magenta))))
   `(magit-sequence-stop ((,class (:foreground ,orion-green))))
   `(magit-sequence-part ((,class (:foreground ,orion-pink))))
   `(magit-sequence-head ((,class (:foreground ,orion-cyan-1))))
   `(magit-sequence-drop ((,class (:foreground ,orion-orange))))
   `(magit-sequence-done ((,class (:foreground ,orion-gray))))
   `(magit-sequence-onto ((,class (:foreground ,orion-gray))))
   ;; ;; magit bisect
   `(magit-bisect-good ((,class (:foreground ,orion-green))))
   `(magit-bisect-skip ((,class (:foreground ,orion-pink))))
   `(magit-bisect-bad  ((,class (:foreground ,orion-red+1))))
   ;; ;; magit blame
   `(magit-blame-heading ((,class (:background ,orion-bg+1 :foreground ,orion-green))))
   `(magit-blame-hash    ((,class (:background ,orion-bg+1 :foreground ,orion-green))))
   `(magit-blame-name    ((,class (:background ,orion-bg+1 :foreground ,orion-violet-1))))
   `(magit-blame-date    ((,class (:background ,orion-bg+1 :foreground ,orion-yellow-1))))
   `(magit-blame-summary ((,class (:background ,orion-bg+1 :foreground ,orion-cyan-1 :weight bold))))
   ;; ;; magit references etc
   `(magit-dimmed         ((,class (:foreground ,orion-bg+3))))
   `(magit-hash           ((,class (:foreground ,orion-bg+1))))
   `(magit-tag            ((,class (:foreground ,orion-violet-1 :weight bold))))
   `(magit-branch-remote  ((,class (:foreground ,orion-green  :weight bold))))
   `(magit-branch-local   ((,class (:foreground ,orion-cyan-1   :weight bold))))
   `(magit-branch-current ((,class (:foreground ,orion-orange   :weight bold :box t))))
   `(magit-head           ((,class (:foreground ,orion-cyan   :weight bold))))
   `(magit-refname        ((,class (:background ,orion-bg+2 :foreground ,orion-fg :weight bold))))
   `(magit-refname-stash  ((,class (:background ,orion-bg+2 :foreground ,orion-fg :weight bold))))
   `(magit-refname-wip    ((,class (:background ,orion-bg+2 :foreground ,orion-fg :weight bold))))
   `(magit-signature-good      ((,class (:foreground ,orion-green))))
   `(magit-signature-bad       ((,class (:foreground ,orion-red+1))))
   `(magit-signature-untrusted ((,class (:foreground ,orion-yellow-1))))
   `(magit-cherry-unmatched    ((,class (:foreground ,orion-cyan))))
   `(magit-cherry-equivalent   ((,class (:foreground ,orion-magenta))))
   `(magit-reflog-commit       ((,class (:foreground ,orion-green))))
   `(magit-reflog-amend        ((,class (:foreground ,orion-magenta))))
   `(magit-reflog-merge        ((,class (:foreground ,orion-green))))
   `(magit-reflog-checkout     ((,class (:foreground ,orion-cyan-1))))
   `(magit-reflog-reset        ((,class (:foreground ,orion-red+1))))
   `(magit-reflog-rebase       ((,class (:foreground ,orion-magenta))))
   `(magit-reflog-cherry-pick  ((,class (:foreground ,orion-green))))
   `(magit-reflog-remote       ((,class (:foreground ,orion-cyan))))
   `(magit-reflog-other        ((,class (:foreground ,orion-cyan))))

   ;; org-mode
   `(org-agenda-date-today
     ((,class (:foreground ,orion-cyan :italic t :weight bold))))
   `(org-agenda-structure
     ((,class (:inherit font-lock-comment-face))))
   `(org-archived ((,class (:foreground ,orion-fg :weight bold))))
   `(org-block ((,class (:background ,orion-bg-2 :extend t :inherit fixed-pitch))))
   `(org-block-begin-line ((,class (:foreground ,orion-gray :italic t :background ,orion-bg-2 :extend t :inherit fixed-pitch))))
   `(org-block-end-line ((,class (:foreground ,orion-gray :italic t :background ,orion-bg-2 :extend t :inherit fixed-pitch))))
   `(org-checkbox ((,class (:background ,orion-bg :foreground ,orion-cyan
                                        :box (:line-width 1 :style released-button :color ,orion-bg+3)))))
   `(org-verbatim ((,class (:foreground ,orion-green :inherit fixed-pitch))))
   `(org-date ((,class (:foreground ,orion-green :underline t))))
   `(org-deadline-announce ((,class (:foreground ,orion-red))))
   `(org-done ((,class (:weight bold :weight bold :foreground ,orion-green))))
   `(org-formula ((,class (:foreground ,orion-yellow))))
   `(org-headline-done ((,class (:foreground ,orion-green))))
   `(org-hide ((,class (:foreground ,orion-bg))))
   `(org-level-1 ((,class (:foreground ,orion-cyan :height 1.2 :font "Cantarell"))))
   `(org-level-2 ((,class (:foreground ,orion-green+1 :height 1.1 :font "Cantarell"))))
   `(org-level-3 ((,class (:foreground ,orion-magenta :height 1.05 :font "Cantarell"))))
   `(org-level-4 ((,class (:foreground ,orion-green :font "Cantarell"))))
   `(org-level-5 ((,class (:foreground ,orion-yellow :font "Cantarell"))))
   `(org-level-6 ((,class (:foreground ,orion-red+1 :font "Cantarell"))))
   `(org-level-7 ((,class (:foreground ,orion-yellow-1 :font "Cantarell"))))
   `(org-level-8 ((,class (:foreground ,orion-cyan-1 :font "Cantarell"))))
   `(org-link ((,class (:foreground ,orion-cyan :underline t))))
   `(org-quote ((,class (:foreground ,orion-fg :italic t))))
   `(org-scheduled ((,class (:foreground ,orion-green+1))))
   `(org-scheduled-previously ((,class (:foreground ,orion-red))))
   `(org-scheduled-today ((,class (:foreground ,orion-yellow))))
   `(org-sexp-date ((,class (:foreground ,orion-cyan :underline t))))
   `(org-special-keyword ((,class (:inherit font-lock-comment-face))))
   `(org-table ((,class (:foreground ,orion-green+1))))
   `(org-tag ((,class (:weight bold))))
   `(org-time-grid ((,class (:foreground ,orion-orange))))
   `(org-todo ((,class (:weight bold :foreground ,orion-orange :weight bold))))
   `(org-upcoming-deadline ((,class (:inherit font-lock-keyword-face))))
   `(org-warning ((,class (:weight bold :foreground ,orion-red :weight bold :underline nil))))
   `(org-column ((,class (:background ,orion-bg-1))))
   `(org-column-title ((,class (:background ,orion-bg-1 :underline t :weight bold))))
   `(org-mode-line-clock ((,class (:foreground ,orion-fg :background ,orion-bg-1))))
   `(org-mode-line-clock-overrun ((,class (:foreground ,orion-bg :background ,orion-red))))
   `(org-ellipsis ((,class (:foreground ,orion-gray))))
   `(org-footnote ((,class (:foreground ,orion-cyan :underline t))))
   `(org-document-title ((,class (:foreground ,orion-green :weight bold))))
   `(org-document-info ((,class (:foreground ,orion-green))))
   `(org-habit-ready-face ((,class (:background ,orion-green))))
   `(org-habit-alert-face ((,class (:background ,orion-yellow :foreground ,orion-bg))))
   `(org-habit-clear-face ((,class (:background ,orion-blue-1))))
   `(org-habit-overdue-face ((,class (:background ,orion-red))))
   `(org-habit-clear-future-face ((,class (:background ,orion-blue-1))))
   `(org-habit-ready-future-face ((,class (:background ,orion-green))))
   `(org-habit-alert-future-face ((,class (:background ,orion-yellow :foreground ,orion-bg))))
   `(org-habit-overdue-future-face ((,class (:background ,orion-red))))

   ;; org-ref
   `(org-ref-ref-face ((,class (:underline t))))
   `(org-ref-label-face ((,class (:underline t))))
   `(org-ref-cite-face ((,class (:underline t))))
   `(org-ref-glossary-face ((,class (:underline t))))
   `(org-ref-acronym-face ((,class (:underline t))))
   `(org-drawer ((,class (:foregrond ,orion-gray))))

   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((,class (:foreground ,orion-orange+1))))
   `(rainbow-delimiters-depth-2-face ((,class (:foreground ,orion-violet))))
   `(rainbow-delimiters-depth-3-face ((,class (:foreground ,orion-cyan))))
   `(rainbow-delimiters-depth-4-face ((,class (:foreground ,orion-orange))))
   `(rainbow-delimiters-depth-5-face ((,class (:foreground ,orion-green))))
   `(rainbow-delimiters-depth-6-face ((,class (:foreground ,orion-purple))))
   `(rainbow-delimiters-depth-7-face ((,class (:foreground ,orion-orange))))
   `(rainbow-delimiters-depth-8-face ((,class (:foreground ,orion-cyan-1))))
   `(rainbow-delimiters-depth-9-face ((,class (:foreground ,orion-gray))))

   ;; ansi-term
   `(term-color-black ((,class (:foreground ,orion-bg :background ,orion-bg-1))))
   `(term-color-red ((,class (:foreground ,orion-red+1 :background ,orion-red))))
   `(term-color-green ((,class (:foreground ,orion-green+1 :background ,orion-green))))
   `(term-color-yellow ((,class (:foreground ,orion-yellow-1 :background ,orion-yellow))))
   `(term-color-magenta ((,class (:foreground ,orion-magenta :background ,orion-red))))
   `(term-color-cyan ((,class (:foreground ,orion-cyan :background ,orion-cyan-1))))
   `(term-color-white ((,class (:foreground ,orion-fg :background ,orion-white-1))))

   ;; undo-tree
   `(undo-tree-visualizer-active-branch-face ((,class (:foreground ,orion-cyan+1 :weight bold))))
   `(undo-tree-visualizer-current-face ((,class (:foreground ,orion-cyan-1 :weight bold))))
   `(undo-tree-visualizer-default-face ((,class (:foreground ,orion-fg))))
   `(undo-tree-visualizer-register-face ((,class (:foreground ,orion-yellow))))
   `(undo-tree-visualizer-unmodified-face ((,class (:foreground ,orion-green))))

   ;;all-the-icons
   `(all-the-icons-blue       ((,class (:foreground ,orion-cyan))))
   `(all-the-icons-blue-alt   ((,class (:foreground ,orion-gray))))
   `(all-the-icons-cyan       ((,class (:foreground ,orion-cyan))))
   `(all-the-icons-cyan-alt   ((,class (:foreground ,orion-gray))))
   `(all-the-icons-dblue      ((,class (:foreground ,orion-cyan-1))))
   `(all-the-icons-dcyan      ((,class (:foreground ,orion-gray))))
   `(all-the-icons-dgreen     ((,class (:foreground ,orion-green))))
   `(all-the-icons-dorange    ((,class (:foreground ,orion-orange))))
   `(all-the-icons-dpink      ((,class (:foreground ,orion-pink))))
   `(all-the-icons-dpurple    ((,class (:foreground ,orion-purple))))
   `(all-the-icons-dred       ((,class (:foreground ,orion-red))))
   `(all-the-icons-dyellow    ((,class (:foreground ,orion-yellow))))
   `(all-the-icons-green      ((,class (:foreground ,orion-green))))
   `(all-the-icons-lblue      ((,class (:foreground ,orion-cyan-1))))
   `(all-the-icons-lcyan      ((,class (:foreground ,orion-cyan+1))))
   `(all-the-icons-maroon     ((,class (:foreground ,orion-magenta))))
   `(all-the-icons-orange     ((,class (:foreground ,orion-orange))))
   `(all-the-icons-pink       ((,class (:foreground ,orion-pink))))
   `(all-the-icons-purple     ((,class (:foreground ,orion-violet))))
   `(all-the-icons-purple-alt ((,class (:foreground ,orion-gray))))
   `(all-the-icons-red        ((,class (:foreground ,orion-red))))
   `(all-the-icons-red-alt    ((,class (:foreground ,orion-gray))))
   `(all-the-icons-yellow     ((,class (:foreground ,orion-yellow-1))))

))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'orion-blue)

;;; orion-blue-theme.el ends here
