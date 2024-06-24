-- General keybindings. To see a full list use <SPACE>sk

-- Shorten function name
local keymap = function(mode, keys, func, description)
    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = description })
end

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", " ")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Escape from search results
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>")

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", "Move focus to the left window")
keymap("n", "<C-j>", "<C-w>j", "Move focus to the upper window")
keymap("n", "<C-k>", "<C-w>k", "Move focus to the lower window")
keymap("n", "<C-l>", "<C-w>l", "Move focus to the right window")

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", "Resize upwards")
keymap("n", "<C-Down>", ":resize +2<CR>", "Resize downwards")
keymap("n", "<C-Left>", ":vertical resize -2<CR>", "Resize to the left")
keymap("n", "<C-Right>", ":vertical resize +2<CR>", "Resize to the right")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", "Move to the next buffer")
keymap("n", "<S-h>", ":bprevious<CR>", "Move to the previous buffer")

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", "Move line up")
keymap("n", "<A-k>", ":m .-2<CR>==", "Move line down")

-- Diagnostics
-- TODO: Consider changing them
keymap("n", "<leader>dp", vim.diagnostic.goto_next, "Go to [P]revious diagnostic message")
keymap("n", "<leader>dn", vim.diagnostic.goto_prev, "Go to [N]ext diagnostic message")
keymap("n", "<leader>de", vim.diagnostic.open_float, "Show diagnostic [E]rror message") -- Maybe "<leader>e"
keymap("n", "<leader>dq", vim.diagnostic.setloclist, "Open diagnostic [Q]quickfix list")

-- Buffer and operations
keymap("n", "<leader>w", "<cmd>w!<CR>", "Save")
keymap("n", "<leader>c", "<cmd>Bdelete!<CR>", "[C]lose Buffer")
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", "No [H]ighlight")

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", "Exit insert mode")
keymap("i", "kj", "<ESC>", "Exit insert mode")

-- Move in insert mode using CTRL+hljk
keymap("i", "<C-h>", "<left>", "Move left")
keymap("i", "<C-l>", "<right>", "Move right")
keymap("i", "<C-k>", "<up>", "Move up")
keymap("i", "<C-j>", "<down>", "Move down")

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", "Increase indentation level")
keymap("v", ">", ">gv^", "Decrease indentation level")

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move line up")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move line down")
keymap("v", "p", '"_dP', "Delete selected region and paste")

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", "Move line up")
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", "Move line down")
