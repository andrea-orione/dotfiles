" Vim color file
" Maintainer:	Andrea Orione 
" Last Change:	2022 Jul 15

" orionblue

set bg=dark
hi clear
if exists("syntax_on")
	syntax reset
endif

let colors_name = "orionblue"

hi Normal		guifg=#ffffff guibg=#001026						ctermfg=white ctermbg=darkblue
hi ErrorMsg		guifg=#ffffff guibg=#a60000						ctermfg=white ctermbg=darkred
hi Visual		guifg=#103362 guibg=fg		gui=none			ctermfg=lightblue ctermbg=fg cterm=reverse
hi VisualNOS	guifg=#103362 guibg=fg		gui=none,underline	ctermfg=lightblue ctermbg=fg cterm=reverse,underline
hi Todo			guifg=#d14a14 guibg=#1248d1						ctermfg=lightgrey	ctermbg=darkyellow
hi Search		guifg=#90fff0 guibg=#2050d0						ctermfg=white ctermbg=lightblue cterm=underline term=underline
hi IncSearch	guifg=#b0ffff guibg=#2050d0						ctermfg=darkblue ctermbg=gray

hi SpecialKey		guifg=cyan			ctermfg=darkcyan
hi Directory		guifg=cyan			ctermfg=cyan
hi Title			guifg=magenta gui=none ctermfg=magenta cterm=bold
hi WarningMsg		guifg=red			ctermfg=red
hi WildMenu			guifg=yellow guibg=black ctermfg=yellow ctermbg=black cterm=none term=none
hi ModeMsg			guifg=#22cce2		ctermfg=lightblue
hi MoreMsg			ctermfg=darkgreen	ctermfg=darkgreen
hi Question			guifg=green gui=none ctermfg=green cterm=none
hi NonText			guifg=#0030ff		ctermfg=darkblue

hi StatusLine	guifg=blue guibg=darkgray gui=none		ctermfg=blue ctermbg=gray term=none cterm=none
hi StatusLineNC	guifg=black guibg=darkgray gui=none		ctermfg=black ctermbg=gray term=none cterm=none
hi VertSplit	guifg=black guibg=darkgray gui=none		ctermfg=black ctermbg=gray term=none cterm=none

hi Folded		guifg=#808080 	guibg=#000040		ctermfg=darkgrey 	ctermbg=darkblue 	cterm=bold 		term=bold
hi FoldColumn	guifg=#808080 	guibg=#000040		ctermfg=darkgrey 	ctermbg=darkblue 	cterm=bold 		term=bold
hi LineNr		guifg=#219fd5						ctermfg=lightblue 						cterm=none

hi DiffAdd	guibg=darkblue	ctermbg=darkblue term=none cterm=none
hi DiffChange	guibg=darkmagenta ctermbg=magenta cterm=none
hi DiffDelete	ctermfg=blue ctermbg=cyan gui=bold guifg=Blue guibg=DarkCyan
hi DiffText	cterm=bold ctermbg=red gui=bold guibg=Red

hi Cursor	guifg=black guibg=yellow ctermfg=black ctermbg=yellow
hi lCursor	guifg=black guibg=white ctermfg=black ctermbg=white


hi Comment		guifg=#999999 		gui=italic		ctermfg=lightgrey		cterm=italic
hi Constant		guifg=#00d011 						ctermfg=green       	cterm=none
hi Special		guifg=Orange 		gui=none 		ctermfg=brown 			cterm=none
hi Identifier	guifg=#40ffff						ctermfg=cyan	 		cterm=none
hi Statement	guifg=#ffff60 		gui=none 		ctermfg=yellow 			cterm=none 
hi PreProc		guifg=#ff80ff 		gui=none 		ctermfg=magenta 		cterm=none
hi type			guifg=#60ff60 		gui=none 		ctermfg=green 			cterm=none
hi Underlined																cterm=underline term=underline
hi Ignore		guifg=bg 							ctermfg=bg

" suggested by tigmoid, 2008 Jul 18
hi Pmenu 		guifg=#c0c0c0 		guibg=#404080
hi PmenuSel 	guifg=#c0c0c0 		guibg=#2050d0
hi PmenuSbar 	guifg=blue 			guibg=darkgray
hi PmenuThumb 	guifg=#c0c0c0
