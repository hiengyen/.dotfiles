local keymap = vim.keymap
local opts = { noremap = true, silent = true }

--Using jk, kj instead of ESC
keymap.set("i", "jk", "<ESC>", { desc = "esc" })
keymap.set("i", "kj", "<ESC>", { desc = "esc" })
keymap.set("v", "jk", "<ESC>", { desc = "esc" })
keymap.set("v", "kj", "<ESC>", { desc = "esc" })

--Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

--New tab
keymap.set("n", "te", ":tabedit", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<S-tab>", ":tabprev<Return>", opts)

--Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

--Move window
keymap.set("n", "sh", "<C-w>h", opts)
keymap.set("n", "sk", "<C-w>k", opts)
keymap.set("n", "sj", "<C-w>j", opts)
keymap.set("n", "sl", "<C-w>l", opts)

--Rezize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

--Diagnostics
keymap.set("n", "<C-j", function()
  vim.diagnostic.goto_next()
end, opts)
