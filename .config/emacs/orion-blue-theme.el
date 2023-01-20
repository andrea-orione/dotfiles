;;    ____     ____
;;  /  __  \ /  __  \
;; |  |__|  |  |  |  |  Andrea Orione
;; |   __   |  |  |  |  https://www.github.com/andrea-orione
;; |  |  |  |  |__|  |
;; |__|  |__|\ ____ / 

;; Orion blue, my personal theme

;; This theme requires doom theme for semplicity, maybe one day I will do it as a standalone
(require 'doom-themes)

;; Definition of the group
(defgroup orion-blue-theme nil
  "Options for the `orion-dark' theme."
  :group 'doom-themes)


;; THEME DEFINITION
(def-doom-theme orion-blue
  "My personal theme focused on shades of blue and cyan"

  ;; Variable definition
  ;; Colors
  ;; name           default   256       16
  ((white        '("#FFFFFF" "#FFFFFF" "white"))
   (grey         '("#999999" "#999999" "grey"))
   (red          '("#D30102" "#D30102" "red"))
   (orange       '("#FF961F" "#FF961F" "brightred"))
   (light-orange '("#FFCA28" "#FFCA28" "orange"))
   (green        '("#00B70A" "#00B70A" "green"))
   (light-green  '("#A6E22E" "#A6E22E" "brightgreen"))
   (yellow       '("#D7BA7D" "#DDBB77" "brightyellow"))
   (light-yellow '("#D9DAA2" "#DDDDAA" "brightyellow"))
   (pink         '("#FF8CB6" "#FF8CB6" "pink"))
   (magenta      '("#F92672" "#F92672" "brightmagenta"))
   (violet       '("#F07178" "#F07178" "brightviolet"))
   (dark-violet  '("#C792EA" "#C792EA" "violet"))
   (purple       '("#8B049C" "#8B049C" "brightpurple"))
   (dark-purple  '("#6C00D9" "#6C00D9" "purple"))
   (dark-blue    '("#040520" "#040520" "blue"))
   (light-cyan   '("#00E1FF" "#00E1FF" "brightcyan"))
   (cyan         '("#00BFF9" "#00BFF9" "brigthcyan"))
   (dark-cyan    '("#219FD5" "#219FD5" "cyan"))
   (teal         '("#35CDAF" "#33CCAA" "brightgreen"))
   (blue         cyan)
   ;;Shades
   (bg         '("#011627" "#011627" nil)) ;; Modified
   (bg-alt     '("#252526" "#222222"  nil))
   (base0      '("#171F24" "#111122"   "black")) ;; Cheked does nothing important
   (base1      '("#1C1C1C" "#1C1C1C" "brightblack"))
   (base2      '("#041020" "#041020" "blue")) ;; Modified
   (base3      '("#313131" "#3a3a3a" "brightblack"))
   (base4      '("#4b474c" "#444444" "brightblack"))
   (base5      '("#37474F" "#585858" "brightblack"))
   (base6      '("#103362" "#103362" "brightblack"))
   (base7      grey) ;;modified
   (base8      '("#f4f4f4" "#a8a8a8" "white"))
   (fg         '("#A7DBF7" "#A7DBF7" "brightwhite"))  ;; Modified
   (fg-alt     '("#C7DBF7" "#C7DBF7" "white"))
   ;; face categories
   (highlight      base6)
   (vertical-bar   bg-alt)
   (selection      base4)
   (builtin        orange)
   (comments       grey)
   (doc-comments   base7)
   (constants      dark-violet)
   (functions      light-green)
   (keywords       cyan)
   (methods        light-yellow)
   (operators      cyan)
   (type           purple)
   (strings        green)
   (variables      fg)
   (numbers        dark-purple)
   (region         (doom-darken base6 0.1))
   (error          red)
   (warning        light-orange)
   (success        light-green)
   (vc-modified    dark-cyan)
   (vc-added       green)
   (vc-deleted     red)
   ;; custom categories
   (modeline-bg     dark-blue)
   (modeline-bg-alt (doom-darken bg 0.1))
   (modeline-fg     light-cyan)
   (modeline-fg-alt base5))


  ;; BASE THEME OVERRIDE
  ((lazy-highlight :background base4 :foreground fg :distant-foreground fg :weight 'bold)
   (mode-line
    :background modeline-bg :foreground modeline-fg)
   (mode-line-inactive
    :background modeline-bg-alt :foreground modeline-fg-alt)
   (mode-line-emphasis
    :foreground cyan 
    :weight 'bold)

   ((line-number &override) :foreground cyan)
   ((line-number-current-line &override) :foreground fg :background base6)

   (cursor :backround yellow)
   (minibuffer-prompt :foreground cyan)
   (link :foreground cyan :underline t :weight 'bold)

   (org-link :foreground cyan :underline t :weight 'bold)
   
   ;;;; all-the-icons
   (all-the-icons-dblue :foreground blue)
   ;;;; centaur-tabs
   (centaur-tabs-active-bar-face :background base6)
   (centaur-tabs-selected-modified
    :inherit 'centaur-tabs-selected :foreground fg :weight 'bold)
   (centaur-tabs-unselected-modified
    :inherit 'centaur-tabs-unselected :foreground fg :weight 'bold)
   (centaur-tabs-modified-marker-selected
    :inherit 'centaur-tabs-selected :foreground fg)
   (centaur-tabs-modified-marker-unselected
    :inherit 'centaur-tabs-unselected :foreground fg)
   ;;;; company
   (company-tooltip-selection     :background region)
   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; dashboard
   (dashboard-heading :foreground green :weight 'bold)
   ;;;; dired-k
   (dired-k-commited :foreground base4)
   (dired-k-modified :foreground vc-modified)
   (dired-k-ignored :foreground cyan)
   (dired-k-added    :foreground vc-added)
   ;;;; doom-modeline
   (doom-modeline-bar :background base6)
   (doom-modeline-buffer-file :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-major-mode :inherit 'doom-modeline-buffer-path)
   (doom-modeline-buffer-modified :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-debug :inherit 'mode-line-emphasis)
   (doom-modeline-evil-insert-state :foreground purple)
   (doom-modeline-evil-visual-state :foreground yellow)
   (doom-modeline-info :inherit 'mode-line-emphasis)
   (doom-modeline-lsp-success :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-persp-name :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-project-dir :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-project-parent-dir :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-urgent :inherit 'mode-line-emphasis)
   (doom-modeline-warning :inherit 'mode-line-emphasis)
   ;;;; ivy
   (counsel-active-mode :foreground (doom-lighten base6 0.1))
   (ivy-minibuffer-match-face-2 :foreground (doom-lighten base6 0.1) :weight 'extra-bold)
   ;;;; js2-mode
   (js2-jsdoc-tag              :foreground magenta)
   (js2-object-property        :foreground cyan)
   (js2-object-property-access :foreground cyan)
   (js2-function-param         :foreground violet)
   (js2-jsdoc-type             :foreground base8)
   (js2-jsdoc-value            :foreground cyan)
   ;;;; lsp-mode
   (lsp-lens-face              :foreground base7 :height 0.8)
   (lsp-face-semhl-number :foreground purple)
   ;;;; man <built-in>
   (Man-overstrike :inherit 'bold :foreground magenta)
   (Man-underline :inherit 'underline :foreground blue)
   ;;;; org <built-in>
   ((org-block &override) :background base2)
   ((org-block-background &override) :background base2)
   ((org-block-begin-line &override) :background base2)
   ;;;; org-pomodoro
   (org-pomodoro-mode-line :inherit 'mode-line-emphasis) ; unreadable otherwise
   (org-pomodoro-mode-line-overtime :inherit 'org-pomodoro-mode-line)
   (org-pomodoro-mode-line-break :inherit 'org-pomodoro-mode-line)
   ;;;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground light-orange)
   (rainbow-delimiters-depth-2-face :foreground violet)
   (rainbow-delimiters-depth-3-face :foreground green)
   (rainbow-delimiters-depth-4-face :foreground purple)
   (rainbow-delimiters-depth-5-face :foreground dark-cyan)
   (rainbow-delimiters-depth-6-face :foreground light-green)
   ;;;; rjsx-mode
   (rjsx-tag :foreground blue)
   (rjsx-attr :foreground cyan :slant 'italic :weight 'medium)
   ;;;; tooltip
   (tooltip :background base2 :foreground fg)
   ;;;; treemacs
   (treemacs-root-face :foreground fg :weight 'ultra-bold :height 1.2)
   (doom-themes-treemacs-root-face :foreground fg :weight 'ultra-bold :height 1.2)
   (doom-themes-treemacs-file-face :foreground fg)
   (treemacs-directory-face :foreground fg)
   (treemacs-git-modified-face :foreground blue)))

;;; doom-dark+-theme.el ends here
