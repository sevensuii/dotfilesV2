-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua Add any additional keymaps here

vim.keymap.set("i", "<C-d>", "<C-d>zz")
vim.keymap.set("i", "<C-u>", "<C-u>zz")
vim.keymap.set("i", "<C-b>", "<C-o>de")

----- Tmux Navigation ------
local nvim_tmux_nav = require("nvim-tmux-navigation")

vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

----- Harpoon 2 -----
local harpoon = require("harpoon")
local telescope = require("telescope")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>h", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Show harpoons" })

vim.keymap.set("n", "<leader>a", function()
    harpoon:list():add()
end, { desc = "Add harpoon mark" })

vim.keymap.set("n", "<leader>d", function()
    harpoon:list():remove()
end, { desc = "Del harpoon mark" })

vim.keymap.set("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<leader>D", function()
    harpoon:list():clear()
end, { desc = "Clear harpoon marks" })

vim.keymap.set("n", "<C-M-h>", function()
    harpoon:list():select(1)
end)

vim.keymap.set("n", "<C-M-j>", function()
    harpoon:list():select(2)
end)

vim.keymap.set("n", "<C-M-k>", function()
    harpoon:list():select(3)
end)

vim.keymap.set("n", "<C-M-l>", function()
    harpoon:list():select(4)
end)

-- vim.keymap.set("n", "<leader>H", function()
--     require("alpha").start(false, require("alpha").default_config)
-- end, { noremap = true, desc = "Homescreen" })
vim.api.nvim_set_keymap("n", "<leader>H", ":Dashboard<CR>", { noremap = true, desc = "Dashboard" })

-- File browser
vim.api.nvim_set_keymap(
    "n",
    "<leader>B",
    ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { noremap = true, desc = "File browser" }
)

-- Go to definition remap (doesnt work for now because is too fast for file to load)
-- vim.api.nvim_set_keymap("n", "gv", ":vsplit<CR>gd", { noremap = true, silent = true, desc = "Definition Right Split" })

-- Git branches
vim.api.nvim_set_keymap("n", "<leader>gB", ":Telescope git_branches<CR>", { noremap = true, desc = "Branches" })

-- Disable key mappings in insert mode
vim.api.nvim_set_keymap("i", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-k>", "<Nop>", { noremap = true, silent = true })

-- Disable key mappings in normal mode
vim.api.nvim_set_keymap("n", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", "<Nop>", { noremap = true, silent = true })

-- Disable key mappings in visual block mode
vim.api.nvim_set_keymap("x", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-k>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "J", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "K", "<Nop>", { noremap = true, silent = true })
