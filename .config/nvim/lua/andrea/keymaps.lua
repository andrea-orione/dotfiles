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
vim.keymap.set("i" , "<C-c>", "<ESC>", { noremap = true })

-- Better file navigation
keymap("n", "<C-d>", "<C-d>zz", "Move down and center")
keymap("n", "<C-u>", "<C-u>zz", "Move up and center")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", "Move to the next buffer")
keymap("n", "<S-h>", ":bprevious<CR>", "Move to the previous buffer")

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", "Move line up")
keymap("n", "<A-k>", ":m .-2<CR>==", "Move line down")

-- Diagnostics
keymap("n", "<leader>dp", vim.diagnostic.goto_prev, "Go to [P]revious diagnostic message")
keymap("n", "<leader>dn", vim.diagnostic.goto_next, "Go to [N]ext diagnostic message")
keymap("n", "<leader>de", vim.diagnostic.open_float, "Show diagnostic [E]rror message")
keymap("n", "<leader>dq", vim.diagnostic.setloclist, "Open diagnostic [Q]quickfix list")

-- Buffer and operations
keymap("n", "<leader>w", "<cmd>w!<CR>", "Save")
keymap("n", "<leader>c", "<cmd>bdelete!<CR>", "[C]lose Buffer")
-- keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", "No [H]ighlight")

-- Commands
keymap("n", "<leader>xm", "<cmd>!chmod +x %<CR>", "[M]ake this file e[X]ecutable")
keymap("n", "<leader>xx", "<cmd>so %<CR>", "E[X]ecute this file")

-- Insert --
-- Press jk fast to exit insert mode
-- keymap("i", "jk", "<ESC>", "Exit insert mode")
-- keymap("i", "kj", "<ESC>", "Exit insert mode")

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
