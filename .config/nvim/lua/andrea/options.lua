-- OPTION FILE
-- In this file will be set some general options. To see a full list use :help options
local o = vim.opt
o.backup = false                          -- creates a backup file before overwriting it
o.autoindent = true                       -- uses current indent if a new line is created
o.breakindent = true                      -- every wrapped line continues visually indented
o.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
o.cmdheight = 1                           -- number of lines that the command takes up
o.completeopt = "menuone,noselect"     -- how to show command completions (see documuntation for valid values)
o.conceallevel = 0                        -- so that `` is visible in markdown files
o.cursorline = true                       -- highlight the current line
o.emoji = true                            -- whether emoji characters should be consider to be full width
o.expandtab = true                        -- convert tabs to spaces
o.fileencoding = "utf-8"                  -- the encoding written to a file
o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250"
                                                -- the configuration for the cursor in each mode
o.guifont = "ubuntumono:h17"              -- the font used in graphical neovim applications
o.hlsearch = false                        -- highlight all matches on previous search pattern
o.ignorecase = true                       -- ignore case in search patterns
o.linebreak = true                        -- breaks the line at a charactre in 'breakat' rather than the last one
o.mouse = "a"                             -- allow the mouse to be used in neovim
o.mousehide = true                        -- hides the mouse while typing
o.number = true                           -- set numbered lines
o.numberwidth = 2                         -- minimal number of columns to use for the line number
o.pumheight = 10                          -- max number of items in the popup menu
o.relativenumber = true                   -- set relative numbered lines
o.scrolloff = 8                           -- min number of lines to keep above and below the cursor
o.shiftwidth = 4                          -- the number of spaces inserted for each indentation
o.showbreak = "> "                        -- the string to put at the start of the wrapped line
o.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
o.showtabline = 2                         -- whether the line with tab pages should be displayed (1 = only if more then one)
o.sidescrolloff = 8
o.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
o.smartcase = true                        -- consider the case only if an upper case character is used
o.smartindent = true                      -- do smart indenting when startig a new line
o.splitbelow = true                       -- force all horizontal splits to go below current window
o.splitright = true                       -- force all vertical splits to go to the right of current window
o.statusline = "%<%f%h%m%r%=%l:%c%V    %P"
o.swapfile = false                        -- creates a swapfile
o.tabstop = 2                             -- insert 2 spaces for a tab
o.termguicolors = true                    -- set term gui colors (most terminals support this)
o.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
o.undofile = true                         -- enable persistent undo
o.updatetime = 300                        -- faster completion (4000ms default)
o.wrap = true                             -- display lines as one long line
o.writebackup = false                     -- if a file is being edited by another program it is not allowed to be edited

o.shortmess:append "c"

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
