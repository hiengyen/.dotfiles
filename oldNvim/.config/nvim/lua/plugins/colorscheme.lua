return {
  { "Mofiqul/dracula.nvim" },

  lazy = true,
  priority = 1000,
  opts = function()
    return { transparent = true }
  end,
  background = "light",

  -- Configure LazyVim to load theme
  { "LazyVim/LazyVim", opts = {
    colorscheme = "dracula",
  } },
}
