-- General options. To see a full list use :help options
local opt = vim.opt

opt.autoindent = true     -- uses current indent if a new line is created
opt.expandtab = true      -- convert tabs to spaces
opt.tabstop = 4           -- number of spaces for each tab
opt.shiftwidth = 4        -- number of spaces for each automatic indentation
opt.list = true           -- show non printable characters
opt.listchars = { tab = "» ", trail = ".", nbsp = "␣" }
opt.smartindent = true    -- do smart indenting when startig a new line

opt.number = true         -- set numbered lines
opt.numberwidth = 2       -- minimal number of columns to use for the line number
opt.relativenumber = true -- set relative numbered lines
opt.signcolumn = "yes"    -- always show the sign column (column on the left where stuff e.g. git is shown)

opt.cursorline = true     -- highlight the current line
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250"
-- the configuration for the cursor in each mode

opt.backup = false      -- creates a backup file before overwriting it
opt.swapfile = false    -- creates a swapfile
opt.writebackup = false -- if a file is being edited by another program it is not allowed to be edited
opt.undofile = true     -- enable persistent undo

opt.linebreak = true    -- breaks the line at a charactre in 'breakat' rather than the last one
opt.showbreak = "> "    -- the string to put at the start of the wrapped line
opt.breakindent = true  -- every wrapped line continues visually indented
opt.wrap = true         -- display lines as one long line

opt.statusline = "%<%f%h%m%r%=%l:%c%V    %P"
opt.showmode = false                 -- we don't need to see things like -- INSERT -- anymore
opt.cmdheight = 1                    -- number of lines that the command takes up

opt.guifont = "ubuntumono:h17"       -- the font used in graphical neovim applications
opt.conceallevel = 0                 -- so that `` is visible in markdown files
opt.emoji = true                     -- whether emoji characters should be consider to be full width
opt.fileencoding = "utf-8"           -- the encoding written to a file
opt.termguicolors = true             -- set term gui colors (most terminals support this)

opt.hlsearch = true                  -- highlight all matches on previous search pattern
opt.ignorecase = true                -- ignore case in search patterns
opt.smartcase = true                 -- consider the case only if an upper case character is used

opt.completeopt = "menuone,noselect" -- how to show command completions (see documuntation for valid values)
opt.pumheight = 10                   -- max number of items in the popup menu

opt.mouse = "a"                      -- allow the mouse to be used in neovim
opt.mousehide = true                 -- hides the mouse while typing

opt.clipboard:append("unnamedplus")  -- allows neovim to access the system clipboard

opt.inccommand = "split"
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window

opt.showtabline = 2   -- whether the line with tab pages should be displayed (1 = only if more then one)

opt.scrolloff = 8     -- min number of lines to keep above and below the cursor
opt.sidescrolloff = 8

opt.timeout = false  -- whether current key combination should be discarded after a while
-- NOTE: If true uncomment the option below
-- opt.timeoutlen = 6000 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.updatetime = 300 -- faster completion (4000ms default)

opt.shortmess:append("c")

opt.whichwrap:append("<,>,[,],h,l")
opt.iskeyword:append("-")
vim.cmd("set formatoptions-=cro")
