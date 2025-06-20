local colorscheme = require("plugins.colorscheme")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugin
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
    },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.lsp.none-ls" },
    --import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    lazy = true,
    version = false,
  },
  checker = { enabled = false}, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
